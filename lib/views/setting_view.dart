import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/constans/constans.dart';
import 'package:my_chat_app/cubits/home_cubit/cubit.dart';
import 'package:my_chat_app/cubits/home_cubit/states.dart';
import 'package:my_chat_app/widgets/custom_indicator.dart';
import 'package:my_chat_app/widgets/custom_text_form.dart';

// ignore: must_be_immutable
class SettingView extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = HomeCubit.get(context).userModel!.name;
        phoneController.text = HomeCubit.get(context).userModel!.phone;
        var image = HomeCubit.get(context).profileImage;
        var model = HomeCubit.get(context).userModel;
        return ConditionalBuilder(
          condition: state is! GetUserDataLoadingState,
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    if (image == null) {
                      HomeCubit.get(context).updateUserInfo(
                        name: nameController.text,
                        phone: phoneController.text,
                      );
                    } else {
                      HomeCubit.get(context).uploadPhoto(
                          name: nameController.text,
                          phone: phoneController.text);
                    }
                  },
                  icon: const Icon(Icons.done),
                ),
              ],
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: image != null
                              ? FileImage(image)
                              : NetworkImage(model?.image ??
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMdZr1EuUq3mfdLc25mnOO9fTWud-9edshsQ&usqp=CAU')
                                  as ImageProvider,
                        ),
                        CircleAvatar(
                          radius: 27,
                          backgroundColor: kPrimaryColor,
                          child: IconButton(
                            onPressed: () {
                              HomeCubit.get(context).openGallery();
                            },
                            icon: const Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextForm(
                      sufIcon: Icons.edit,
                      text: 'Name',
                      prefIcon: Icons.person,
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    CustomTextForm(
                      sufIcon: Icons.edit,
                      text: 'Phone',
                      prefIcon: Icons.phone_iphone_outlined,
                      controller: phoneController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => const CustomIndicator(),
        );
      },
    );
  }
}
