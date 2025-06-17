import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/subscription_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../routes/app_routes.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.account),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer3<AuthProvider, ThemeProvider, SubscriptionProvider>(
        builder: (context, authProvider, themeProvider, subscriptionProvider, child) {
          final user = authProvider.user;
          
          return SingleChildScrollView(
            child: Column(
              children: [
                // Profile section
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  color: Colors.white,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: AppColors.primary.withOpacity(0.1),
                        child: Text(
                          user?.name?.substring(0, 1).toUpperCase() ?? 'U',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.name ?? 'User',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user?.email ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (subscriptionProvider.isPremiumUser) ...[
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [AppColors.premiumGradientStart, AppColors.premiumGradientEnd],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: AppColors.premiumGold, size: 16),
                              SizedBox(width: 4),
                              Text(
                                'Premium Member',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Menu items
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.school,
                        title: AppStrings.myCourses,
                        onTap: () => Navigator.pushNamed(context, AppRoutes.myCourses),
                      ),
                      _buildMenuItem(
                        icon: Icons.favorite,
                        title: AppStrings.favorite,
                        onTap: () {
                          // Navigate to favorites
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.star,
                        title: AppStrings.subscriptionPlans,
                        onTap: () => Navigator.pushNamed(context, '/subscription'),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Settings
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      _buildMenuItem(
                        icon: Icons.person,
                        title: AppStrings.editAccount,
                        onTap: () {
                          // Navigate to edit profile
                        },
                      ),
                      _buildSwitchMenuItem(
                        icon: Icons.dark_mode,
                        title: AppStrings.darkMode,
                        value: themeProvider.isDarkMode,
                        onChanged: (value) => themeProvider.toggleTheme(),
                      ),
                      _buildMenuItem(
                        icon: Icons.language,
                        title: AppStrings.language,
                        subtitle: 'Bahasa Indonesia',
                        onTap: () {
                          // Navigate to language settings
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.help,
                        title: AppStrings.help,
                        onTap: () {
                          // Navigate to help
                        },
                      ),
                      _buildMenuItem(
                        icon: Icons.info,
                        title: AppStrings.aboutApp,
                        onTap: () {
                          // Show about dialog
                        },
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Logout
                Container(
                  color: Colors.white,
                  child: _buildMenuItem(
                    icon: Icons.logout,
                    title: AppStrings.logout,
                    textColor: AppColors.error,
                    onTap: () => _showLogoutDialog(context, authProvider),
                  ),
                ),
                
                const SizedBox(height: 100),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavBar(currentIndex: 4),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? AppColors.textPrimary),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  Widget _buildSwitchMenuItem({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar'),
        content: const Text('Apakah Anda yakin ingin keluar dari akun?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await authProvider.logout();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.splash,
                  (route) => false,
                );
              }
            },
            child: const Text(
              AppStrings.logout,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}