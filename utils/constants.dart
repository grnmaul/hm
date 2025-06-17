import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryBlue = Color(0xFF4285F4);
  static const Color secondaryBlue = Color(0xFF1976D2);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFF44336);
  static const Color lightGray = Color(0xFFF5F5F5);
  static const Color mediumGray = Color(0xFFE0E0E0);
  static const Color darkGray = Color(0xFF424242);
  
  // Additional colors for better design
  static const Color primary = Color(0xFF4A6FFF);
  static const Color secondary = Color(0xFFFF8A65);
  static const Color background = Color(0xFFF5F9FF);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB74D);
  static const Color info = Color(0xFF2196F3);
  
  // Subject colors
  static const Color mathColor = Color(0xFFFFE0E0);
  static const Color physicsColor = Color(0xFFE0F7FF);
  static const Color chemistryColor = Color(0xFFE0FFE3);
  static const Color biologyColor = Color(0xFFFFF4E0);
  static const Color englishColor = Color(0xFFE8E0FF);
  
  // Premium colors
  static const Color premiumGold = Color(0xFFFFD700);
  static const Color premiumGradientStart = Color(0xFF6C5CE7);
  static const Color premiumGradientEnd = Color(0xFF4A6FFF);
}

class AppSizes {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  static const double borderRadius = 12.0;
  static const double borderRadiusLarge = 20.0;

  static const double buttonHeight = 50.0;
  static const double textFieldHeight = 56.0;
}

class AppAssets {
  // Onboarding images
  static const String onboarding1 = 'assets/images/onboarding_1.png';
  static const String onboarding2 = 'assets/images/onboarding_2.png';
  static const String onboarding3 = 'assets/images/onboarding_3.png';
  
  // Subject icons
  static const String mathIcon = 'assets/icons/matematika_icon.png';
  static const String physicsIcon = 'assets/icons/fisika_icon.png';
  static const String chemistryIcon = 'assets/icons/kimia_icon.png';
  static const String biologyIcon = 'assets/icons/biologi_icon.png';
  static const String englishIcon = 'assets/icons/bahasa_inggris_icon.png';
  
  // Course thumbnails
  static const String mathThumbnail = 'https://via.placeholder.com/280x120/2196F3/FFFFFF?text=Mathematics';
  static const String physicsThumbnail = 'https://via.placeholder.com/280x120/9C27B0/FFFFFF?text=Physics';
  static const String chemistryThumbnail = 'https://via.placeholder.com/280x120/4CAF50/FFFFFF?text=Chemistry';
  static const String biologyThumbnail = 'https://via.placeholder.com/280x120/FF9800/FFFFFF?text=Biology';
  static const String historyThumbnail = 'https://via.placeholder.com/280x120/795548/FFFFFF?text=History';
  static const String englishThumbnail = 'https://via.placeholder.com/280x120/673AB7/FFFFFF?text=English';
  
  // Other assets
  static const String successIcon = 'https://via.placeholder.com/80x80/4CAF50/FFFFFF?text=✓';
  static const String subscriptionIcon = 'https://via.placeholder.com/80x80/4A6FFF/FFFFFF?text=⭐';
  static const String userPlaceholder = 'https://via.placeholder.com/100x100/E0E0E0/757575?text=User';
  
  // Social icons
  static const String googleIcon = 'https://via.placeholder.com/24x24/DB4437/FFFFFF?text=G';
  static const String facebookIcon = 'https://via.placeholder.com/24x24/4267B2/FFFFFF?text=f';
}

class AppStrings {
  static const String appName = 'E-Learning';
  static const String welcomeTitle = 'Belajar Kapan Saja,\ndi Mana Saja';
  static const String welcomeSubtitle = 'Akses berbagai materi berkualitas\nlangsung dari perangkatmu';

  static const String findTopicTitle = 'Temukan\nTopik Favoritmu';
  static const String findTopicSubtitle = 'Dapatkan wawasan baru\ndari berbagai bidang ilmu';

  static const String lifestyleTitle = 'Jadikan Ilmu\nsebagai Gaya Hidup';
  static const String lifestyleSubtitle = 'Belajar setiap hari\nuntuk masa depan yang lebih cerah';
  
  // Auth
  static const String login = 'Masuk';
  static const String signup = 'Daftar';
  static const String email = 'Email Anda';
  static const String password = 'Kata Sandi';
  static const String name = 'Nama Anda';
  static const String forgotPassword = 'Lupa kata sandi?';
  static const String dontHaveAccount = 'Belum punya akun?';
  static const String alreadyHaveAccount = 'Sudah punya akun?';
  static const String createAccount = 'Buat Akun';
  static const String termsAndConditions = 'Dengan membuat akun, Anda menyetujui Syarat & Ketentuan kami';
  static const String success = 'Berhasil!';
  static const String successMessage = 'Akun Anda telah berhasil dibuat.';
  static const String done = 'Selesai';
  
  // Home
  static const String greeting = 'Halo, ';
  static const String whatToLearn = 'Apa yang ingin Anda\npelajari hari ini?';
  static const String getStarted = 'Mulai Belajar';
  static const String learningPlan = 'Rencana Belajar';
  static const String subscribe = 'Berlangganan';
  static const String subscribeDesc = 'Buka semua kursus premium.\nBerlangganan sekarang dan jelajahi semua kursus tanpa batas!';
  
  // Courses
  static const String courses = 'Kursus';
  static const String myCourses = 'Kursus Saya';
  static const String chooseYourCourse = 'Pilih kursus Anda';
  static const String popular = 'Populer';
  static const String newest = 'Terbaru';
  static const String free = 'Gratis';
  static const String premium = 'Premium';
  static const String aboutThisCourse = 'Tentang kursus ini';
  static const String welcomeToTheCourse = 'Selamat datang di Kursus';
  static const String completed = 'Selesai';
  static const String startLearning = 'Mulai Belajar';
  static const String continueLearning = 'Lanjutkan Belajar';
  static const String enrollNow = 'Daftar Sekarang';
  static const String watchPreview = 'Tonton Preview';
  
  // Subjects
  static const String mathematics = 'Matematika';
  static const String physics = 'Fisika';
  static const String chemistry = 'Kimia';
  static const String biology = 'Biologi';
  static const String english = 'Bahasa Inggris';
  static const String history = 'Sejarah';
  
  // Search
  static const String search = 'Cari';
  static const String searchCourses = 'Cari kursus...';
  static const String recentSearches = 'Pencarian Terbaru';
  static const String popularSearches = 'Pencarian Populer';
  static const String noResults = 'Tidak ada hasil ditemukan';
  static const String searchResults = 'Hasil Pencarian';
  
  // Messages & Notifications
  static const String notifications = 'Notifikasi';
  static const String messages = 'Pesan';
  static const String noNotifications = 'Tidak ada notifikasi';
  static const String markAllAsRead = 'Tandai semua sebagai dibaca';
  static const String message = 'pesan';
  static const String notification = 'notifikasi';
  
  // Account
  static const String account = 'Akun';
  static const String profile = 'Profil';
  static const String favorite = 'Favorit';
  static const String editAccount = 'Edit Akun';
  static const String settingsAndPrivacy = 'Pengaturan dan Privasi';
  static const String help = 'Bantuan';
  static const String logout = 'Keluar';
  static const String darkMode = 'Mode Gelap';
  static const String language = 'Bahasa';
  static const String aboutApp = 'Tentang Aplikasi';
  
  // Subscription
  static const String subscriptionPlans = 'Paket Berlangganan';
  static const String monthlyPlan = 'Paket Bulanan';
  static const String yearlyPlan = 'Paket Tahunan';
  static const String currentPlan = 'Paket Saat Ini';
  static const String upgradePlan = 'Upgrade Paket';
  static const String cancelSubscription = 'Batalkan Berlangganan';
  static const String renewSubscription = 'Perpanjang Berlangganan';
  
  // Currency
  static const String currency = 'Rp';
  static const String pricePerMonth = '/bulan';
  static const String pricePerYear = '/tahun';
  
  // General
  static const String loading = 'Memuat...';
  static const String retry = 'Coba Lagi';
  static const String cancel = 'Batal';
  static const String confirm = 'Konfirmasi';
  static const String save = 'Simpan';
  static const String edit = 'Edit';
  static const String delete = 'Hapus';
  static const String share = 'Bagikan';
  static const String download = 'Unduh';
  static const String upload = 'Unggah';
}

class AppPrices {
  // Subscription prices in Indonesian Rupiah
  static const int monthlyPrice = 99000; // Rp 99,000
  static const int yearlyPrice = 999000; // Rp 999,000 (save 2 months)
  static const int lifetimePrice = 2999000; // Rp 2,999,000
  
  // Course prices
  static const int basicCoursePrice = 149000; // Rp 149,000
  static const int premiumCoursePrice = 299000; // Rp 299,000
  static const int masterCoursePrice = 499000; // Rp 499,000
}

// Utility class for formatting Indonesian currency
class CurrencyFormatter {
  static String formatRupiah(int amount) {
    String formatted = amount.toString();
    
    // Add thousand separators
    if (formatted.length > 3) {
      String result = '';
      int count = 0;
      
      for (int i = formatted.length - 1; i >= 0; i--) {
        if (count == 3) {
          result = '.$result';
          count = 0;
        }
        result = formatted[i] + result;
        count++;
      }
      formatted = result;
    }
    
    return 'Rp $formatted';
  }
  
  static String formatRupiahWithPeriod(int amount, String period) {
    return '${formatRupiah(amount)}$period';
  }
}
