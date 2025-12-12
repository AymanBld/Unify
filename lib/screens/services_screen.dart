import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  final List<Map<String, dynamic>> _services = const [
    {"title": "Activities", "icon": Icons.local_activity, "color": Color(0xFF2AC6A9), "description": "Engage in fun tasks"},
    {"title": "Games", "icon": Icons.sports_esports, "color": Color(0xFFFFD700), "description": "Relax and play"},
    {"title": "Books", "icon": Icons.menu_book, "color": Color(0xFF64FFDA), "description": "Read for mental growth"},
    {"title": "Docs", "icon": Icons.article, "color": Color(0xFF2AC6A9), "description": "Helpful resources"},
    {"title": "Online AI Test", "icon": Icons.psychology, "color": Color(0xFFFFD700), "description": "Analyze your state"},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          // Clean header without "Enjoy our services"
          Text(
            "Our Services",
            style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: const Color(0xFF2AC6A9)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "Explore what we can do for you",
            style: GoogleFonts.lato(fontSize: 14, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 0.85,
            ),
            itemCount: _services.length,
            itemBuilder: (context, index) {
              final service = _services[index];
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF062530),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: (service["color"] as Color).withOpacity(0.3), width: 1),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5))],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: (service["color"] as Color).withOpacity(0.1)),
                      child: Icon(service["icon"] as IconData, color: service["color"] as Color, size: 32),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      service["title"] as String,
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        service["description"] as String,
                        style: GoogleFonts.lato(fontSize: 12, color: Colors.white54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
