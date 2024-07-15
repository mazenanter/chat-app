import 'package:flutter/material.dart';
import 'package:my_chat_app/constans/constans.dart';

// ignore: must_be_immutable
class CustomTextForm extends StatelessWidget {
  CustomTextForm(
      {super.key,
      required this.text,
      required this.prefIcon,
      this.sufIcon,
      required this.controller,
      this.obsText = false,
      this.textInputType});
  final String text;
  final IconData prefIcon;
  final IconData? sufIcon;
  final TextEditingController controller;
  final TextInputType? textInputType;
  bool obsText = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
        TextFormField(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          keyboardType: textInputType,
          validator: (value) {
            if (value!.length < 6) {
              return 'length is too short';
            } else if (value.isEmpty) {
              return 'must not be empty';
            }
            return null;
          },
          controller: controller,
          obscureText: obsText,
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
              color: kPrimaryColor,
            )),
            prefixIcon: Icon(
              prefIcon,
              color: kPrimaryColor,
            ),
            suffixIcon: Icon(
              sufIcon,
              color: kPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
