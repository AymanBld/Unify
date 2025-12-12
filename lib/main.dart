import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'providers/mental_health_provider.dart';
import 'providers/chat_provider.dart';
import 'main_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MentalHealthProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MindaThon',
        themeMode: ThemeMode.dark,
        theme: _buildDarkTheme(),
        darkTheme: _buildDarkTheme(),
        home: const MainLayout(),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF03121A), // Deep Navy
      primaryColor: const Color(0xFF2AC6A9), // Sea Teal
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF2AC6A9),
        secondary: Color(0xFF2AC6A9),
        surface: Color(0xFF062530), // Slightly Lighter Navy
        background: Color(0xFF03121A),
        onPrimary: Color(0xFF03121A), // Dark Text on Teal
        onSurface: Color(0xFFE2E8F0),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Color(0xFF2AC6A9), fontSize: 24, fontWeight: FontWeight.bold), // Teal Title
        iconTheme: IconThemeData(color: Color(0xFF2AC6A9)),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF062530),
        selectedItemColor: Color(0xFF2AC6A9),
        unselectedItemColor: Color(0xFF64748B),
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF03121A)),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.lato(color: const Color(0xFFE2E8F0)),
        bodyMedium: GoogleFonts.lato(color: const Color(0xFF94A3B8)),
        headlineSmall: GoogleFonts.poppins(color: const Color(0xFF2AC6A9), fontWeight: FontWeight.bold),
        titleLarge: GoogleFonts.poppins(color: const Color(0xFF2AC6A9), fontWeight: FontWeight.w600),
      ),
    );
  }
}
