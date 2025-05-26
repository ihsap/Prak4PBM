import 'package:flutter/material.dart';
import 'package:storybook_practicum/pages/scene_page.dart';
import 'package:storybook_practicum/pages/title_page.dart';
import 'package:storybook_practicum/pages/end_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Interactive Storybook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: StorybookHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StorybookHome extends StatelessWidget {
  StorybookHome({super.key});

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          TitlePage(onStartPressed: () => _controller.animateToPage(1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut)),
          InteractiveScenePage(onQuestComplete: () => _controller.animateToPage(2, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut)),
          EndPage(onRestart: () => _controller.animateToPage(0, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut)),
        ],
      ),
    );
  }
}
