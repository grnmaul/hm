import 'package:flutter/material.dart';
import '../utils/constants.dart';

class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String thumbnailUrl;
  final String category;
  final double rating;
  final int totalLessons;
  final int completedLessons;
  final bool isEnrolled;
  final bool isPremium;
  final int price;
  final String difficulty;
  final int duration; // in minutes
  final List<Lesson> lessons;
  final List<String> tags;
  final DateTime createdAt;
  final bool isFavorite;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    required this.thumbnailUrl,
    required this.category,
    required this.rating,
    required this.totalLessons,
    required this.completedLessons,
    required this.isEnrolled,
    required this.isPremium,
    required this.price,
    required this.difficulty,
    required this.duration,
    required this.lessons,
    required this.tags,
    required this.createdAt,
    this.isFavorite = false,
  });

  double get progress => totalLessons > 0 ? completedLessons / totalLessons : 0;
  
  String get formattedPrice => price == 0 ? AppStrings.free : CurrencyFormatter.formatRupiah(price);
  
  String get formattedDuration {
    if (duration < 60) {
      return '$duration menit';
    } else {
      final hours = duration ~/ 60;
      final minutes = duration % 60;
      return minutes > 0 ? '${hours}j ${minutes}m' : '${hours}j';
    }
  }
}

class Lesson {
  final String id;
  final String title;
  final String description;
  final String videoUrl;
  final int duration;
  final bool isCompleted;
  final bool isLocked;
  final String type; // video, quiz, reading
  final int order;

  Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.duration,
    required this.isCompleted,
    required this.isLocked,
    required this.type,
    required this.order,
  });
  
  String get formattedDuration {
    final minutes = duration ~/ 60;
    final seconds = duration % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class CourseProvider with ChangeNotifier {
  final List<Course> _courses = [
    Course(
      id: '1',
      title: 'Matematika Dasar untuk Pemula',
      description: 'Pelajari dasar-dasar matematika dengan mudah dan menyenangkan. Kursus ini dirancang khusus untuk pemula yang ingin memahami konsep matematika fundamental.',
      instructor: 'Dr. Ahmad Matematika',
      thumbnailUrl: AppAssets.mathThumbnail,
      category: AppStrings.mathematics,
      rating: 4.8,
      totalLessons: 12,
      completedLessons: 3,
      isEnrolled: true,
      isPremium: false,
      price: 0,
      difficulty: 'Pemula',
      duration: 480, // 8 hours
      tags: ['matematika', 'dasar', 'pemula', 'angka'],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      lessons: [
        Lesson(
          id: '1',
          title: 'Selamat Datang di Kursus Matematika',
          description: 'Pengenalan kursus dan apa yang akan Anda pelajari',
          videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          duration: 300,
          isCompleted: true,
          isLocked: false,
          type: 'video',
          order: 1,
        ),
        Lesson(
          id: '2',
          title: 'Logika Matematika Dasar',
          description: 'Memahami konsep logika dalam matematika',
          videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          duration: 450,
          isCompleted: false,
          isLocked: false,
          type: 'video',
          order: 2,
        ),
        Lesson(
          id: '3',
          title: 'Operasi Bilangan',
          description: 'Belajar operasi dasar: tambah, kurang, kali, bagi',
          videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          duration: 380,
          isCompleted: false,
          isLocked: true,
          type: 'video',
          order: 3,
        ),
      ],
    ),
    Course(
      id: '2',
      title: 'Fisika Modern dan Aplikasinya',
      description: 'Jelajahi dunia fisika modern dengan pendekatan praktis dan aplikasi nyata dalam kehidupan sehari-hari.',
      instructor: 'Prof. Sarah Fisika',
      thumbnailUrl: AppAssets.physicsThumbnail,
      category: AppStrings.physics,
      rating: 4.6,
      totalLessons: 15,
      completedLessons: 7,
      isEnrolled: true,
      isPremium: true,
      price: AppPrices.premiumCoursePrice,
      difficulty: 'Menengah',
      duration: 720, // 12 hours
      tags: ['fisika', 'modern', 'aplikasi', 'sains'],
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      lessons: [
        Lesson(
          id: '1',
          title: 'Pengenalan Fisika Modern',
          description: 'Sejarah dan perkembangan fisika modern',
          videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          duration: 320,
          isCompleted: true,
          isLocked: false,
          type: 'video',
          order: 1,
        ),
        Lesson(
          id: '2',
          title: 'Hukum Newton dan Aplikasinya',
          description: 'Memahami hukum Newton dalam kehidupan sehari-hari',
          videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          duration: 410,
          isCompleted: true,
          isLocked: false,
          type: 'video',
          order: 2,
        ),
      ],
    ),
    Course(
      id: '3',
      title: 'Kimia Organik Lengkap',
      description: 'Pelajari kimia organik dari dasar hingga mahir dengan eksperimen virtual dan studi kasus nyata.',
      instructor: 'Dr. Budi Kimia',
      thumbnailUrl: AppAssets.chemistryThumbnail,
      category: AppStrings.chemistry,
      rating: 4.5,
      totalLessons: 18,
      completedLessons: 2,
      isEnrolled: false,
      isPremium: true,
      price: AppPrices.masterCoursePrice,
      difficulty: 'Lanjutan',
      duration: 900, // 15 hours
      tags: ['kimia', 'organik', 'eksperimen', 'laboratorium'],
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      lessons: [
        Lesson(
          id: '1',
          title: 'Pengenalan Kimia Organik',
          description: 'Dasar-dasar kimia organik dan struktur molekul',
          videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
          duration: 350,
          isCompleted: false,
          isLocked: false,
          type: 'video',
          order: 1,
        ),
      ],
    ),
    Course(
      id: '4',
      title: 'Biologi Sel dan Molekuler',
      description: 'Eksplorasi mendalam tentang kehidupan di tingkat sel dan molekul dengan teknologi terkini.',
      instructor: 'Prof. Sari Biologi',
      thumbnailUrl: AppAssets.biologyThumbnail,
      category: AppStrings.biology,
      rating: 4.7,
      totalLessons: 14,
      completedLessons: 0,
      isEnrolled: false,
      isPremium: true,
      price: AppPrices.premiumCoursePrice,
      difficulty: 'Menengah',
      duration: 600, // 10 hours
      tags: ['biologi', 'sel', 'molekuler', 'genetika'],
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      lessons: [],
    ),
    Course(
      id: '5',
      title: 'English for Academic Purposes',
      description: 'Tingkatkan kemampuan bahasa Inggris akademik Anda untuk studi lanjut dan karir internasional.',
      instructor: 'Ms. Linda English',
      thumbnailUrl: AppAssets.englishThumbnail,
      category: AppStrings.english,
      rating: 4.9,
      totalLessons: 20,
      completedLessons: 0,
      isEnrolled: false,
      isPremium: false,
      price: 0,
      difficulty: 'Menengah',
      duration: 800, // 13+ hours
      tags: ['english', 'academic', 'writing', 'speaking'],
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      lessons: [],
    ),
  ];

  List<String> _searchHistory = [];
  String _selectedCategory = 'Semua';
  String _selectedDifficulty = 'Semua';
  String _sortBy = 'Terbaru';

  List<Course> get courses => _courses;
  List<Course> get enrolledCourses => _courses.where((course) => course.isEnrolled).toList();
  List<Course> get favoriteCourses => _courses.where((course) => course.isFavorite).toList();
  List<Course> get popularCourses => [..._courses]..sort((a, b) => b.rating.compareTo(a.rating));
  List<Course> get newestCourses => [..._courses]..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  List<Course> get freeCourses => _courses.where((course) => course.price == 0).toList();
  List<Course> get premiumCourses => _courses.where((course) => course.isPremium).toList();
  
  List<String> get searchHistory => _searchHistory;
  String get selectedCategory => _selectedCategory;
  String get selectedDifficulty => _selectedDifficulty;
  String get sortBy => _sortBy;
  
  List<String> get categories => [
    'Semua',
    AppStrings.mathematics,
    AppStrings.physics,
    AppStrings.chemistry,
    AppStrings.biology,
    AppStrings.english,
  ];
  
  List<String> get difficulties => ['Semua', 'Pemula', 'Menengah', 'Lanjutan'];
  List<String> get sortOptions => ['Terbaru', 'Populer', 'Rating Tertinggi', 'Harga Terendah'];
  
  List<Course> getFilteredCourses() {
    List<Course> filtered = List.from(_courses);
    
    // Filter by category
    if (_selectedCategory != 'Semua') {
      filtered = filtered.where((course) => course.category == _selectedCategory).toList();
    }
    
    // Filter by difficulty
    if (_selectedDifficulty != 'Semua') {
      filtered = filtered.where((course) => course.difficulty == _selectedDifficulty).toList();
    }
    
    // Sort
    switch (_sortBy) {
      case 'Populer':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Rating Tertinggi':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Harga Terendah':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Terbaru':
      default:
        filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }
    
    return filtered;
  }
  
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
  
  void setDifficulty(String difficulty) {
    _selectedDifficulty = difficulty;
    notifyListeners();
  }
  
  void setSortBy(String sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }
  
  List<Course> searchCourses(String query) {
    if (query.isEmpty) return [];
    
    // Add to search history
    if (!_searchHistory.contains(query)) {
      _searchHistory.insert(0, query);
      if (_searchHistory.length > 10) {
        _searchHistory.removeLast();
      }
      notifyListeners();
    }
    
    return _courses.where((course) => 
      course.title.toLowerCase().contains(query.toLowerCase()) ||
      course.description.toLowerCase().contains(query.toLowerCase()) ||
      course.category.toLowerCase().contains(query.toLowerCase()) ||
      course.instructor.toLowerCase().contains(query.toLowerCase()) ||
      course.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()))
    ).toList();
  }
  
  void clearSearchHistory() {
    _searchHistory.clear();
    notifyListeners();
  }
  
  Course getCourseById(String id) {
    return _courses.firstWhere((course) => course.id == id);
  }
  
  void enrollCourse(String courseId) {
    final index = _courses.indexWhere((course) => course.id == courseId);
    if (index != -1) {
      final course = _courses[index];
      _courses[index] = Course(
        id: course.id,
        title: course.title,
        description: course.description,
        instructor: course.instructor,
        thumbnailUrl: course.thumbnailUrl,
        category: course.category,
        rating: course.rating,
        totalLessons: course.totalLessons,
        completedLessons: course.completedLessons,
        isEnrolled: true,
        isPremium: course.isPremium,
        price: course.price,
        difficulty: course.difficulty,
        duration: course.duration,
        lessons: course.lessons,
        tags: course.tags,
        createdAt: course.createdAt,
        isFavorite: course.isFavorite,
      );
      notifyListeners();
    }
  }
  
  void toggleFavorite(String courseId) {
    final index = _courses.indexWhere((course) => course.id == courseId);
    if (index != -1) {
      final course = _courses[index];
      _courses[index] = Course(
        id: course.id,
        title: course.title,
        description: course.description,
        instructor: course.instructor,
        thumbnailUrl: course.thumbnailUrl,
        category: course.category,
        rating: course.rating,
        totalLessons: course.totalLessons,
        completedLessons: course.completedLessons,
        isEnrolled: course.isEnrolled,
        isPremium: course.isPremium,
        price: course.price,
        difficulty: course.difficulty,
        duration: course.duration,
        lessons: course.lessons,
        tags: course.tags,
        createdAt: course.createdAt,
        isFavorite: !course.isFavorite,
      );
      notifyListeners();
    }
  }
  
  void markLessonAsCompleted(String courseId, String lessonId) {
    final courseIndex = _courses.indexWhere((course) => course.id == courseId);
    if (courseIndex != -1) {
      final course = _courses[courseIndex];
      final lessonIndex = course.lessons.indexWhere((lesson) => lesson.id == lessonId);
      
      if (lessonIndex != -1) {
        final updatedLessons = [...course.lessons];
        updatedLessons[lessonIndex] = Lesson(
          id: updatedLessons[lessonIndex].id,
          title: updatedLessons[lessonIndex].title,
          description: updatedLessons[lessonIndex].description,
          videoUrl: updatedLessons[lessonIndex].videoUrl,
          duration: updatedLessons[lessonIndex].duration,
          isCompleted: true,
          isLocked: updatedLessons[lessonIndex].isLocked,
          type: updatedLessons[lessonIndex].type,
          order: updatedLessons[lessonIndex].order,
        );
        
        // Unlock next lesson
        if (lessonIndex + 1 < updatedLessons.length) {
          updatedLessons[lessonIndex + 1] = Lesson(
            id: updatedLessons[lessonIndex + 1].id,
            title: updatedLessons[lessonIndex + 1].title,
            description: updatedLessons[lessonIndex + 1].description,
            videoUrl: updatedLessons[lessonIndex + 1].videoUrl,
            duration: updatedLessons[lessonIndex + 1].duration,
            isCompleted: updatedLessons[lessonIndex + 1].isCompleted,
            isLocked: false,
            type: updatedLessons[lessonIndex + 1].type,
            order: updatedLessons[lessonIndex + 1].order,
          );
        }
        
        _courses[courseIndex] = Course(
          id: course.id,
          title: course.title,
          description: course.description,
          instructor: course.instructor,
          thumbnailUrl: course.thumbnailUrl,
          category: course.category,
          rating: course.rating,
          totalLessons: course.totalLessons,
          completedLessons: course.completedLessons + 1,
          isEnrolled: course.isEnrolled,
          isPremium: course.isPremium,
          price: course.price,
          difficulty: course.difficulty,
          duration: course.duration,
          lessons: updatedLessons,
          tags: course.tags,
          createdAt: course.createdAt,
          isFavorite: course.isFavorite,
        );
        
        notifyListeners();
      }
    }
  }
}
