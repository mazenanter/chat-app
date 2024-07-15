import 'package:flutter/material.dart';
import 'package:my_chat_app/views/login_view.dart';
import 'package:my_chat_app/views/register_view.dart';
import 'package:my_chat_app/widgets/custom_button.dart';
import 'package:my_chat_app/widgets/navigator.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Column(
            children: [
              const Text(
                'Get Started',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'start with signing up or sign in',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Image.asset(
                'assets/images/Chat bot-bro.png',
              ),
              const SizedBox(
                height: 15,
              ),
              CustomButton(
                onPressed: () {
                  navigateTo(
                    context,
                    RegisterView(),
                  );
                },
                text: 'Sign Up',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onPressed: () {
                  navigateTo(
                    context,
                    LoginView(),
                  );
                },
                text: 'Sign In',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
