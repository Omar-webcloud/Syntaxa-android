import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

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
              Text('My Rewards', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32, color: Colors.black)),
              const SizedBox(height: 4),
              const Text('Keep Your Streak Alive to Earn More', style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(child: _buildStatCard(const Icon(Icons.diamond, color: Colors.blue, size: 28), '124', 'Total Gems')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildStatCard(const Icon(Icons.local_fire_department, color: Colors.orange, size: 28), '5', 'Day Streak')),
                ],
              ),
              const SizedBox(height: 24),
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
                    const Text('Weekly Streak', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildStreakDay('M', true),
                        _buildStreakDay('T', true),
                        _buildStreakDay('W', true),
                        _buildStreakDay('T', true),
                        _buildStreakDay('F', true),
                        _buildStreakDay('S', false),
                        _buildStreakDay('S', false),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: Colors.orange, size: 20),
                          SizedBox(width: 8),
                          Text('2 Days Until Your Next Big Reward (+50) ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87)),
                          Icon(Icons.diamond, color: Colors.blue, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Achievements', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('View All', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 16),
              _buildAchievementCard(Icons.library_books, Colors.purple, 'Grammar Master', 'Completed 10 basic grammar practices.', 1.0, isCompleted: true),
              const SizedBox(height: 16),
              _buildAchievementCard(Icons.local_fire_department, Colors.orange, '7 Day Streak', 'Maintain a week-long learning habit to unlock.', 5/7, progressText: '5/7'),
              const SizedBox(height: 16),
              _buildAchievementCard(Icons.menu_book, Colors.blue, '100 Lesson Club', 'Finish 100 lessons in total to unlock.', 0.0, isLocked: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(Icon icon, String value, String label) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          icon,
          const SizedBox(height: 16),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54)),
        ],
      ),
    );
  }

  Widget _buildStreakDay(String day, bool isDone) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isDone ? Colors.orange : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: isDone ? const Icon(Icons.check, color: Colors.white, size: 20) : null,
        ),
        const SizedBox(height: 8),
        Text(day, style: TextStyle(fontWeight: FontWeight.bold, color: isDone ? Colors.black : Colors.black38)),
      ],
    );
  }

  Widget _buildAchievementCard(IconData iconData, Color iconColor, String title, String subtitle, double progress, {bool isCompleted = false, bool isLocked = false, String? progressText}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    if (isCompleted)
                      const Icon(Icons.check_circle, color: Colors.green)
                    else if (isLocked)
                      const Icon(Icons.lock_outline, color: Colors.grey)
                    else if (progressText != null)
                      Text(progressText, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(height: 12),
                if (!isLocked)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
