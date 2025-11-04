import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();

  void _startQuiz() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Masukkan nama terlebih dahulu!")),
      );
      return;
    }

    // Simpan nama ke provider
    Provider.of<QuizProvider>(context, listen: false).setPlayerName(name);

    // Pindah ke halaman kuis
    Navigator.pushNamed(context, '/quiz');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);

    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark
                ? [Colors.black, Colors.grey.shade900]
                : [const Color(0xFF1565C0), const Color(0xFF1E88E5)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // 🔘 Tombol ganti tema di pojok kanan atas
              Positioned(
                right: 16,
                top: 16,
                child: IconButton(
                  icon: Icon(
                    isDark
                        ? Icons.wb_sunny_rounded
                        : Icons.nights_stay_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                  tooltip: isDark ? "Mode Terang" : "Mode Gelap",
                  onPressed: () => themeProvider.toggleTheme(),
                ),
              ),

              // 🌟 Konten utama di tengah layar
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Judul
                      Text(
                        "Kuis Gameshow",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              offset: const Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      Text(
                        "Uji Pengetahuan Umum-mu Sekarang!",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),

                      // Input nama pemain
                      TextField(
                        controller: _nameController,
                        onChanged: (_) => setState(() {}),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          hintText: "Masukkan Nama Anda",
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Preview nama
                      if (_nameController.text.isNotEmpty)
                        Text(
                          "Halo, ${_nameController.text}! 👋",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      const SizedBox(height: 40),

                      // Tombol mulai
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                          isDark ? Colors.blueAccent : Colors.lightBlueAccent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 8,
                          shadowColor: Colors.black54,
                        ),
                        onPressed: _startQuiz,
                        icon: const Icon(Icons.play_arrow, size: 30),
                        label: const Text(
                          "MULAI",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
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
