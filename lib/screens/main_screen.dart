import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatelessWidget {
  final Function(int index) onNavigate;

  const MainScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // ... (existing build code)
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ... (existing headers)
          // Logo/Title
          const SizedBox(height: 100),
          Center(
            child: Text(
              'Unify',
              style: GoogleFonts.titanOne(
                fontSize: 48,
                color: const Color(0xFF2AC6A9),
                fontWeight: FontWeight.bold,
              ).copyWith(fontFamilyFallback: ['Cursive', 'Serif']),
            ),
          ),
          const SizedBox(height: 30),

          // Toggle Row
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(color: const Color(0xFF062530), borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(color: const Color(0xFF0F3A47), borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      'Daily Challenges',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(color: const Color(0xFF2AC6A9), fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Progress Tracking',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(color: const Color(0xFF2AC6A9), fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),

          // Main Buttons
          _buildMainButton(context, "Student Hub", () {
            onNavigate(4); // Index for ActivitiesScreen
          }),
          const SizedBox(height: 20),
          _buildMainButton(context, "Mental Health Assistant", () {
            onNavigate(1); // Index for ChatScreen
          }),

          const SizedBox(height: 60),
          Center(
            child: Opacity(opacity: 0.7, child: Image.asset('assets/images/logo.png', height: 250, fit: BoxFit.contain)),
          ),
        ],
      ),
    );
  }

  Widget _buildMainButton(BuildContext context, String title, VoidCallback onTap) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2AC6A9),
          foregroundColor: const Color(0xFF03121A),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 5,
        ),
        child: Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
