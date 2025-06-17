import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/course_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/course_grid_item.dart';
import '../../widgets/course_list_item.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../routes/app_routes.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isGridView = true;
  String _selectedCategory = 'Semua';
  String _selectedDifficulty = 'Semua';
  String _sortBy = 'Terbaru';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as String?;
    if (category != null && _selectedCategory != category) {
      _selectedCategory = category;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.courses),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterBottomSheet(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Semua'),
            Tab(text: AppStrings.popular),
            Tab(text: AppStrings.newest),
            Tab(text: AppStrings.free),
          ],
        ),
      ),
      body: Consumer2<CourseProvider, SubscriptionProvider>(
        builder: (context, courseProvider, subscriptionProvider, child) {
          return TabBarView(
            controller: _tabController,
            children: [
              _buildCourseList(courseProvider.getFilteredCourses(), subscriptionProvider),
              _buildCourseList(courseProvider.popularCourses, subscriptionProvider),
              _buildCourseList(courseProvider.newestCourses, subscriptionProvider),
              _buildCourseList(courseProvider.freeCourses, subscriptionProvider),
            ],
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildCourseList(List<Course> courses, SubscriptionProvider subscriptionProvider) {
    if (courses.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 64,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 16),
            Text(
              'Tidak ada kursus ditemukan',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: _isGridView
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return CourseGridItem(
                  course: course,
                  onTap: () => _navigateToCourseDetail(context, course, subscriptionProvider),
                );
              },
            )
          : ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CourseListItem(
                    course: course,
                    onTap: () => _navigateToCourseDetail(context, course, subscriptionProvider),
                  ),
                );
              },
            ),
    );
  }

  void _navigateToCourseDetail(BuildContext context, Course course, SubscriptionProvider subscriptionProvider) {
    // Check if user has access to premium course
    if (course.isPremium && !subscriptionProvider.isPremiumUser) {
      _showPremiumDialog(context, course);
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.courseDetail,
      arguments: course.id,
    );
  }

  void _showPremiumDialog(BuildContext context, Course course) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kursus Premium'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kursus "${course.title}" adalah kursus premium.'),
            const SizedBox(height: 8),
            const Text('Berlangganan untuk mengakses semua kursus premium dan fitur eksklusif lainnya.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/subscription');
            },
            child: const Text(AppStrings.subscribe),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Header
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Filter & Urutkan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            Expanded(
              child: Consumer<CourseProvider>(
                builder: (context, courseProvider, child) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category filter
                        const Text(
                          'Kategori',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: courseProvider.categories.map((category) {
                            final isSelected = courseProvider.selectedCategory == category;
                            return FilterChip(
                              label: Text(category),
                              selected: isSelected,
                              onSelected: (selected) {
                                courseProvider.setCategory(category);
                              },
                              selectedColor: AppColors.primary.withValues(alpha: 0.2),
                              checkmarkColor: AppColors.primary,
                            );
                          }).toList(),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Difficulty filter
                        const Text(
                          'Tingkat Kesulitan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: courseProvider.difficulties.map((difficulty) {
                            final isSelected = courseProvider.selectedDifficulty == difficulty;
                            return FilterChip(
                              label: Text(difficulty),
                              selected: isSelected,
                              onSelected: (selected) {
                                courseProvider.setDifficulty(difficulty);
                              },
                              selectedColor: AppColors.primary.withValues(alpha: 0.2),
                              checkmarkColor: AppColors.primary,
                            );
                          }).toList(),
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Sort options
                        const Text(
                          'Urutkan Berdasarkan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...courseProvider.sortOptions.map((option) {
                          final isSelected = courseProvider.sortBy == option;
                          return RadioListTile<String>(
                            title: Text(option),
                            value: option,
                            groupValue: courseProvider.sortBy,
                            onChanged: (value) {
                              if (value != null) {
                                courseProvider.setSortBy(value);
                              }
                            },
                            activeColor: AppColors.primary,
                            contentPadding: EdgeInsets.zero,
                          );
                        }).toList(),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Apply button
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Terapkan Filter',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
