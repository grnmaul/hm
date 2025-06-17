import 'package:flutter/material.dart';
import '../utils/constants.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final Color color;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (MediaQuery.of(context).size.width - 64) / 2,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon Container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: _buildIcon(),
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 4),
            
            // Subtitle or course count
            Text(
              _getSubtitle(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 24,
      height: 24,
      child: Image.asset(
        iconPath,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to appropriate icon based on title
          IconData iconData;
          Color iconColor;
          
          switch (title.toLowerCase()) {
            case 'matematika':
            case 'mathematics':
              iconData = Icons.calculate;
              iconColor = Colors.blue[700]!;
              break;
            case 'fisika':
            case 'physics':
              iconData = Icons.science;
              iconColor = Colors.purple[700]!;
              break;
            case 'kimia':
            case 'chemistry':
              iconData = Icons.biotech;
              iconColor = Colors.green[700]!;
              break;
            case 'biologi':
            case 'biology':
              iconData = Icons.eco;
              iconColor = Colors.orange[700]!;
              break;
            case 'bahasa inggris':
            case 'english':
              iconData = Icons.language;
              iconColor = Colors.indigo[700]!;
              break;
            case 'sejarah':
            case 'history':
              iconData = Icons.history_edu;
              iconColor = Colors.brown[700]!;
              break;
            default:
              iconData = Icons.school;
              iconColor = AppColors.primary;
          }
          
          return Icon(
            iconData,
            size: 24,
            color: iconColor,
          );
        },
      ),
    );
  }

  Color _getIconColor() {
    switch (title.toLowerCase()) {
      case 'matematika':
      case 'mathematics':
        return Colors.blue[700]!;
      case 'fisika':
      case 'physics':
        return Colors.purple[700]!;
      case 'kimia':
      case 'chemistry':
        return Colors.green[700]!;
      case 'biologi':
      case 'biology':
        return Colors.orange[700]!;
      case 'bahasa inggris':
      case 'english':
        return Colors.indigo[700]!;
      case 'sejarah':
      case 'history':
        return Colors.brown[700]!;
      default:
        return AppColors.primary;
    }
  }

  String _getSubtitle() {
    switch (title.toLowerCase()) {
      case 'matematika':
      case 'mathematics':
        return '12 courses';
      case 'fisika':
      case 'physics':
        return '8 courses';
      case 'kimia':
      case 'chemistry':
        return '6 courses';
      case 'biologi':
      case 'biology':
        return '10 courses';
      case 'bahasa inggris':
      case 'english':
        return '15 courses';
      case 'sejarah':
      case 'history':
        return '5 courses';
      default:
        return 'Available courses';
    }
  }
}