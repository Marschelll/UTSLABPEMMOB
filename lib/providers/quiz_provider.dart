import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  String _playerName = "";
  int _currentQuestionIndex = 0;
  int _score = 0;

  // Getter
  String get playerName => _playerName;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;

  // Daftar pertanyaan (dummy)
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Gambar ini menunjukkan merek apa?',
      'image': 'assets/images/apple.webp',
      'options': ['Samsung', 'Apple', 'Sony', 'Xiaomi'],
      'answerIndex': 1,
    },
    {
      'question': 'Siapakah presiden pertama Indonesia?',
      'image': 'assets/images/soekarno.png',
      'options': ['Soekarno', 'Jokowi', 'Soeharto', 'BJ Habibie'],
      'answerIndex': 0,
    },
    {
      'question': 'Benda apa yang digunakan untuk menerangi ruangan?',
      'image': 'assets/images/lamp.webp',
      'options': ['Kursi', 'Televisi', 'Lampu', 'Meja'],
      'answerIndex': 2,
    },
  ];

  List<Map<String, dynamic>> get questions => _questions;

  void setPlayerName(String name) {
    _playerName = name;
    notifyListeners();
  }

  void answerQuestion(int selectedIndex) {
    if (selectedIndex == _questions[_currentQuestionIndex]['answerIndex']) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
    } else {
      // Sudah pertanyaan terakhir
      // tidak increment lagi
    }

    notifyListeners();
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    notifyListeners();
  }
}
