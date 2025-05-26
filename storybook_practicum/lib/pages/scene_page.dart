import 'package:flutter/material.dart';

class InteractiveScenePage extends StatefulWidget {
  final VoidCallback onQuestComplete;
  const InteractiveScenePage({super.key, required this.onQuestComplete});

  @override
  State<InteractiveScenePage> createState() => _InteractiveScenePageState();
}

class _InteractiveScenePageState extends State<InteractiveScenePage> {
  // Variabel state untuk posisi, dialog, dan status peti
  Offset _keyPosition = const Offset(50, 300);
  Offset _backgroundOffset = Offset.zero;
  bool _isDialogueVisible = false;
  bool _isChestOpen = false;
  String _chestHint = "Terkunci...";

  // GlobalKeys untuk mendapatkan posisi dan ukuran widget
  final GlobalKey _chestKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        // <--- WIDGET DITAMBAHKAN DI SINI
        boundaryMargin: const EdgeInsets.all(double.infinity),
        minScale: 1.0,
        maxScale: 3.0,
        child: Stack(
          children: [
            // Latar Belakang
            GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  final newOffset = _backgroundOffset + details.delta;

                  // Batas pergerakan latar
                  const double maxOffset = 100;
                  _backgroundOffset = Offset(
                    newOffset.dx.clamp(-maxOffset, maxOffset),
                    newOffset.dy.clamp(-maxOffset, maxOffset),
                  );
                });
              },
              child: Transform.translate(
                offset: _backgroundOffset,
                child: Container(
                  width: MediaQuery.of(context).size.width * 1.2,
                  height: MediaQuery.of(context).size.height * 1.2,
                  color: const Color(0xff303952),
                  child: const Center(
                    child: Text(
                      "🪐",
                      style: TextStyle(fontSize: 200, color: Colors.white24),
                    ),
                  ),
                ),
              ),
            ),

            // Di dalam children dari Stack:
            // Astronaut (Double Tap)
            Positioned(
              bottom: 50,
              left: 60,
              child: GestureDetector(
                onDoubleTap: () {
                  setState(() {
                    _isDialogueVisible = !_isDialogueVisible;
                  });
                },
                child: const Text("👩‍🚀", style: TextStyle(fontSize: 80)),
              ),
            ),
            // Balon Dialog
            if (_isDialogueVisible)
              Positioned(
                bottom: 140,
                left: 30,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "Aku harus buka peti itu!",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            // Di dalam children dari Stack:
            // Peti (Long Press)
            Positioned(
              key: _chestKey, // Memberi kunci global pada peti
              bottom: 50,
              right: 50,
              child: GestureDetector(
                onLongPress: () {
                  if (_isChestOpen) return;
                  setState(() {
                    _chestHint = "Sepertinya butuh kunci...";
                  });
                  // Menghilangkan petunjuk setelah beberapa detik
                  Future.delayed(
                    const Duration(seconds: 2),
                    () => setState(() => _chestHint = "Terkunci..."),
                  );
                },
                child: Text(
                  _isChestOpen ? "🔓" : "📦",
                  style: TextStyle(fontSize: 80),
                ),
              ),
            ),
            // Teks Petunjuk Peti
            Positioned(
              bottom: 140,
              right: 20,
              child: Text(
                _chestHint,
                style: const TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            // Di dalam children dari Stack:
            // Kunci (Drag & Drop)
            Positioned(
              left: _keyPosition.dx,
              top: _keyPosition.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (_isChestOpen)
                    return; // Kunci tidak bisa digerakkan jika peti sudah terbuka
                  setState(() {
                    _keyPosition += details.delta;
                  });
                },
                onPanEnd: (details) {
                  if (_isChestOpen) return;

                  // Cek apakah kunci di-drop di atas peti
                  final RenderBox chestBox =
                      _chestKey.currentContext!.findRenderObject() as RenderBox;
                  final chestPosition = chestBox.localToGlobal(Offset.zero);
                  final chestRect = chestPosition & chestBox.size;

                  if (chestRect.contains(_keyPosition)) {
                    setState(() {
                      _isChestOpen = true;
                      _chestHint = "Terbuka!";
                      // Sembunyikan kunci
                      _keyPosition = const Offset(-100, -100);
                    });
                    // Pindah ke halaman akhir setelah quest selesai
                    Future.delayed(
                      const Duration(seconds: 2),
                      widget.onQuestComplete,
                    );
                  }
                },
                child: const Text("🔑", style: TextStyle(fontSize: 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
