import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:parkingadmin/bookings/view/booking.dart';
import 'package:parkingadmin/homepage/view/homepage.dart';
import 'package:parkingadmin/payments/view/payments.dart';

import 'package:parkingadmin/profile/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedindex = 0;

  void _onltemTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  final List<Widget> _widgets = [
    HomePage(),
    Bookings(),
   Payments(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgets.elementAt(_selectedindex),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: const Color.fromARGB(255, 235, 219, 174),
        animationDuration: const Duration(microseconds: 300),
        height: 60,
        items: const [
          Icon(
            Icons.home,
            color: Colors.black,
          ),
          Icon(
            Icons.book_online_rounded,
            color: Colors.black,
          ),
          Icon(
            Icons.payment,
            color: Colors.black,
          ),
          Icon(
            Icons.settings,
            color: Colors.black,
          ),
        ],
        index: _selectedindex,
        onTap: _onltemTapped,
      ),
    );
  }
}
