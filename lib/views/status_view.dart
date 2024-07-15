import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:my_chat_app/cubits/status_cubit/cubit.dart';
import 'package:my_chat_app/cubits/status_cubit/states.dart';
import 'package:my_chat_app/models/status_model.dart';
import 'package:my_chat_app/widgets/custom_indicator.dart';

// ignore: must_be_immutable
class StatusView extends StatelessWidget {
  StatusView({super.key, required this.model, required this.index});
  StatusModel model;
  late int index;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatusCubit, StatusStates>(
      listener: (context, state) {
        if (state is DeleteStatusLoadingState) {
          const CustomIndicator();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              FocusedMenuHolder(
                bottomOffsetHeight: 80.0,
                animateMenuItems: true,
                blurBackgroundColor: Colors.black54,
                menuOffset: 10.0,
                blurSize: 5.0,
                menuItemExtent: 45,
                menuBoxDecoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                menuItems: [
                  FocusedMenuItem(
                      title: const Text(
                        "Delete",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                      trailingIcon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        StatusCubit.get(context).deleteStory(
                            StatusCubit.get(context).statusId[index]);
                      }),
                ],
                openWithTap: true,
                duration: Duration(milliseconds: 100),
                onPressed: () {},
                child: Card(
                  elevation: 10,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.grey)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(model.image),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  model.date,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (model.title != '')
                          const SizedBox(
                            height: 16,
                          ),
                        if (model.title != '')
                          Text(
                            model.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (model.statusImage != '')
                          const SizedBox(
                            height: 16,
                          ),
                        if (model.statusImage != '')
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image(
                                  image: NetworkImage('${model.statusImage}')),
                            ),
                          ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
