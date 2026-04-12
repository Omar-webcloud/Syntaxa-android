import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/auth_provider.dart';
import '../data/app_data.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'dart:math';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  String? _selectedOption;
  bool _isAnswerChecked = false;
  List<Map<String, dynamic>> _questions = [];

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    final allQuestions = List<Map<String, dynamic>>.from(AppData.data['multipleChoice']);
    allQuestions.shuffle(Random());
    setState(() {
      _questions = allQuestions.take(10).toList();
      _currentIndex = 0;
      _score = 0;
      _selectedOption = null;
      _isAnswerChecked = false;
    });
  }

  void _checkAnswer() {
    if (_selectedOption == null) return;
    setState(() {
      _isAnswerChecked = true;
      if (_selectedOption == _questions[_currentIndex]['answer']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
        _selectedOption = null;
        _isAnswerChecked = false;
      } else {
        // Update stats
        final auth = Provider.of<AuthProvider>(context, listen: false);
        if (auth.isLoggedIn) {
          auth.addQuizResult(_score, _questions.length);
        }
        
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => AlertDialog(
            title: const Text('Quiz Completed!'),
            content: Text('Your Score: $_score / ${_questions.length}', style: const TextStyle(fontSize: 20)),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _loadQuestions();
                },
                child: const Text('Restart Quiz'),
              )
            ],
          )
        );
      }
    });
  }

  List<String> _getOptions(String question, String answer) {
    // 1. First, check if there are explicit options grouped in parentheses like (is/are)
    final regex = RegExp(r'\(([^)]+)\)');
    final match = regex.firstMatch(question);
    
    List<String> foundOptions = [];
    if (match != null) {
      foundOptions = match.group(1)!.split('/').map((s) => s.trim()).toList();
    }
    
    // 2. Ensure the correct answer is always safely in the pool
    if (!foundOptions.contains(answer)) {
      foundOptions.add(answer);
    }
    
    // 3. To guarantee EXACTLY 4 options, pad it with logical distractors.
    final genericDistractors = ['is', 'are', 'am', 'was', 'were', 'has', 'have', 'had', 'do', 'does', 'did', 'to', 'for', 'of', 'in', 'on', 'at', 'by', 'with', 'goes', 'went', 'gone', 'playing', 'played', 'play'];
    
    // Remove correct answer or existing options from distractors, shuffle, and add until we hit 4.
    genericDistractors.shuffle();
    for (String dist in genericDistractors) {
      if (foundOptions.length >= 4) break;
      if (!foundOptions.contains(dist) && dist != answer) {
        foundOptions.add(dist);
      }
    }
    
    // Only take exactly 4 options safely, and shuffle them so answer isn't predictable.
    final finalOptions = foundOptions.take(4).toList();
    finalOptions.shuffle();
    return finalOptions;
  }
  
  String _cleanQuestion(String question) {
    final regex = RegExp(r'\s*\([^)]+\)');
    String cleanStr = question.replaceAll(regex, '').trim();
    if (!cleanStr.endsWith('.')) cleanStr += '.';
    return cleanStr;
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final currentQ = _questions[_currentIndex];
    final cleanQ = _cleanQuestion(currentQ['question']);
    final options = _getOptions(currentQ['question'], currentQ['answer']);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F0F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Consumer<AuthProvider>(
                builder: (context, auth, child) {
                  if (auth.isLoggedIn) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome Back ${auth.username}!',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                      ],
                    );
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Welcome to Syntaxa!',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w600)),
                            Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const SignUpScreen()));
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Color(0xFF9C41BC)),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 0),
                                  ),
                                  child: const Text('Sign Up',
                                      style: TextStyle(
                                          color: Color(0xFF9C41BC),
                                          fontSize: 14)),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const LoginScreen()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF9C41BC),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 0),
                                  ),
                                  child: const Text('Log In',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14)),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    );
                  }
                },
              ),
              Text('Your Daily Quiz',
                  style: Theme.of(context)
                      .textTheme
                      .displayLarge
                      ?.copyWith(fontSize: 32, color: Colors.black)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Question ${_currentIndex + 1}/${_questions.length}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                  Text('$_score Corrects', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (_currentIndex + 1) / _questions.length,
                  minHeight: 12,
                  backgroundColor: Colors.orange.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(color: const Color(0xFFEBE4FF), borderRadius: BorderRadius.circular(20)),
                              child: const Text('Fill In', style: TextStyle(color: Color(0xFF9C41BC), fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              children: const [
                                Text('Hint (-5) ', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                                Icon(Icons.diamond, color: Colors.blue, size: 20),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Text(cleanQ, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 32),
                        Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: options.map((opt) {
                            bool isSelected = _selectedOption == opt;
                            bool isCorrectAnswer = opt == currentQ['answer'];
                            Color bgColor = Colors.white;
                            Color borderColor = Colors.grey.shade300;
                            if (_isAnswerChecked) {
                              if (isCorrectAnswer) {
                                bgColor = Colors.green.shade100;
                                borderColor = Colors.green;
                              } else if (isSelected) {
                                bgColor = Colors.red.shade100;
                                borderColor = Colors.red;
                              }
                            } else if (isSelected) {
                              bgColor = Colors.purple.shade50;
                              borderColor = Colors.purple;
                            }

                            return GestureDetector(
                              onTap: _isAnswerChecked ? null : () {
                                setState(() {
                                  _selectedOption = opt;
                                });
                              },
                              child: Container(
                                width: (MediaQuery.of(context).size.width - 48 - 48 - 16) / 2, // approximate dynamic width
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: borderColor),
                                ),
                                child: Center(
                                  child: Text(opt, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _isAnswerChecked ? _nextQuestion : (_selectedOption != null ? _checkAnswer : null),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: _selectedOption != null || _isAnswerChecked ? const Color(0xFF9C41BC) : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(_isAnswerChecked ? 'Next Question' : 'Check Answer', style: TextStyle(fontSize: 18, color: (_selectedOption != null || _isAnswerChecked) ? Colors.white : Colors.black54, fontWeight: FontWeight.bold)),
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
