import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/logic/signup/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUPCubit extends Cubit<SignUpStates> {
  SignUPCubit() : super(SignUPInitialState());

  /// function to create account with email & password
  Future signUp({required String email, required String password}) async {
    emit(SignUPLoadingState());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignUPSuccessState(homeScreen: true,fristTime: 1));
      saveScreen(SignUPSuccessState(homeScreen: true));
    } catch (e) {
      emit(SignUPErrorState(errorMessage: e.toString()));
    }
  }

  /// function to save last screen(home/login)
  Future saveScreen(SignUPSuccessState signUpSuccessState) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("screen", signUpSuccessState.homeScreen);
  }

}
