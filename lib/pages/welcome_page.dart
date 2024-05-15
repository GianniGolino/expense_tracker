import 'package:expense_tracker/pages/authentication_pages/login_page.dart';
import 'package:expense_tracker/pages/authentication_pages/signup_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const LoginPage()));
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: const Size(350, 55),
                  backgroundColor: Theme.of(context).primaryColor),
              child: const Text(
                'Login',
                //TODO set and then use a themeValue for the text
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 6)),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const SignUpPage()));
              },
              style: ElevatedButton.styleFrom(
                  side: BorderSide(
                    width: 1,
                    color: Theme.of(context).primaryColor,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: const Size(350, 55),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor),
              child: const Text(
                'Sign Up',
                //TODO set and then use a themeValue for the text
                style: TextStyle(
                    color: Color(0xFF005757), fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }
}
