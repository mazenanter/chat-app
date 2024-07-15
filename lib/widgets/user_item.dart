import 'package:flutter/material.dart';
import 'package:my_chat_app/models/user_model.dart';
import 'package:my_chat_app/views/chat_view.dart';
import 'package:my_chat_app/widgets/navigator.dart';

import '../constans/constans.dart';

// ignore: must_be_immutable
class UserItem extends StatelessWidget {
  UserItem({super.key, required this.model});
  UserModel? model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context,
            ChatView(
              model: model,
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(
                model!.image,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model!.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            const Spacer(),
            Text(
              formatted.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
