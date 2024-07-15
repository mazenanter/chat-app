import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/cubits/home_cubit/cubit.dart';
import 'package:my_chat_app/cubits/home_cubit/states.dart';
import 'package:my_chat_app/widgets/custom_indicator.dart';
import 'package:my_chat_app/widgets/user_item.dart';
import 'package:flutter/material.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is EditProfileLoadingState) {
          HomeCubit.get(context).getUserData();
        }
        var users = HomeCubit.get(context).users;
        return ConditionalBuilder(
          condition: users.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => UserItem(
              model: users[index],
            ),
            separatorBuilder: (context, index) => Container(
              height: 1,
              color: Colors.grey,
            ),
            itemCount: users.length,
          ),
          fallback: (context) => const CustomIndicator(),
        );
      },
    );
  }
}
