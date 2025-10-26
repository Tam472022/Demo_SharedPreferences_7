import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'setting.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkMode = false;
  double _fontSize = 16.0;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('darkMode') ?? false;
      _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold (
        // Appbar: Xin chào người dùng!
        appBar: AppBar (
          title: const Text (
            'Xin chào người dùng!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: _isDarkMode ? Colors.grey[850] : const Color.fromARGB(255, 12, 77, 131),
        ),
        body: Center (
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text (
                'SVTH: Trần Quang Khánh, Hồ Nguyên Tâm',
                style: TextStyle(fontSize: _fontSize),
              ),
              SizedBox(height: 40),
              Icon (
                Icons.emoji_emotions_outlined,
                size: 150,
                color: _isDarkMode ? Color.fromARGB(255, 255, 255, 255) : Color.fromARGB(255, 38, 86, 126),
              ),
              SizedBox(height: 40),
              Text (
                'Chào mừng người dùng!',
                style: TextStyle(fontSize: _fontSize),
              ),
              SizedBox(height: 30),
              ElevatedButton (
                onPressed: () async {
                  await Navigator.push (
                    context,
                    MaterialPageRoute(builder: (_) => const SettingPage()),
                  );
                  _loadSettings(); // reload sau khi chỉnh cài đặt
                },
                child: Text (
                  'Mở cài đặt',
                  style: TextStyle (
                    color: _isDarkMode ? Colors.white : Color.fromARGB(255, 17, 69, 112),
                    fontSize: _fontSize - 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}