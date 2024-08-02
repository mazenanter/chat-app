import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/cubits/register_cubit/states.dart';
import 'package:my_chat_app/models/user_model.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      saveUserInfo(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((onError) {
      emit(RegisterErrorState());
    });
  }

  UserModel? model;
  void saveUserInfo({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    model = UserModel(
      name: name,
      email: email,
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMdZr1EuUq3mfdLc25mnOO9fTWud-9edshsQ&usqp=CAU',
      uId: uId,
      phone: phone,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model!.toMap())
        .then((value) {
      emit(SaveUserInfoSuccessState());
    }).catchError((onError) {
      emit(SaveUserInfoErrorState(onError.toString()));
    });
  }
}
