import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = Provider.of<QuizProvider>(context);
    final currentQuestion =
    quizProvider.questions[quizProvider.currentQuestionIndex];

    final isLastQuestion = quizProvider.currentQuestionIndex ==
        quizProvider.questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Halo, ${quizProvider.playerName}!",
          style: const TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: const Color(0xFF1976D2),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gambar pertanyaan
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  currentQuestion['image'],
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),

              // Pertanyaan
              Text(
                currentQuestion['question'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
              const SizedBox(height: 30),

              // Pilihan jawaban
              ...List.generate(currentQuestion['options'].length, (index) {
                final option = currentQuestion['options'][index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      quizProvider.answerQuestion(index);

                      if (isLastQuestion) {
                        // Tampilkan hasil akhir
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => AlertDialog(
                            title: const Text(
                              "Kuis Selesai!",
                              style: TextStyle(fontFamily: 'Poppins'),
                            ),
                            content: Text(
                              "Skor kamu: ${quizProvider.score}/${quizProvider.questions.length}",
                              style: const TextStyle(fontFamily: 'Poppins'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  quizProvider.resetQuiz();
                                  Navigator.pop(context); // Tutup dialog
                                  Navigator.pop(context); // Balik ke home
                                },
                                child: const Text("Main Lagi"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text(
                      option,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
