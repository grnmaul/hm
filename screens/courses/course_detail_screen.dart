import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/course_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/lesson_list_item.dart';
import '../../routes/app_routes.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courseId = ModalRoute.of(context)?.settings.arguments as String?;
    
    if (courseId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(
          child: Text('Course ID not found'),
        ),
      );
    }

    return Consumer2<CourseProvider, SubscriptionProvider>(
      builder: (context, courseProvider, subscriptionProvider, child) {
        Course? course;
        try {
          course = courseProvider.getCourseById(courseId);
        } catch (e) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(
              child: Text('Course not found'),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          body: CustomScrollView(
            slivers: [
              // App Bar with course thumbnail
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                backgroundColor: AppColors.primary,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Course thumbnail
                      course.thumbnailUrl.startsWith('http')
                          ? Image.network(
                              course.thumbnailUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildPlaceholderImage(course!);
                              },
                            )
                          : Image.asset(
                              course.thumbnailUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return _buildPlaceholderImage(course!);
                              },
                            ),
                      
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      
                      // Course info overlay
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (course.isPremium)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.warning,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Premium',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 8),
                            Text(
                              course.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              course.instructor,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Course content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course stats
                      Row(
                        children: [
                          _buildStatItem(Icons.star, course.rating.toString()),
                          const SizedBox(width: 20),
                          _buildStatItem(Icons.play_circle_outline, '${course.totalLessons} lessons'),
                          const SizedBox(width: 20),
                          _buildStatItem(Icons.access_time, course.formattedDuration),
                        ],
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Course description
                      const Text(
                        AppStrings.aboutThisCourse,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        course.description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                          height: 1.5,
                        ),
                      ),
                      
                      const SizedBox(height: 24),
                      
                      // Course progress (if enrolled)
                      if (course.isEnrolled) ...[
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Progress Anda',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    '${(course.progress * 100).round()}%',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              LinearProgressIndicator(
                                value: course.progress,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${course.completedLessons} dari ${course.totalLessons} pelajaran selesai',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      
                      // Lessons list
                      const Text(
                        'Daftar Pelajaran',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      if (course.lessons.isNotEmpty)
                        ...course.lessons.asMap().entries.map((entry) {
                          final index = entry.key;
                          final lesson = entry.value;
                          final isLocked = lesson.isLocked && !course!.isEnrolled;
                          
                          return LessonListItem(
                            lesson: lesson,
                            index: index + 1,
                            isLocked: isLocked,
                            onTap: () {
                              if (!isLocked) {
                                Navigator.pushNamed(
                                  context,
                                  AppRoutes.coursePlayer,
                                  arguments: <String, String>{
                                    'courseId': course!.id,
                                    'lessonId': lesson.id,
                                  },
                                );
                              }
                            },
                          );
                        }).toList()
                      else
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Pelajaran akan segera tersedia',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      
                      const SizedBox(height: 100), // Space for bottom button
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Bottom action button
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: SafeArea(
              child: _buildActionButton(context, course, subscriptionProvider),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderImage(Course course) {
    return Container(
      color: AppColors.primary.withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school,
              size: 64,
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            Text(
              course.category,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, Course course, SubscriptionProvider subscriptionProvider) {
    // Check if user has access to premium course
    if (course.isPremium && !subscriptionProvider.isPremiumUser) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.lock, color: AppColors.warning),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Kursus premium memerlukan berlangganan',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.warning,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          PrimaryButton(
            text: AppStrings.subscribe,
            onPressed: () {
              Navigator.pushNamed(context, '/subscription');
            },
          ),
        ],
      );
    }

    if (course.isEnrolled) {
      return PrimaryButton(
        text: course.progress > 0 ? AppStrings.continueLearning : AppStrings.startLearning,
        onPressed: () {
          if (course.lessons.isNotEmpty) {
            // Find first incomplete lesson or first lesson
            final nextLesson = course.lessons.firstWhere(
              (lesson) => !lesson.isCompleted,
              orElse: () => course.lessons.first,
            );
            
            Navigator.pushNamed(
              context,
              AppRoutes.coursePlayer,
              arguments: <String, String>{
                'courseId': course.id,
                'lessonId': nextLesson.id,
              },
            );
          }
        },
      );
    } else {
      return PrimaryButton(
        text: course.price == 0 ? AppStrings.enrollNow : 'Beli ${course.formattedPrice}',
        onPressed: () {
          context.read<CourseProvider>().enrollCourse(course.id);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Berhasil mendaftar ke kursus ${course.title}'),
              backgroundColor: AppColors.success,
            ),
          );
        },
      );
    }
  }
}