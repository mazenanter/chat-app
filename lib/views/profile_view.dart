import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/constans/constans.dart';
import 'package:my_chat_app/cubits/home_cubit/cubit.dart';
import 'package:my_chat_app/cubits/home_cubit/states.dart';
import 'package:my_chat_app/helper/shared_pref.dart';
import 'package:my_chat_app/views/login_view.dart';
import 'package:my_chat_app/views/setting_view.dart';
import 'package:my_chat_app/widgets/custom_button.dart';
import 'package:my_chat_app/widgets/navigator.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var image = HomeCubit.get(context).profileImage;
        var model = HomeCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: const Text('Your Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: image != null
                        ? FileImage(image)
                        : NetworkImage(model!.image) as ImageProvider,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Name : ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        model!.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'email : ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        model.email,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'phone : ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        model.phone,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomButton(
                    text: 'Edit Profile',
                    onPressed: () {
                      navigateTo(context, SettingView());
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomButton(
                    text: 'sign out',
                    onPressed: () {
                      CacheHelper.removeData(key: 'uId').then((value) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginView(),
                          ),
                          (route) => false,
                        );
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
