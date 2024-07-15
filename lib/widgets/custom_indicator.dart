import 'package:flutter/material.dart';
import 'package:my_chat_app/constans/constans.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 25,
        height: 25,
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
