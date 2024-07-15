import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/cubits/home_cubit/cubit.dart';
import 'package:my_chat_app/cubits/home_cubit/states.dart';

import '../constans/constans.dart';
import 'message_item.dart';

class ChatMsgListView extends StatelessWidget {
  ChatMsgListView({super.key, required this.controller});
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = HomeCubit.get(context).msgList;
        var myId = HomeCubit.get(context).userModel!.uId;
        return Expanded(
          child: ListView.separated(
            reverse: true,
            controller: controller,
            itemBuilder: (context, index) => MessageItem(
              model: list[index],
              msgColor:
                  list[index].senderId == myId ? Colors.white : Colors.black,
              bottomRightRadius: list[index].senderId == myId
                  ? const Radius.circular(16)
                  : const Radius.circular(16),
              bottomLeftRadius:
                  list[index].senderId == myId ? Radius.zero : Radius.zero,
              topLeftRadius: list[index].senderId == myId
                  ? const Radius.circular(16)
                  : const Radius.circular(16),
              topRightRadius: list[index].senderId == myId
                  ? const Radius.circular(16)
                  : const Radius.circular(16),
              itemColor: list[index].senderId == myId
                  ? kPrimaryColor
                  : Colors.grey.withOpacity(0.8),
              dateColor: list[index].senderId == myId
                  ? Colors.grey[400]
                  : Colors.grey[900],
              alignmentDirectional: list[index].senderId == myId
                  ? AlignmentDirectional.topStart
                  : AlignmentDirectional.topEnd,
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemCount: list.length,
          ),
        );
      },
    );
  }
}
