import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/constans/constans.dart';
import 'package:my_chat_app/cubits/home_cubit/cubit.dart';
import 'package:my_chat_app/cubits/home_cubit/states.dart';
import 'package:my_chat_app/models/user_model.dart';
import 'package:my_chat_app/widgets/chat_msg_list_view.dart';
import 'package:my_chat_app/widgets/msg_text_field.dart';

// ignore: must_be_immutable
class ChatView extends StatelessWidget {
  ChatView({super.key, required this.model});

  UserModel? model;
  TextEditingController textController = TextEditingController();
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        HomeCubit.get(context).getMsg(reciverId: model!.uId);
        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage(model!.image),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      model!.name,
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ChatMsgListView(
                      controller: controller,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    MsgTextField(
                      controller: textController,
                      onPressed: () {
                        HomeCubit.get(context).sendMessage(
                          recieverId: model!.uId,
                          text: textController.text,
                          date: formatted,
                          messageImage: '',
                        );
                        controller.animateTo(
                          0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.fastOutSlowIn,
                        );
                        textController.text = '';
                      },
                      galleryImage: () {
                        HomeCubit.get(context).openMsgImageGallery(
                          recieverId: model!.uId,
                          date: formatted,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
