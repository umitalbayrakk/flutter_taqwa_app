import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';

class RosaryViewModel extends ChangeNotifier {
  final GetStorage _storage = GetStorage();
  List<String> _dhikrList = ['Subhanallah', 'Alhamdulillah'];
  List<String> get dhikrList => _dhikrList;
  String _selectedDhikr = '';
  String get selectedDhikr => _selectedDhikr;
  int _rosaryCount = 0;
  int get rosaryCount => _rosaryCount;

  bool _isLongPressedMode = false;
  bool get isLongPressedMode => _isLongPressedMode;

  Map<String, int> _dhikrCountMap = {};
  Map<String, int> get dhikrCountMap => _dhikrCountMap;

  RosaryViewModel() {
    _loadDhikrList();
    _loadDhikrCounts();
  }

  void _loadDhikrList() {
    final savedList = _storage.read<List>('dhikrList');
    if (savedList != null) {
      _dhikrList = savedList.cast<String>();
    } else {
      _storage.write('dhikrList', _dhikrList);
    }
    if (_dhikrList.isNotEmpty && _selectedDhikr.isEmpty) {
      selectDhikr(_dhikrList.first);
    }
    notifyListeners();
  }

  void _loadDhikrCounts() {
    final savedCounts = _storage.read<Map>('dhikrCounts');
    if (savedCounts != null) {
      _dhikrCountMap = savedCounts.cast<String, int>();
    }
    notifyListeners();
  }

  Future<void> _saveDhikrCount(String dhikr, int count) async {
    _dhikrCountMap[dhikr] = count;
    await _storage.write('dhikrCounts', _dhikrCountMap);
  }

  void selectDhikr(String dhikr) {
    _selectedDhikr = dhikr;
    _rosaryCount = _dhikrCountMap[dhikr] ?? 0;
    notifyListeners();
  }

  void incrementRosaryCount() {
    if (_selectedDhikr.isNotEmpty) {
      HapticFeedback.mediumImpact();
      _dhikrCountMap[_selectedDhikr] = (_dhikrCountMap[_selectedDhikr] ?? 0) + 1;
      _rosaryCount = _dhikrCountMap[_selectedDhikr]!;
      _saveDhikrCount(_selectedDhikr, _rosaryCount);
      notifyListeners();
    }
  }

  void resetRosaryCount() {
    if (_selectedDhikr.isNotEmpty) {
      _dhikrCountMap[_selectedDhikr] = 0;
      _rosaryCount = 0;
      _saveDhikrCount(_selectedDhikr, 0);
      notifyListeners();
    }
  }

  Future<void> addDhikrToList(String dhikr) async {
    if (!_dhikrList.contains(dhikr)) {
      _dhikrList.insert(0, dhikr);
      _dhikrCountMap[dhikr] = 0;
      await _storage.write('dhikrList', _dhikrList);
      selectDhikr(dhikr);
      notifyListeners();
    }
  }

  Future<void> removeDhikrFromList(String dhikr) async {
    _dhikrList.remove(dhikr);
    _dhikrCountMap.remove(dhikr);
    await _storage.write('dhikrList', _dhikrList);
    await _storage.write('dhikrCounts', _dhikrCountMap);

    if (_selectedDhikr == dhikr) {
      _selectedDhikr = '';
      _rosaryCount = 0;
      if (_dhikrList.isNotEmpty) {
        selectDhikr(_dhikrList.first);
      }
    }
    notifyListeners();
  }

  void setLongPressedMode(bool value) {
    _isLongPressedMode = value;
    if (value) HapticFeedback.mediumImpact();
    notifyListeners();
  }
}
