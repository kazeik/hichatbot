import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  _PointsPageState createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  late SharedPreferences _prefs;
  int _points = 0;
  late DateTime _lastGiftDate;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _points = _prefs.getInt('points') ?? 0;
    final lastGiftDateMillis = _prefs.getInt('lastGiftDate');
    if (lastGiftDateMillis != null) {
      _lastGiftDate = DateTime.fromMillisecondsSinceEpoch(lastGiftDateMillis);
    }
    setState(() {}); // 更新UI
  }

  void _giftPoints() {
    final now = DateTime.now();
    if (_lastGiftDate == null || !_isSameDay(now, _lastGiftDate)) {
      // 进行积分赠送
      final dailyGiftPoints = 10; // 每日赠送的积分数量
      _points += dailyGiftPoints;
      _lastGiftDate = now;
      _prefs.setInt('points', _points);
      _prefs.setInt('lastGiftDate', _lastGiftDate.millisecondsSinceEpoch);
      setState(() {}); // 更新UI
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('积分页面'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '当前积分：$_points',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: _giftPoints,
              child: Text('每天赠送积分'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PointsPage(),
  ));
}
