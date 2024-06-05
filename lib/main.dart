import 'package:expense_tracker/controllers/expense_controller.dart';
import 'package:expense_tracker/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

void main() {
  Get.put(ExpenseController());
  runApp(const ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  const ExpenseTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: ThemeData(
          primaryColor: const Color(0xFF002A7F),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20))),
      darkTheme: ThemeData(),
      home: const WelcomePage(),
    );
  }
}
