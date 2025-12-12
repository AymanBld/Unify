import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/activities_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/services_screen.dart';

import 'screens/my_space_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  List<Widget> get _screens => [
    MainScreen(onNavigate: (index) => setState(() => _currentIndex = index)),
    const ChatScreen(),
    const MySpaceScreen(),
    const ServicesScreen(),
    const ActivitiesScreen(), // Index 4
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.2, 1],
              colors: [Color(0xFF2AC6A9), Color(0xFF00332C)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Welcome\nAyman",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF00332C), fontFamily: 'Poppins'),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 50),
              // Items with Dividers
              _buildCustomDrawerItem(Icons.home, "Home", 0),
              _buildDivider(),
              _buildCustomDrawerItem(Icons.chat_bubble_outline, "AI Chat", 1),
              _buildDivider(),
              _buildCustomDrawerItem(Icons.dashboard_customize, "My Space", 2),
              _buildDivider(),
              _buildCustomDrawerItem(Icons.spa, "Services", 3),
              _buildDivider(),
              _buildCustomDrawerItem(Icons.local_activity, "Activities", 4),
              _buildDivider(),
              _buildCustomDrawerItem(Icons.settings, "Settings", 99),
              const Spacer(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFF042434),
      body: SafeArea(
        child: Stack(
          children: [
            _screens[_currentIndex],
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFF2AC6A9), size: 30), // Teal Menu Icon
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomDrawerItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF00332C), size: 30),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF00332C)),
      ),
      onTap: () {
        if (index != 99) {
          setState(() => _currentIndex = index);
        }
        Navigator.pop(context); // Close Drawer
      },
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(color: const Color(0xFF00332C).withOpacity(0.3), height: 1),
    );
  }
}
