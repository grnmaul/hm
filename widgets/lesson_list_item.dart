import 'package:flutter/material.dart';
import '../providers/course_provider.dart';
import '../utils/constants.dart';

class LessonListItem extends StatelessWidget {
  final Lesson lesson;
  final int index;
  final bool isActive;
  final bool isLocked;
  final VoidCallback onTap;

  const LessonListItem({
    Key? key,
    required this.lesson,
    required this.index,
    this.isActive = false,
    this.isLocked = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isActive 
            ? AppColors.primary.withOpacity(0.1) 
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive 
              ? AppColors.primary 
              : Colors.grey[200]!,
          width: isActive ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLocked ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getStatusColor(),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: _getStatusIcon(),
                  ),
                ),
                const SizedBox(width: 16),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isLocked 
                              ? Colors.grey[400] 
                              : AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        lesson.formattedDuration,
                        style: TextStyle(
                          fontSize: 14,
                          color: isLocked 
                              ? Colors.grey[400] 
                              : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                
                if (isLocked)
                  Icon(
                    Icons.lock,
                    color: Colors.grey[400],
                    size: 20,
                  )
                else if (lesson.isCompleted)
                  const Icon(
                    Icons.check_circle,
                    color: AppColors.success,
                    size: 20,
                  )
                else if (isActive)
                  Icon(
                    Icons.play_circle_filled,
                    color: AppColors.primary,
                    size: 24,
                  )
                else
                  Icon(
                    Icons.play_circle_outline,
                    color: Colors.grey[400],
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getStatusColor() {
    if (isLocked) {
      return Colors.grey[200]!;
    } else if (lesson.isCompleted) {
      return AppColors.success.withOpacity(0.1);
    } else if (isActive) {
      return AppColors.primary.withOpacity(0.1);
    } else {
      return Colors.grey[100]!;
    }
  }

  Widget _getStatusIcon() {
    if (isLocked) {
      return Icon(
        Icons.lock,
        color: Colors.grey[400],
        size: 16,
      );
    } else if (lesson.isCompleted) {
      return const Icon(
        Icons.check,
        color: AppColors.success,
        size: 16,
      );
    } else if (isActive) {
      return Icon(
        Icons.play_arrow,
        color: AppColors.primary,
        size: 20,
      );
    } else {
      return Text(
        index.toString().padLeft(2, '0'),
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey[600],
        ),
      );
    }
  }
}
