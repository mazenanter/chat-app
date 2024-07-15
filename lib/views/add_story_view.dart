import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/constans/constans.dart';
import 'package:my_chat_app/cubits/status_cubit/cubit.dart';
import 'package:my_chat_app/cubits/status_cubit/states.dart';
import 'package:my_chat_app/widgets/toast.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_indicator.dart';
import '../widgets/custom_text_form.dart';

// ignore: must_be_immutable
class AddStoryView extends StatelessWidget {
  AddStoryView({super.key});
  TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StatusCubit, StatusStates>(
      listener: (context, state) {
        if (state is AddStatusSuccessState) {
          showSuccessToast(msg: 'Added Successfully');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var statusImage = StatusCubit.get(context).statusImage;
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
            title: const Text(
              'Add Story',
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextForm(
                        text: 'title',
                        prefIcon: Icons.title,
                        controller: titleController),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        StatusCubit.get(context).openGalleryStatus();
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'add photo',
                            style: TextStyle(fontSize: 18),
                          ),
                          Icon(
                            Icons.photo,
                          ),
                        ],
                      ),
                    ),
                    if (statusImage != null)
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image(
                              image: FileImage(statusImage),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              StatusCubit.get(context).deleteImage();
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    state is AddStatusLoadingState
                        ? const CustomIndicator()
                        : CustomButton(
                            text: 'add status',
                            onPressed: () {
                              if (statusImage == null) {
                                StatusCubit.get(context).addStatus(
                                  context: context,
                                  title: titleController.text,
                                  date: formatted,
                                );
                                titleController.text = '';
                              } else {
                                StatusCubit.get(context).uploadStatusImage(
                                  context: context,
                                  date: formatted,
                                  title: titleController.text,
                                );
                                titleController.text = '';
                              }
                            }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
