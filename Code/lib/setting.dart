import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});
  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', _isDarkMode);
    await prefs.setDouble('fontSize', _fontSize);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        appBar: AppBar(
          title: Text (
            'Cài đặt',
            style: TextStyle (
              color: Colors.white,
            ),
          ),
          backgroundColor:
              _isDarkMode ? Colors.grey[850] : const Color(0xFF0B4B80),
        ),
        body: Padding (
          padding: EdgeInsets.all(20),
          child: Column (
            children: [
              SizedBox(height: 40),
              SwitchListTile (
                title: Text (
                  _isDarkMode ? 'Chế độ sáng' : 'Chế độ tối',
                  style: TextStyle (
                    fontSize: _fontSize,
                  ),
                ),
                value: _isDarkMode,
                onChanged: (v) {
                  setState(() => _isDarkMode = v);
                  _saveSettings();
                },
                activeColor: Colors.white,
              ),
              Text (
                'Cỡ chữ văn bản: ${_fontSize.toStringAsFixed(0)}',
                style: TextStyle (
                  fontSize: _fontSize,
                ),
              ),
              Slider (
                min: 15,
                max: 22,
                thumbColor: _isDarkMode ? Colors.white : const Color.fromARGB(255, 27, 60, 87),
                activeColor: _isDarkMode ? Colors.white : const Color.fromARGB(255, 27, 60, 87),
                value: _fontSize.clamp(15, 22),
                onChanged: (v) {
                  setState(() => _fontSize = v);
                  _saveSettings();
                },
              ),
              SizedBox(height: 40),
              ElevatedButton (
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Quay về màn hình chính',
                  style: TextStyle (
                    color: _isDarkMode ? Colors.white : const Color.fromARGB(255, 20, 47, 96),
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