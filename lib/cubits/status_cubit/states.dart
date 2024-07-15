abstract class StatusStates {}

class StatusInitialState extends StatusStates {}

class AddStatusSuccessState extends StatusStates {}

class AddStatusErrorState extends StatusStates {
  final String err;

  AddStatusErrorState(this.err);
}

class AddStatusLoadingState extends StatusStates {}

class GetStatusImageState extends StatusStates {}

class GetStatusSuccessState extends StatusStates {}

class DeleteImageSuccessState extends StatusStates {}

class GetStatusLoadingState extends StatusStates {}

class GetStatusErrorState extends StatusStates {
  final String err;

  GetStatusErrorState(this.err);
}

class DeleteStatusSuccessState extends StatusStates {}

class DeleteStatusLoadingState extends StatusStates {}
