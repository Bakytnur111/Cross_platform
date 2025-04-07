# Cross_platform

```dart

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'About Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AboutPage(),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Planner',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('About the App'),
            _buildText(
              'Daily Planner App is a convenient tool that allows users to independently create their daily schedule without strict templates. '
              'The application is suitable for those who want to flexibly manage their time and plan tasks at their own discretion.',
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Credits'),
            _buildText(
              'Developed by:
              \n• Nurmakhan Bakytnur
              \n• Aziz Abdullin
              \n• Madina Rysbekova
              \n• Abylaikhan Sekerbek
              \n\nMentor (Teacher):
              \n• Assistant Professor Abzal Kyzyrkanov',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          height: 1.5,
        ),
      ),
    );
  }
}
![5413863778086416584](https://github.com/user-attachments/assets/dc3e5720-923a-4fda-a1fe-9c97566c7379)
