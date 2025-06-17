import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

enum SubscriptionType { none, monthly, yearly, lifetime }

class SubscriptionPlan {
  final SubscriptionType type;
  final String name;
  final String description;
  final int price;
  final String period;
  final List<String> features;
  final bool isPopular;
  final int? discountPercent;

  SubscriptionPlan({
    required this.type,
    required this.name,
    required this.description,
    required this.price,
    required this.period,
    required this.features,
    this.isPopular = false,
    this.discountPercent,
  });

  String get formattedPrice => CurrencyFormatter.formatRupiahWithPeriod(price, period);
  String get originalPrice => discountPercent != null 
      ? CurrencyFormatter.formatRupiah((price * (100 + discountPercent!) / 100).round())
      : '';
}

class SubscriptionProvider with ChangeNotifier {
  SubscriptionType _currentSubscription = SubscriptionType.none;
  DateTime? _subscriptionEndDate;
  bool _isLoading = false;

  SubscriptionType get currentSubscription => _currentSubscription;
  DateTime? get subscriptionEndDate => _subscriptionEndDate;
  bool get isLoading => _isLoading;
  bool get isPremiumUser => _currentSubscription != SubscriptionType.none;
  bool get isSubscriptionActive => _subscriptionEndDate?.isAfter(DateTime.now()) ?? false;

  List<SubscriptionPlan> get subscriptionPlans => [
    SubscriptionPlan(
      type: SubscriptionType.monthly,
      name: AppStrings.monthlyPlan,
      description: 'Akses semua kursus premium selama 1 bulan',
      price: AppPrices.monthlyPrice,
      period: AppStrings.pricePerMonth,
      features: [
        'Akses semua kursus premium',
        'Download materi offline',
        'Sertifikat kelulusan',
        'Dukungan prioritas',
        'Akses komunitas eksklusif',
      ],
    ),
    SubscriptionPlan(
      type: SubscriptionType.yearly,
      name: AppStrings.yearlyPlan,
      description: 'Hemat 17% dengan berlangganan tahunan',
      price: AppPrices.yearlyPrice,
      period: AppStrings.pricePerYear,
      features: [
        'Semua fitur paket bulanan',
        'Hemat 2 bulan gratis',
        'Akses beta fitur terbaru',
        'Konsultasi 1-on-1 dengan instruktur',
        'Webinar eksklusif bulanan',
      ],
      isPopular: true,
      discountPercent: 17,
    ),
    SubscriptionPlan(
      type: SubscriptionType.lifetime,
      name: 'Paket Seumur Hidup',
      description: 'Akses selamanya tanpa berlangganan bulanan',
      price: AppPrices.lifetimePrice,
      period: ' (sekali bayar)',
      features: [
        'Semua fitur premium selamanya',
        'Akses semua kursus masa depan',
        'Prioritas tertinggi untuk dukungan',
        'Akses eksklusif ke konten beta',
        'Sesi mentoring pribadi',
        'Tidak ada biaya berlangganan lagi',
      ],
    ),
  ];

  Future<void> loadSubscriptionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final subscriptionIndex = prefs.getInt('subscription_type') ?? 0;
    final endDateString = prefs.getString('subscription_end_date');
    
    _currentSubscription = SubscriptionType.values[subscriptionIndex];
    if (endDateString != null) {
      _subscriptionEndDate = DateTime.parse(endDateString);
    }
    
    notifyListeners();
  }

  Future<bool> subscribe(SubscriptionType type) async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));
      
      _currentSubscription = type;
      
      switch (type) {
        case SubscriptionType.monthly:
          _subscriptionEndDate = DateTime.now().add(const Duration(days: 30));
          break;
        case SubscriptionType.yearly:
          _subscriptionEndDate = DateTime.now().add(const Duration(days: 365));
          break;
        case SubscriptionType.lifetime:
          _subscriptionEndDate = DateTime.now().add(const Duration(days: 36500));
          break;
        case SubscriptionType.none:
          _subscriptionEndDate = null;
          break;
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('subscription_type', type.index);
      if (_subscriptionEndDate != null) {
        await prefs.setString('subscription_end_date', _subscriptionEndDate!.toIso8601String());
      }

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> cancelSubscription() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      
      _currentSubscription = SubscriptionType.none;
      _subscriptionEndDate = null;

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('subscription_type');
      await prefs.remove('subscription_end_date');

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  String get subscriptionStatusText {
    if (!isPremiumUser) return 'Tidak berlangganan';
    
    if (_subscriptionEndDate != null) {
      final daysLeft = _subscriptionEndDate!.difference(DateTime.now()).inDays;
      if (daysLeft > 0) {
        return 'Aktif hingga ${_formatDate(_subscriptionEndDate!)} ($daysLeft hari lagi)';
      } else {
        return 'Berlangganan telah berakhir';
      }
    }
    
    return 'Status tidak diketahui';
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  int get monthlySavings {
    if (_currentSubscription == SubscriptionType.yearly) {
      return (AppPrices.monthlyPrice * 12) - AppPrices.yearlyPrice;
    }
    return 0;
  }
}
