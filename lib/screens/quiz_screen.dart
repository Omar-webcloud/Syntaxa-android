import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Welcome Back Abul Hayat!', style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text('Your Daily Quiz', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32, color: Colors.black)),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Question 1/10', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                  Text('0 Corrects', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: 0.1,
                  minHeight: 12,
                  backgroundColor: Colors.orange.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
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
                    const Text('He ___ a student.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 32),
                    Row(
                      children: const [
                        Expanded(child: _OptionButton('am')),
                        SizedBox(width: 16),
                        Expanded(child: _OptionButton('studies')),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        Expanded(child: _OptionButton('is')),
                        SizedBox(width: 16),
                        Expanded(child: _OptionButton('many')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text('Check Answer', style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  final String text;
  const _OptionButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Center(
        child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
