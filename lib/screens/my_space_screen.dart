import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class MySpaceScreen extends StatelessWidget {
  const MySpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Text(
            "My Space",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2AC6A9), // Teal
            ),
          ),
          const SizedBox(height: 30),

          // --- Achievements Rewards ---
          Text(
            "Achievements Rewards",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFFD700), // Gold
            ),
          ),
          const SizedBox(height: 5),
          Text("For 7 days", style: GoogleFonts.lato(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBadge(Icons.directions_run, "Active"),
              _buildBadge(Icons.bed, "Restful"),
              _buildBadge(Icons.sentiment_satisfied_alt, "Joyful"),
              _buildBadge(Icons.do_not_disturb, "Disciplined"),
            ],
          ),
          const SizedBox(height: 60),

          // --- Progress Tracking (Swapped) ---
          Text(
            "Progress Tracking",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFFD700),
            ), // Gold Title to match MySpace theme
          ),
          const SizedBox(height: 10),
          Center(child: Image.asset('assets/images/plant_growth_stages.png', height: 100, fit: BoxFit.contain)),
          const SizedBox(height: 20),
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

          const SizedBox(height: 60),

          // --- My Best Moments ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My best Moments",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFFD700), // Gold
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download, size: 16, color: Color(0xFF03121A)),
                label: const Text(
                  "Uploade",
                  style: TextStyle(color: Color(0xFF03121A), fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: const Color(0xFF03121A),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 160,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildMomentFolder("Nov 2025"),
                const SizedBox(width: 15),
                _buildMomentFolder("Oct 2025"),
                const SizedBox(width: 15),
                _buildMomentFolder("May 2025"),
                const SizedBox(width: 15),
                _buildMomentFolder("Apr 2025"),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBadge(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: const Color(0xFF2AC6A9), width: 2), // Teal border
          ),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF2AC6A9).withOpacity(0.2), // Light teal fill
            ),
            child: Icon(icon, color: const Color(0xFF2AC6A9), size: 30),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: GoogleFonts.lato(color: const Color(0xFF2AC6A9), fontSize: 12)),
      ],
    );
  }

  Widget _buildMomentFolder(String month) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(Icons.landscape_outlined, size: 60, color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Text(month, style: GoogleFonts.lato(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}
