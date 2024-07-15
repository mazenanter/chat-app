import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chat_app/cubits/home_cubit/cubit.dart';
import 'package:my_chat_app/cubits/status_cubit/states.dart';
import 'package:my_chat_app/models/status_model.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StatusCubit extends Cubit<StatusStates> {
  StatusCubit() : super(StatusInitialState());

  static StatusCubit get(context) => BlocProvider.of(context);
// open gallary to set status image
  File? statusImage;
  ImagePicker picker = ImagePicker();
  Future<void> openGalleryStatus() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      statusImage = File(pickedFile.path);
      emit(GetStatusImageState());
    } else {}
  }

  //add status
  List<dynamic> statusId = [];
  void addStatus({
    required String title,
    required String date,
    String? statusImage,
    required BuildContext context,
  }) {
    emit(AddStatusLoadingState());
    StatusModel model = StatusModel(
      name: HomeCubit.get(context).userModel!.name,
      image: HomeCubit.get(context).userModel!.image,
      title: title,
      date: date,
      statusImage: statusImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('status')
        .add(model.toMap())
        .then((value) {
      emit(AddStatusSuccessState());
      getStatus();
    }).catchError((onError) {
      emit(AddStatusErrorState(onError));
    });
  }

  //upload status image to firebase storage
  String? statusImageUrl;
  Future uploadStatusImage({
    required String date,
    String? title,
    required BuildContext context,
  }) async {
    emit(AddStatusLoadingState());
    String uuid = const Uuid().v1();
    var ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('statusImages')
        .child("$uuid.jpg");
    var uploadFile = await ref.putFile(statusImage!);
    statusImageUrl = await uploadFile.ref.getDownloadURL();
    // ignore: use_build_context_synchronously
    addStatus(
        statusImage: statusImageUrl,
        title: title ?? '',
        date: date,
        context: context);
  }

//get all status from firestore
  List<StatusModel> statusList = [];
  void getStatus() {
    emit(GetStatusLoadingState());
    FirebaseFirestore.instance.collection('status').get().then((value) {
      statusList = [];
      statusId = [];
      for (var element in value.docs) {
        statusId.add(element.id);
        statusList.add(StatusModel.fromJson(element.data()));
      }
      emit(GetStatusSuccessState());
    }).catchError((onError) {
      emit(GetStatusErrorState(onError));
    });
  }

  void deleteImage() {
    statusImage = null;
    emit(DeleteImageSuccessState());
  }

  // delete item from firestore
  void deleteStory(String statusId) {
    emit(DeleteStatusLoadingState());
    FirebaseFirestore.instance
        .collection('status')
        .doc(statusId)
        .delete()
        .then((value) {
      emit(DeleteStatusSuccessState());
      getStatus();
    });
  }
}
