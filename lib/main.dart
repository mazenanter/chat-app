import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/bloc_oberver.dart';
import 'package:my_chat_app/constans/constans.dart';
import 'package:my_chat_app/cubits/home_cubit/cubit.dart';
import 'package:my_chat_app/cubits/status_cubit/cubit.dart';
import 'package:my_chat_app/helper/shared_pref.dart';
import 'package:my_chat_app/views/start_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
  } else {}
  Bloc.observer = SimbleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => HomeCubit()
            ..getAllUser()
            ..getUserData(),
        ),
        BlocProvider(
          create: (context) => StatusCubit()..getStatus(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'M.S.G app',
        theme: ThemeData(
          fontFamily: 'Tilt Neon',
        ),
        home: const StartView(),
      ),
    );
  }
}
