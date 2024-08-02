import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_chat_app/cubits/home_cubit/states.dart';
import 'package:my_chat_app/models/user_model.dart';
import 'package:uuid/uuid.dart';
import '../../constans/constans.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../models/chat_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeGetUserInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<UserModel> users = [];

  void getAllUser() {
    emit(HomeGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value) {
      for (var element in value.docs) {
        if (element.data()['uId'] != userModel!.uId) {
          users.add(UserModel.fromJson(element.data()));
        }
        emit(HomeGetUserSuccessState());
      }
    }).catchError((onError) {
      emit(HomeGetUserErrorState(onError.toString()));
    });
  }

//open gallery
  File? profileImage;
  var picker = ImagePicker();

  Future<void> openGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(OpenGallerySuccessState());
    } else {
      emit(OpenGalleryErrorState());
    }
  }

  //get user Data from firebase
  UserModel? userModel;

  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  //upload photo to firebase storage
  void uploadPhoto({
    required String name,
    required String phone,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((p0) => {
              p0.ref
                  .getDownloadURL()
                  .then((value) => {
                        updateUserInfo(
                          name: name,
                          phone: phone,
                          profImage: value,
                        ),
                      })
                  .catchError((onError) {
                // ignore: invalid_return_type_for_catch_error
                return onError.toString();
              })
            })
        .catchError((onError) {
      // ignore: invalid_return_type_for_catch_error
      return onError.toString();
    });
  }

  void updateUserInfo({
    required String name,
    required String phone,
    String? profImage,
  }) {
    UserModel model = UserModel(
      name: name,
      email: userModel!.email,
      image: profImage ?? userModel!.image,
      uId: userModel!.uId,
      phone: phone,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.toMap())
        .then((value) => {
              getUserData(),
            })
        .catchError((onError) {
      // ignore: invalid_return_type_for_catch_error
      return onError.toString();
    });
  }

  //send msg
  void sendMessage({
    required String recieverId,
    String? text,
    String? date,
    String? messageImage,
  }) {
    ChatModel model = ChatModel(
      recieverId: recieverId,
      senderId: userModel!.uId,
      date: date ?? DateTime.now().toString(),
      text: text ?? 'hi',
      msgImage: messageImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(recieverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(ChatSendMsgSuccessState());
    }).catchError((onError) {
      emit(ChatSendMsgErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(recieverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(ChatSendMsgSuccessState());
    }).catchError((onError) {
      emit(ChatSendMsgErrorState());
    });
  }

  List<ChatModel> msgList = [];
//get msg from firebase
  dynamic getMsg({
    required String reciverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(reciverId)
        .collection('messages')
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      msgList = [];
      for (var element in event.docs) {
        msgList.add(ChatModel.fromJson(element.data()));
      }
      emit(ChatGetMsgSuccessState());
    });
  }

  File? msgImage;
  ImagePicker msgImagePicker = ImagePicker();
  Future<void> openMsgImageGallery({
    String? recieverId,
    required String date,
  }) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      msgImage = File(pickedFile.path);
      uploadMessageImage(
        date: date,
        recieverId: recieverId,
      );
      msgImage = null;
      emit(GetMsgImageSuccessState());
    } else {}
  }

  String? msgUrl;
  void removeImage() {
    msgImage = null;
    emit(RemoveMsgImageSuccessState());
  }

  Future uploadMessageImage({
    String? recieverId,
    required String date,
  }) async {
    String uuid = const Uuid().v1();
    var ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('messageImages')
        .child("$uuid.jpg");
    var uploadFile = await ref.putFile(msgImage!);
    msgUrl = await uploadFile.ref.getDownloadURL();
    sendMessage(
        recieverId: recieverId!, messageImage: msgUrl, text: '', date: date);
  }
}
