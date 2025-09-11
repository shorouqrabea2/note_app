class SignUpStates {}

class SignUPInitialState extends SignUpStates {}

class SignUPLoadingState extends SignUpStates {}

class SignUPSuccessState extends SignUpStates {
  bool homeScreen = false;
  int? fristTime;
  SignUPSuccessState({this.fristTime,required this.homeScreen});
}

class SignUPErrorState extends SignUpStates {
  final String errorMessage;
  SignUPErrorState({required this.errorMessage});
}
