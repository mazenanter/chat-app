abstract class HomeStates {}

class HomeGetUserInitialState extends HomeStates {}

class HomeGetUserSuccessState extends HomeStates {}

class HomeGetUserLoadingState extends HomeStates {}

class HomeGetUserErrorState extends HomeStates {}

class GetUserDataSuccessState extends HomeStates {}

class GetUserDataErrorState extends HomeStates {}

class GetUserDataLoadingState extends HomeStates {}

class EditProfileSuccessState extends HomeStates {}

class EditProfileLoadingState extends HomeStates {}

class EditProfileErrorState extends HomeStates {}

class OpenGallerySuccessState extends HomeStates {}

class OpenGalleryErrorState extends HomeStates {}

//send msg states
class ChatSendMsgSuccessState extends HomeStates {}

class ChatSendMsgErrorState extends HomeStates {}

class ChatSendMsgLoadingState extends HomeStates {}

//get msg states
class ChatGetMsgSuccessState extends HomeStates {}

class ChatGetMsgErrorState extends HomeStates {}

class ChatGetMsgLoadingState extends HomeStates {}

//get msg Image

class GetMsgImageSuccessState extends HomeStates {}

class RemoveMsgImageSuccessState extends HomeStates {}

class SendMsgImageLoadingState extends HomeStates {}
