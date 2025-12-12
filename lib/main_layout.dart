import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/activities_screen.dart';
import 'screens/profile_screen.dart';

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
    const MainScreen(),
    const ChatScreen(),
    const MySpaceScreen(),
    ActivitiesScreen(),
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
            children: [
              const SizedBox(height: 60),
              // User Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Color(0xFF00332C),
                      child: Icon(Icons.person, color: Color(0xFF2AC6A9)),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF00332C).withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome Ayman", // Updated as per request
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF00332C)),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "abdelilah7bnms@gmail.com",
                              style: TextStyle(fontSize: 10, color: Color(0xFF00332C)),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              // Items with Dividers
              _buildCustomDrawerItem(Icons.home, "Home", 0),
              _buildDivider(),
              _buildCustomDrawerItem(Icons.chat_bubble_outline, "AI Chat", 1), // Chat Index
              _buildDivider(),
              _buildCustomDrawerItem(Icons.dashboard_customize, "My Space", 2),
              _buildDivider(),
              _buildCustomDrawerItem(Icons.list, "Services", 3), // Maps to Activities
              _buildDivider(),
              _buildCustomDrawerItem(Icons.info_outline, "About us", 4), // Maps to Profile
              _buildDivider(),
              _buildCustomDrawerItem(Icons.settings, "Settings", 99), // Placeholder
              const Spacer(),
              // Bottom circle decoration could be added here if needed
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
