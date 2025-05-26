import 'package:flutter/material.dart';

class EndPage extends StatelessWidget {
  final VoidCallback onRestart;
  const EndPage({super.key, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7d794),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "🎉",
              style: TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 20),
            Text(
              "Misi Selesai!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            Text(
              "Harta karun berhasil ditemukan!",
              style: TextStyle(fontSize: 18, color: Colors.brown[700]),
            ),
            const SizedBox(height: 50),
            ElevatedButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.refresh),
              label: const Text("Ulangi Petualangan"),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.teal,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}