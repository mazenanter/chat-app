import 'package:flutter/material.dart';

import '../constans/constans.dart';

class MsgTextField extends StatelessWidget {
  const MsgTextField({
    super.key,
    this.onPressed,
    required this.controller,
    this.galleryImage,
  });
  final void Function()? onPressed;
  final void Function()? galleryImage;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus!.unfocus();
            },
            decoration: InputDecoration(
              hintText: 'write message',
              prefixIcon: IconButton(
                onPressed: galleryImage,
                icon: Icon(
                  Icons.photo_camera_back_outlined,
                  size: 26,
                  color: Colors.black.withOpacity(0.7),
                ),
              ),
              suffixIcon: IconButton(
                onPressed: onPressed,
                icon: const Icon(
                  Icons.send,
                  color: kPrimaryColor,
                  size: 32,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
