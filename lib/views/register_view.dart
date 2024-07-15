import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/cubits/register_cubit/cubit.dart';
import 'package:my_chat_app/cubits/register_cubit/states.dart';
import 'package:my_chat_app/views/login_view.dart';
import 'package:my_chat_app/widgets/custom_indicator.dart';
import 'package:my_chat_app/widgets/toast.dart';

import '../widgets/custom_button.dart';
import '../widgets/custom_text_form.dart';
import '../widgets/navigator.dart';

// ignore: must_be_immutable
class RegisterView extends StatelessWidget {
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is SaveUserInfoSuccessState) {
            showSuccessToast(msg: 'Email Created');
            navigateTo(context, LoginView());
          } else if (state is SaveUserInfoErrorState) {
            showErrorToast(msg: 'oop,try again');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Register',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        'you and your friends always connected',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomTextForm(
                        controller: nameController,
                        text: 'Name',
                        prefIcon: Icons.person_2_outlined,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextForm(
                        controller: emailController,
                        text: 'Email',
                        prefIcon: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextForm(
                        obsText: true,
                        controller: passwordController,
                        text: 'Password',
                        prefIcon: Icons.lock_outlined,
                        sufIcon: Icons.visibility_off_outlined,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextForm(
                        textInputType: TextInputType.phone,
                        controller: phoneController,
                        text: 'Phone',
                        prefIcon: Icons.phone_iphone_outlined,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ConditionalBuilder(
                        condition: state is! RegisterLoadingState,
                        builder: (context) => CustomButton(
                          text: 'Sign Up',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              RegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        fallback: (context) => const CustomIndicator(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'already have an acoount?',
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(
                                context,
                                LoginView(),
                              );
                            },
                            child: const Text('Log In'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
