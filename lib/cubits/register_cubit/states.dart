abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {}

class SaveUserInfoErrorState extends RegisterStates {
  final String errMsg;

  SaveUserInfoErrorState(this.errMsg);
}

class SaveUserInfoSuccessState extends RegisterStates {}
