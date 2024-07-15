import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/cubits/home_cubit/cubit.dart';
import 'package:my_chat_app/cubits/home_cubit/states.dart';
import 'package:my_chat_app/models/chat_model.dart';

// ignore: must_be_immutable
class MessageItem extends StatelessWidget {
  MessageItem(
      {super.key,
      required this.msgColor,
      required this.bottomRightRadius,
      required this.bottomLeftRadius,
      required this.topLeftRadius,
      required this.topRightRadius,
      required this.itemColor,
      required this.dateColor,
      required this.alignmentDirectional,
      this.model});

  final Color? msgColor;
  final Color? itemColor;
  final Color? dateColor;
  final Radius bottomRightRadius;
  final Radius bottomLeftRadius;
  final Radius topLeftRadius;
  final Radius topRightRadius;
  final AlignmentDirectional alignmentDirectional;
  ChatModel? model;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Align(
          alignment: alignmentDirectional,
          child: model!.msgImage == ''
              ? Container(
                  decoration: BoxDecoration(
                    color: itemColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: bottomRightRadius,
                      topLeft: topLeftRadius,
                      topRight: topRightRadius,
                      bottomLeft: bottomLeftRadius,
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${model!.text}',
                            style: TextStyle(
                              color: msgColor,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${model!.date}',
                            style: TextStyle(
                              color: dateColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      )),
                )
              : SizedBox(
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    clipBehavior: Clip.antiAlias,
                    child: Image(
                        image: NetworkImage(
                      '${model!.msgImage}',
                    )),
                  )),
        );
      },
    );
  }
}
