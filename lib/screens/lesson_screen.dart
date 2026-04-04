import 'package:flutter/material.dart';

class LessonScreen extends StatelessWidget {
  final Map<String, dynamic> lesson;

  const LessonScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final List<dynamic> patterns = lesson['patterns'];

    return Scaffold(
      backgroundColor: const Color(0xFFF3F0F6),
      appBar: AppBar(
        title: Text(lesson['topic']),
        backgroundColor: const Color(0xFF9C41BC),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lesson['title'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 24),
              ...patterns.map((p) {
                final String patternList = p['pattern'].toString();
                final String example = p['example'].toString();
                final String? use = p['use']?.toString() ?? p['rule']?.toString() ?? p['type']?.toString();
                final String? tense = p['tense']?.toString();
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 5)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (tense != null) ...[
                        Text(tense, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF9C41BC))),
                        const SizedBox(height: 8),
                      ],
                      Text(patternList, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      if (use != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(color: Colors.lightBlue.shade50, borderRadius: BorderRadius.circular(12)),
                          child: Text(use, style: TextStyle(color: Colors.lightBlue.shade700, fontWeight: FontWeight.w600, fontSize: 12)),
                        ),
                        const SizedBox(height: 12),
                      ],
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: const Color(0xFFF5F3F8), borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Example: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                            Expanded(child: Text(example, style: const TextStyle(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic))),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
