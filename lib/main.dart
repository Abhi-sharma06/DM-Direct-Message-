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
      home: Scaffold(
        body: _screens[_selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTap,

          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.whatshot_outlined),
              label: "Whatsapp",
            ),

            BottomNavigationBarItem(icon: Icon(Icons.email),
              label: "Email",
            ),
          ],
        ),

      ),
      routes:{
        '/whatsapp': (context) => const WhatsappScreen(),
        '/email': (context) => const GmailScreen(),
      },
    );
  }
}