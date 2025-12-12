import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/activity_model.dart';
import '../providers/mental_health_provider.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  // Hardcoded list from the user's design image
  final List<ActivityModel> _challenges = [
    ActivityModel(
      id: '1',
      title: 'Check In With Yourself',
      description: 'Just noticing your feelings builds awareness.',
      icon: Icons.psychology,
      impactScore: 5,
    ),
    ActivityModel(
      id: '2',
      title: 'No Phone 10 Minutes',
      description: 'Take a short break from your phone to clear your mind.',
      icon: Icons.phonelink_erase,
      impactScore: 10,
    ),
    ActivityModel(
      id: '3',
      title: 'Wake up early',
      description: 'Try waking up a little earlier each day',
      icon: Icons.alarm,
      impactScore: 5,
    ),
    ActivityModel(
      id: '4',
      title: 'Nature Glance',
      description: 'Look outside at the sky, a tree',
      icon: Icons.forest,
      impactScore: 5,
    ),
    ActivityModel(
      id: '5',
      title: 'Minute Smile Reset',
      description: 'even a small smile can lift your mood',
      icon: Icons.sentiment_satisfied_alt,
      impactScore: 5,
    ),
  ];

  // Track checked state locally
  final Set<String> _completedIds = {};

  void _toggleActivity(String id, int score) {
    setState(() {
      if (_completedIds.contains(id)) {
        _completedIds.remove(id);
      } else {
        _completedIds.add(id);
        Provider.of<MentalHealthProvider>(context, listen: false).updateScore(score);
      }
    });
  }

  void _addChallenge() {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF062530),
        title: Text("New Challenge", style: GoogleFonts.poppins(color: const Color(0xFF2AC6A9))),
        content: TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "e.g., Read 5 pages",
            hintStyle: TextStyle(color: Colors.white54),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF2AC6A9))),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2AC6A9)),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                setState(() {
                  _challenges.add(
                    ActivityModel(
                      id: DateTime.now().toString(),
                      title: controller.text,
                      description: 'Custom personal challenge',
                      icon: Icons.star,
                      impactScore: 5,
                    ),
                  );
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add", style: TextStyle(color: Color(0xFF03121A))),
          ),
        ],
      ),
    );
  }

  bool _showAll = false;

  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 5, right: 20, left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Text(
            "Daily Challenges",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF2AC6A9)),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF062530), // Dark Navy Card
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0xFF2AC6A9).withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                ..._challenges.take(_showAll ? _challenges.length : 4).map((activity) {
                  final isChecked = _completedIds.contains(activity.id);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    activity.title,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: isChecked ? Colors.white.withOpacity(0.7) : Colors.white,
                                      decoration: isChecked ? TextDecoration.lineThrough : null,
                                      decorationColor: const Color(0xFF2AC6A9),
                                      decorationThickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                activity.description,
                                style: GoogleFonts.lato(
                                  fontSize: 11,
                                  color: const Color(0xFF94A3B8), // Cool Grey
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () => _toggleActivity(activity.id, activity.impactScore),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isChecked ? const Color(0xFF2AC6A9) : Colors.transparent, // Teal Fill
                              border: Border.all(color: const Color(0xFF2AC6A9), width: 2),
                            ),
                            child: isChecked
                                ? const Icon(Icons.check, size: 18, color: Color(0xFF03121A)) // Dark Check
                                : null,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 5),
                Divider(height: 10, color: const Color(0xFF2AC6A9).withValues(alpha: 0.5)),
                GestureDetector(
                  onTap: () => setState(() => _showAll = !_showAll),
                  child: Icon(
                    _showAll ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: const Color(0xFF2AC6A9),
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _addChallenge,
            icon: const Icon(Icons.add, color: Color(0xFF00332C)),
            label: Text(
              "Add perso challenge",
              style: GoogleFonts.poppins(color: const Color(0xFF00332C), fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
          ),
          // const SizedBox(height: 30),
          Divider(height: 100, color: const Color(0xFF2AC6A9).withValues(alpha: 0.5)),
          Text(
            "Progress Tracking",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF2AC6A9)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: true, drawVerticalLine: false),
                titlesData: const FlTitlesData(
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 10, reservedSize: 30)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 1)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      const FlSpot(21, 18),
                      const FlSpot(22, 26),
                      const FlSpot(23, 23),
                      const FlSpot(24, 35),
                      const FlSpot(25, 36),
                    ],
                    isCurved: true,
                    color: const Color(0xFF64FFDA), // Neon Teal
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF64FFDA).withOpacity(0.1), // Gradient fill
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                "7",
                style: TextStyle(color: Color(0xFFFFD700), fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.local_fire_department, color: Color(0xFFFFD700)),
              const SizedBox(width: 8),
              Text(
                "120Xp",
                style: GoogleFonts.poppins(color: const Color(0xFFFFD700), fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
