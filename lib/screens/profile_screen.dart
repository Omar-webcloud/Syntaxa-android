import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart'; // To access ThemeProvider for dark mode

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0F6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEBE4FF),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Icon(Icons.person, size: 60, color: Color(0xFF9C41BC)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 5),
                      ],
                    ),
                    child: const Icon(Icons.edit, size: 16, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Abul Hayat', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  children: [
                    _buildTopStatCard(Icons.track_changes, Colors.purple, 'Total Quiz', '46'),
                    const SizedBox(width: 12),
                    _buildTopStatCard(Icons.local_fire_department, Colors.orange, 'Total Streak', '5 Days'),
                    const SizedBox(width: 12),
                    _buildTopStatCard(Icons.emoji_events, Colors.blue, 'Total Gem', '124'),
                    const SizedBox(width: 12),
                    _buildTopStatCard(Icons.schedule, Colors.lightBlue, 'Time Spent', '6h 9m'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEBE4FF),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildSettingRow('Daily Reminder', true),
                    const SizedBox(height: 16),
                    _buildSettingRow('Sound Effects', false),
                    const SizedBox(height: 16),
                    Builder(
                      builder: (context) {
                        final themeProvider = Provider.of<ThemeProvider>(context);
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                              Switch(
                                value: themeProvider.themeMode == ThemeMode.dark,
                                activeColor: const Color(0xFF9C41BC),
                                onChanged: (val) {
                                  themeProvider.toggleTheme();
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
                  ],
                ),
                child: const Center(
                  child: Text('Log Out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopStatCard(IconData icon, Color color, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, color: Colors.black54, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow(String title, bool initialValue) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
          Switch(
            value: initialValue,
            activeColor: const Color(0xFF9C41BC),
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }
}
