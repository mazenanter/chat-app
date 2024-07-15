import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/cubits/login_cubit/cubit.dart';
import 'package:my_chat_app/cubits/login_cubit/states.dart';
import 'package:my_chat_app/helper/shared_pref.dart';
import 'package:my_chat_app/views/home_view.dart';
import 'package:my_chat_app/views/register_view.dart';
import 'package:my_chat_app/widgets/custom_button.dart';
import 'package:my_chat_app/widgets/custom_indicator.dart';
import 'package:my_chat_app/widgets/custom_text_form.dart';
import 'package:my_chat_app/widgets/navigator.dart';
import 'package:my_chat_app/widgets/toast.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            showSuccessToast(msg: 'Successfully');
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) => {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeView(),
                      ),
                      (route) => false),
                });
          } else if (state is LoginErrorState) {
            showErrorToast(msg: 'oops,try again');
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
                child: Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          'remember to get up & stretch once',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          ' in a while - your friend at chat',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        CustomTextForm(
                          controller: emailController,
                          text: 'Email',
                          prefIcon: Icons.person_2_outlined,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        CustomTextForm(
                          obsText: true,
                          controller: passwordController,
                          text: 'Password',
                          prefIcon: Icons.lock_outlined,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) => CustomButton(
                            text: 'Sign In',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          fallback: (context) => const CustomIndicator(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(
                                  context,
                                  RegisterView(),
                                );
                              },
                              child: const Text('Sign Up Here'),
                            ),
                          ],
                        ),
                      ],
                    ),
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
