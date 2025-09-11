class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  bool homeScreen = false;
  int? fristTime;
  LoginSuccessState({this.fristTime, required this.homeScreen});
}

class LoginErrorState extends LoginStates {
  final String errorMessage;
  LoginErrorState({required this.errorMessage});
}
