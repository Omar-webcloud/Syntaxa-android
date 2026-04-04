import 'package:flutter/material.dart';
import '../data/app_data.dart';
import 'lesson_screen.dart';
import 'dart:math';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final TextEditingController _answerController = TextEditingController();
  Map<String, dynamic>? _currentQuestion;
  bool _isAnswerChecked = false;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _loadRandomQuestion();
  }

  void _loadRandomQuestion() {
    final list = List<Map<String, dynamic>>.from(AppData.data['fillInBlanks']);
    setState(() {
      _currentQuestion = list[Random().nextInt(list.length)];
      _answerController.clear();
      _isAnswerChecked = false;
      _isCorrect = false;
    });
  }

  void _checkAnswer() {
    final userInput = _answerController.text.trim().toLowerCase();
    final correctAnswer = _currentQuestion!['answer'].toString().trim().toLowerCase();
    String sanitize(String s) => s.replaceAll(RegExp(r'[^\w\s]'), '');
    setState(() {
      _isAnswerChecked = true;
      _isCorrect = sanitize(userInput) == sanitize(correctAnswer);
    });
  }

  void _openLesson(String topic) {
    final lessons = List<Map<String, dynamic>>.from(AppData.data['lessons']);
    final lesson = lessons.firstWhere((l) => l['topic'] == topic, orElse: () => <String, dynamic>{});
    if (lesson.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LessonScreen(lesson: lesson)));
    }
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sentence Practice', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32, color: Colors.black)),
              const SizedBox(height: 4),
              const Text('Improve Your Writing with Interactive Exercise.', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _buildStatCard('📘 7 Lesson', 'TOTAL PRACTICED')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildStatCard('📊 43%', 'AVERAGE ACCURACY')),
                ],
              ),
              const SizedBox(height: 24),
              if (_currentQuestion != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5)),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(color: Colors.lightBlue.shade400, borderRadius: BorderRadius.circular(20)),
                        child: const Text('Correct The Sentence', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 24),
                      const Text('QUESTION', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 1.2)),
                      const SizedBox(height: 16),
                      Text(_currentQuestion!['question'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: _isAnswerChecked 
                              ? (_isCorrect ? Colors.green.shade50 : Colors.red.shade50) 
                              : const Color(0xFFF5F3F8),
                          borderRadius: BorderRadius.circular(16),
                          border: _isAnswerChecked ? Border.all(color: _isCorrect ? Colors.green : Colors.red) : null,
                        ),
                        child: TextField(
                          controller: _answerController,
                          enabled: !_isAnswerChecked,
                          decoration: const InputDecoration(
                            hintText: 'Type Your Answer Here...',
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      if (_isAnswerChecked && !_isCorrect)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text('Correct Answer:\n${_currentQuestion!['answer']}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        ),
                      if (_isAnswerChecked && _isCorrect)
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0),
                          child: Text('Correct!', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: _isAnswerChecked ? _loadRandomQuestion : () {
                          if (_answerController.text.trim().isNotEmpty) {
                            _checkAnswer();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF9C41BC),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(color: const Color(0xFF9C41BC).withValues(alpha: 0.4), blurRadius: 10, offset: const Offset(0, 4)),
                            ],
                          ),
                          child: Center(
                            child: Text(_isAnswerChecked ? 'Next Question' : 'Check Answer', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 32),
              const Text('Practice Rules & Patterns', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: [
                  _buildExerciseCard(Icons.lightbulb_outline, 'Error\nCorrection', 'Identify and Fix\nCommon Mistakes.'),
                  _buildExerciseCard(Icons.text_fields, 'Tenses', 'Practice All Forms\nPresent, Past and\nFuture.', onTap: () => _openLesson('Tenses')),
                  _buildExerciseCard(Icons.layers_outlined, 'Articles &\nPreposition', 'Master the use of\narticles and\nprepositions.', onTap: () => _openLesson('Articles & Preposition')),
                  _buildExerciseCard(Icons.table_chart_outlined, 'Sentence\nStructure', 'Learn to build complex\nsentences correctly.', onTap: () => _openLesson('Sentence Structure')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54, letterSpacing: 0.5)),
        ],
      ),
    );
  }

  Widget _buildExerciseCard(IconData icon, String title, String subtitle, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEBE4FF).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: Colors.black87),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.2)),
            const SizedBox(height: 8),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
