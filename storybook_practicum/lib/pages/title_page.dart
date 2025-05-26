import 'package:flutter/material.dart';

class TitlePage extends StatelessWidget {
  final VoidCallback onStartPressed;
  const TitlePage({super.key, required this.onStartPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Petualangan Antariksa", style: TextStyle(fontSize: 32)),
            const SizedBox(height: 20),
            Card(
              elevation: 8,
              child: InkWell(
                onTap: onStartPressed,
                splashColor: Colors.teal.withAlpha(40),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  child: Text(
                    "Mulai Petualangan",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
