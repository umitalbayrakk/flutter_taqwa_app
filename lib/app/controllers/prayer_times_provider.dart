import 'package:flutter/material.dart';
import 'package:flutter_taqwa_app/app/services/prayer_times_service.dart';

class PrayerTimesProvider extends ChangeNotifier {
  final PrayerTimesService _service = PrayerTimesService();
  List<dynamic> locations = [];
  Map<String, dynamic>? prayerData;
  bool isLoading = false;
  String errorMessage = '';
  String selectedLocation = '';
  final TextEditingController searchController = TextEditingController();
  PrayerTimesProvider() {
    searchController.addListener(() {
      searchLocations(searchController.text);
    });
  }

  Future<void> searchLocations(String query) async {
    if (query.length < 3) {
      locations = [];
      errorMessage = '';
      notifyListeners();
      return;
    }

    isLoading = true;
    errorMessage = '';
    notifyListeners();

    try {
      locations = await _service.searchLocations(query);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchPrayerTimes(String locationId) async {
    isLoading = true;
    errorMessage = '';
    prayerData = null;
    notifyListeners();

    try {
      prayerData = await _service.fetchPrayerTimes(locationId);
      _updateSelectedLocation(locationId);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = e.toString();
      isLoading = false;
      notifyListeners();
    }
  }

  void _updateSelectedLocation(String locationId) {
    try {
      final location = locations.firstWhere((loc) => loc['id'].toString() == locationId);
      selectedLocation = '${location['name']}, ${location['stateName']}';
    } catch (e) {
      selectedLocation = 'Bilinmeyen Konum';
    }
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    locations = [];
    prayerData = null;
    errorMessage = '';
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}