import 'package:flutter/material.dart';
import 'package:my_chat_app/views/add_story_view.dart';
import 'package:my_chat_app/widgets/navigator.dart';
import '../constans/constans.dart';

// ignore: must_be_immutable
class FabStatus extends StatelessWidget {
  FabStatus({super.key});

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: kPrimaryColor,
      onPressed: () {
        navigateTo(context, AddStoryView());
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
