import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key, required this.onTabChanged});

  final void Function(int) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      margin: const EdgeInsets.all(28),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: GNav(
            onTabChange: onTabChanged,
            color: Colors.white,
            activeColor: Colors.white,
            backgroundColor: const Color(0xFF005757),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            tabs: const [
              GButton(
                icon: Icons.home,
                gap: 4,
                text: 'Home',
              ),
              GButton(
                icon: Icons.bar_chart,
                gap: 4,
                text: 'Stats',
              ),
              GButton(
                icon: Icons.calendar_month,
                gap: 4,
                text: 'Monthly',
              ),
              GButton(
                icon: Icons.settings,
                gap: 4,
                text: 'Settings',
              ),
            ]),
      ),
    );
  }
}
