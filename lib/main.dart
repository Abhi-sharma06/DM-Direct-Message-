import 'package:flutter/material.dart';
import 'screens/whatsapp.dart';
import 'screens/email.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const WhatsappScreen(),
    const GmailScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
        useMaterial3: true,
      ),

      home: Scaffold(
        body: _screens[_selectedIndex],

        // ✅ MODERN BOTTOM NAV
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onTap,

              backgroundColor: Colors.white,
              elevation: 0,
              type: BottomNavigationBarType.fixed,

              selectedItemColor: _selectedIndex == 0
                  ? const Color(0xFF128C7E) // WhatsApp Green
                  : const Color(0xFFEA4335), // Gmail Red

              unselectedItemColor: Colors.grey,

              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
              ),

              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  activeIcon: Icon(Icons.chat_bubble),
                  label: "WhatsApp",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.mail_outline),
                  activeIcon: Icon(Icons.mail),
                  label: "Email",
                ),
              ],
            ),
          ),
        ),
      ),

      routes: {
        '/whatsapp': (context) => const WhatsappScreen(),
        '/email': (context) => const GmailScreen(),
      },
    );
  }
}