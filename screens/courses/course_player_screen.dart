import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../providers/course_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/lesson_list_item.dart';

class CoursePlayerScreen extends StatefulWidget {
  const CoursePlayerScreen({Key? key}) : super(key: key);

  @override
  State<CoursePlayerScreen> createState() => _CoursePlayerScreenState();
}

class _CoursePlayerScreenState extends State<CoursePlayerScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializePlayer();
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void _initializePlayer() async {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    
    Map<String, String>? args;
    if (arguments is Map<String, String>) {
      args = arguments;
    } else if (arguments is Map) {
      // Convert Map to Map<String, String>
      args = Map<String, String>.from(arguments);
    }
    
    if (args == null) {
      setState(() {
        _error = 'Invalid arguments';
        _isLoading = false;
      });
      return;
    }

    final courseId = args['courseId'];
    final lessonId = args['lessonId'];

    if (courseId == null || lessonId == null) {
      setState(() {
        _error = 'Course ID or Lesson ID not found';
        _isLoading = false;
      });
      return;
    }

    try {
      final courseProvider = context.read<CourseProvider>();
      final course = courseProvider.getCourseById(courseId);
      final lesson = course.lessons.firstWhere((l) => l.id == lessonId);

      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(lesson.videoUrl),
      );

      await _videoPlayerController!.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
        placeholder: Container(
          color: Colors.black,
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error,
                    color: Colors.white,
                    size: 48,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading video',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.white70, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      );

      setState(() {
        _isLoading = false;
      });

      // Listen for video completion
      _videoPlayerController!.addListener(() {
        if (_videoPlayerController!.value.position >= _videoPlayerController!.value.duration) {
          _markLessonAsCompleted(courseId, lessonId);
        }
      });

    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _markLessonAsCompleted(String courseId, String lessonId) {
    context.read<CourseProvider>().markLessonAsCompleted(courseId, lessonId);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pelajaran selesai!'),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
  
    Map<String, String>? args;
    if (arguments is Map<String, String>) {
      args = arguments;
    } else if (arguments is Map) {
      args = Map<String, String>.from(arguments);
    }
  
    if (args == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Invalid arguments')),
      );
    }

    final courseId = args['courseId']!;
    final lessonId = args['lessonId']!;

    return Consumer<CourseProvider>(
      builder: (context, courseProvider, child) {
        Course? course;
        Lesson? currentLesson;
        
        try {
          course = courseProvider.getCourseById(courseId);
          currentLesson = course.lessons.firstWhere((l) => l.id == lessonId);
        } catch (e) {
          return Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Course or lesson not found')),
          );
        }

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              currentLesson.title,
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.playlist_play, color: Colors.white),
                onPressed: () => _showLessonsList(context, course!, currentLesson!),
              ),
            ],
          ),
          body: Column(
            children: [
              // Video player
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  color: Colors.black,
                  child: _buildVideoPlayer(),
                ),
              ),
              
              // Lesson info
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentLesson.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 16,
                              color: AppColors.textSecondary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              currentLesson.formattedDuration,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 16),
                            if (currentLesson.isCompleted)
                              Row(
                                children: [
                                  const Icon(
                                    Icons.check_circle,
                                    size: 16,
                                    color: AppColors.success,
                                  ),
                                  const SizedBox(width: 4),
                                  const Text(
                                    'Selesai',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.success,
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Deskripsi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          currentLesson.description,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // Next lesson button
                        if (_getNextLesson(course, currentLesson) != null)
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () => _playNextLesson(course!, currentLesson!),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Pelajaran Selanjutnya',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVideoPlayer() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              color: Colors.white,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'Error loading video',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _error = null;
                  _isLoading = true;
                });
                _initializePlayer();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_chewieController != null) {
      return Chewie(controller: _chewieController!);
    }

    return const Center(
      child: Text(
        'Video not available',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Lesson? _getNextLesson(Course course, Lesson currentLesson) {
    final currentIndex = course.lessons.indexWhere((l) => l.id == currentLesson.id);
    if (currentIndex != -1 && currentIndex < course.lessons.length - 1) {
      return course.lessons[currentIndex + 1];
    }
    return null;
  }

  void _playNextLesson(Course course, Lesson currentLesson) {
    final nextLesson = _getNextLesson(course, currentLesson);
    if (nextLesson != null) {
      Navigator.pushReplacementNamed(
        context,
        '/course-player',
        arguments: <String, String>{
          'courseId': course.id,
          'lessonId': nextLesson.id,
        },
      );
    }
  }

  void _showLessonsList(BuildContext context, Course course, Lesson currentLesson) {
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
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    'Daftar Pelajaran',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: course.lessons.length,
                itemBuilder: (context, index) {
                  final lesson = course.lessons[index];
                  final isActive = lesson.id == currentLesson.id;
                  
                  return LessonListItem(
                    lesson: lesson,
                    index: index + 1,
                    isActive: isActive,
                    onTap: () {
                      Navigator.pop(context);
                      if (lesson.id != currentLesson.id) {
                        Navigator.pushReplacementNamed(
                          context,
                          '/course-player',
                          arguments: <String, String>{
                            'courseId': course.id,
                            'lessonId': lesson.id,
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}