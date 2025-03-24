import 'package:flutter/material.dart';

import 'Login_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily:
            'Roboto', //
      ),
      home: const LanguageSelectionScreen(),
    );
  }
}

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? _selectedLanguage;
  final List<Map<String, String>> _languages = [
    {'name': 'English', 'code': 'en'},
    {'name': 'العربية', 'code': 'ar'},
  ];

  void _changeLanguage() {
    if (_selectedLanguage != null) {
      //
      print('Selected Language: $_selectedLanguage');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              _buildLanguageContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageContent() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/kemo1.png',
            width: 250,
            height: 250,
          ),
          SizedBox(height: 15),
          Text(
            'من فضلك اختر اللغه',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue.shade900,
              shadows: [
                Shadow(
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(1, 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), //
          ..._languages.map((lang) => _buildLanguageTile(lang)),
          const SizedBox(height: 30), //
          _buildActionButton(context),
        ],
      ),
    );
  }

  Widget _buildLanguageTile(Map<String, String> lang) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8), //
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedLanguage = lang['code'];
          });
        },
        child: ListTile(
          title: Text(
            lang['name']!,
            style: TextStyle(
              fontSize: 18, //
              color: _selectedLanguage == lang['code']
                  ? Colors.blue.shade900
                  : Colors.grey.shade700,
            ),
          ),
          leading: Radio<String>(
            value: lang['code']!,
            groupValue: _selectedLanguage,
            activeColor: Colors.blue.shade900,
            onChanged: (value) => setState(() => _selectedLanguage = value),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          tileColor: Colors.grey.shade50,
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _selectedLanguage != null
          ? () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade900,
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 2,
      ),
      child: const Text(
        'Change Language',
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
