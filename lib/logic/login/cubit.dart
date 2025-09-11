import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/logic/login/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  /// function to login with email & password
  Future login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccessState(homeScreen: true,fristTime: 1));
      saveScreen(LoginSuccessState(homeScreen: true));
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }

  /// function to save last screen(home/login)
  Future saveScreen(LoginSuccessState loginSuccessState) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("screen", loginSuccessState.homeScreen);
  }

  /// function to get last screen(home/login)
  Future getScreen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool homeScreen = prefs.getBool("screen") ?? false;
    if (homeScreen) emit(LoginSuccessState(homeScreen: true));
  }
}
