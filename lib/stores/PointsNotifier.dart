import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:sp_util/sp_util.dart';

class PointsNotifier extends ChangeNotifier {
  int _points = 0;
  DateTime _lastGiftDate = DateTime.now().subtract(const Duration(days: 1));

  int get points => _points;

  Future<void> init() async {
    _points = SpUtil.getInt('points') ?? 0;
    String? lastGiftDateString = SpUtil.getString('lastGiftDate');
    if (lastGiftDateString!.isNotEmpty) {
      _lastGiftDate = DateFormat('yyyy-MM-dd').parse(lastGiftDateString);
    }
  }

  Future<void> _savePoints() async {
    await SpUtil.putInt('points', _points);
  }

  Future<void> _saveLastGiftDate() async {
    await SpUtil.putString(
        'lastGiftDate', DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  Future<void> checkAndGiftPoints() async {
    DateTime currentDate = DateTime.now();
    if (!_isSameDay(_lastGiftDate, currentDate)) {
      _points=0;//每天重置积分
      _points += 3; // 每天赠送3积分，根据需求进行调整
      _lastGiftDate = currentDate;
      await _savePoints();
      await _saveLastGiftDate();
      notifyListeners();
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

//看广告增加积分5
  Future<void> addPoints() async {
    _points += 5;
    await SpUtil.putInt('points', _points);
    notifyListeners();
  }

  //
  Future<void> consume() async {
    _points -= 1;
    await SpUtil.putInt('points', _points);
    notifyListeners();
  }
}
