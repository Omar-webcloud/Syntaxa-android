import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _username;
  bool _isLoggedIn = false;

  // Stats
  int _totalQuiz = 0;
  int _totalStreak = 0;
  int _totalGems = 0;
  int _totalPracticed = 0;
  int _correctAnswers = 0;
  int _totalQuestions = 0;
  String? _lastQuizDate;

  String? get username => _username;
  bool get isLoggedIn => _isLoggedIn;

  // Getters for Stats
  int get totalQuiz => _totalQuiz;
  int get totalStreak => _totalStreak;
  int get totalGems => _totalGems;
  int get totalPracticed => _totalPracticed;
  int get accuracy => _totalQuestions == 0 ? 0 : ((_correctAnswers / _totalQuestions) * 100).toInt();

  AuthProvider() {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _username = prefs.getString('username');
    if (_username != null) {
      _isLoggedIn = true;
      _totalQuiz = prefs.getInt('totalQuiz') ?? 0;
      _totalStreak = prefs.getInt('totalStreak') ?? 0;
      _totalGems = prefs.getInt('totalGems') ?? 0;
      _totalPracticed = prefs.getInt('totalPracticed') ?? 0;
      _correctAnswers = prefs.getInt('correctAnswers') ?? 0;
      _totalQuestions = prefs.getInt('totalQuestions') ?? 0;
      _lastQuizDate = prefs.getString('lastQuizDate');
    }
    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (_isLoggedIn) {
      await prefs.setString('username', _username!);
      await prefs.setInt('totalQuiz', _totalQuiz);
      await prefs.setInt('totalStreak', _totalStreak);
      await prefs.setInt('totalGems', _totalGems);
      await prefs.setInt('totalPracticed', _totalPracticed);
      await prefs.setInt('correctAnswers', _correctAnswers);
      await prefs.setInt('totalQuestions', _totalQuestions);
      if (_lastQuizDate != null) await prefs.setString('lastQuizDate', _lastQuizDate!);
    } else {
      await prefs.clear();
    }
  }

  void login(String name) {
    _username = name;
    _isLoggedIn = true;
    _loadFromPrefs(); // Load existing stats if any
    _saveToPrefs();
    notifyListeners();
  }

  void signup(String name) {
    _username = name;
    _isLoggedIn = true;
    _totalQuiz = 0;
    _totalStreak = 1; // Start streak on signup
    _totalGems = 50; // Welcome gift
    _totalPracticed = 0;
    _correctAnswers = 0;
    _totalQuestions = 0;
    _lastQuizDate = DateTime.now().toIso8601String();
    _saveToPrefs();
    notifyListeners();
  }

  void logout() {
    _username = null;
    _isLoggedIn = false;
    _totalQuiz = 0;
    _totalStreak = 0;
    _totalGems = 0;
    _totalPracticed = 0;
    _correctAnswers = 0;
    _totalQuestions = 0;
    _lastQuizDate = null;
    _saveToPrefs();
    notifyListeners();
  }

  // Update Methods
  void addQuizResult(int score, int total) {
    if (!_isLoggedIn) return;
    _totalQuiz++;
    _correctAnswers += score;
    _totalQuestions += total;
    _totalGems += (score * 5); // 5 gems per correct answer

    // Simple Streak Logic
    final now = DateTime.now();
    final today = "${now.year}-${now.month}-${now.day}";
    if (_lastQuizDate != today) {
      _totalStreak++;
      _lastQuizDate = today;
    }
    
    _saveToPrefs();
    notifyListeners();
  }

  void addPracticeResult(bool isCorrect) {
    if (!_isLoggedIn) return;
    _totalPracticed++;
    if (isCorrect) {
      _correctAnswers++;
      _totalGems += 2;
    }
    _totalQuestions++;
    _saveToPrefs();
    notifyListeners();
  }
}
