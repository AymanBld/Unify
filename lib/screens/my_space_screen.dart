import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          const SizedBox(height: 30),

          // --- Your Plans ---
          Text(
            "Your Plans",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFFD700), // Gold
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1D4150).withOpacity(0.5), // Semi-transparent dark slate
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _buildPlanButton("Preparation Exam Plan", "2025/12/12 to 2026/01/01"),
                const SizedBox(height: 15),
                _buildPlanButton("Exam Plan", "2025/01/12 to 2026/01/022"),
                const SizedBox(height: 15),
                _buildPlanButton("learn Desing Plan", "2025/12/12 to 2026/06/06"),
                const SizedBox(height: 20),
                Text("Select Plan to More Discover", style: GoogleFonts.lato(color: const Color(0xFF2AC6A9), fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 30),

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

  Widget _buildPlanButton(String title, String dateRange) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFD700), // Gold
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(color: const Color(0xFF03121A), fontWeight: FontWeight.bold, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          Text(
            dateRange,
            style: GoogleFonts.lato(color: const Color(0xFF03121A).withOpacity(0.8), fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
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
          child: Stack(
            children: [
              // Placeholder for the "mountain" icon in the design
              Center(child: Icon(Icons.landscape_outlined, size: 60, color: Colors.white70)),
              Positioned(top: 10, left: 10, child: Icon(Icons.circle_outlined, size: 16, color: Colors.white70)),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(month, style: GoogleFonts.lato(color: Colors.white, fontSize: 14)),
      ],
    );
  }
}
