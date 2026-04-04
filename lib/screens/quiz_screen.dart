
import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Daily Quiz'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              '0 Corrects',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Question 1/10'),
            const SizedBox(height: 8),
            const LinearProgressIndicator(value: 0.1),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Fill In'),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.diamond),
                          label: const Text('Hint (-5)'),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'He __ a student.',
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(height: 24),
                    _buildOption('am', context),
                    const SizedBox(height: 12),
                    _buildOption('studies', context),
                    const SizedBox(height: 12),
                    _buildOption('is', context),
                    const SizedBox(height: 12),
                    _buildOption('many', context),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Check Answer'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String text, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () {},
        child: Text(text),
      ),
    );
  }
}
