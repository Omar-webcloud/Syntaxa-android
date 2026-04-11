import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy for Syntaxa',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Last updated: April 11, 2026',
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('1. Information We Collect'),
            _buildSectionBody(
              'Syntaxa ("we", "us", or "our") does not collect any personally identifiable information from its users. The app is designed to be used offline and for educational purposes.',
            ),
            _buildSectionTitle('2. How We Use Your Information'),
            _buildSectionBody(
              'Since we do not collect any personal data, we do not use, share, or sell any information to third parties.',
            ),
            _buildSectionTitle('3. Internet and Permissions'),
            _buildSectionBody(
              'The app requires internet access solely for loading dictionary data and external educational resources. No user data is transmitted during these operations.',
            ),
            _buildSectionTitle('4. Data Storage'),
            _buildSectionBody(
              'The app may store your progress (quiz results, streak, and rewards) locally on your device. This data is not synced to any cloud service.',
            ),
            _buildSectionTitle('5. Changes to This Policy'),
            _buildSectionBody(
              'We may update our Privacy Policy from time to time. You are advised to review this page periodically for any changes.',
            ),
            _buildSectionTitle('6. Contact Us'),
            _buildSectionBody(
              'If you have any questions about this Privacy Policy, please contact us at info@optechlabs.com',
            ),
            const SizedBox(height: 40),
            const Center(
              child: Text(
                'Developed by Optech Labs',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSectionBody(String body) {
    return Text(
      body,
      style: const TextStyle(fontSize: 14, height: 1.5, color: Colors.black87),
    );
  }
}
