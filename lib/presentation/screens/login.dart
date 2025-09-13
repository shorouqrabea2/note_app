import 'package:firebase_project/core/utils/colors_manager.dart';
import 'package:firebase_project/logic/login/cubit.dart';
import 'package:firebase_project/logic/login/state.dart';
import 'package:firebase_project/presentation/screens/home_screen.dart';
import 'package:firebase_project/presentation/screens/signup.dart';
import 'package:firebase_project/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatelessWidget {
  Login({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit()..getScreen(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState && state.fristTime == 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Successfully"),
                backgroundColor: ColorsManager.primary,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (state is LoginSuccessState) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: ColorsManager.primary,
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Log in",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                              ),
                            ),
                            Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          indent: 30,
                          endIndent: 230,
                          thickness: 3,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Your Email",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",
                      ),
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        hintStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 30,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        fontFamily: "OpenSans",
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          size: 30,
                          color: Colors.grey,
                        ),
                        hintText: "Enter your password",
                        hintStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          color: Colors.grey,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 30,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                      ),
                      obscureText: true,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 280),
                      child: Text(
                        "Forgot password?",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "Inter",
                          color: ColorsManager.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    AppButton(
                      function: () {
                        context.read<LoginCubit>().login(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                      text: "Continue",
                      loadingState: (state is LoginLoadingState ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      spacing: 20,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                        Text(
                          "Or",
                          style: TextStyle(
                            fontSize: 25,
                            fontFamily: "OpenSans",
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          Icon(Icons.apple, size: 40),
                          Text(
                            "Login with Apple",
                            style: TextStyle(
                              fontSize: 23,
                              fontFamily: "Inter",
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 110, top: 16, bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        spacing: 10,
                        children: [
                          Image.asset(
                            "assets/images/google_icon.png",
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            "Login with Google",
                            style: TextStyle(
                              fontSize: 23,
                              fontFamily: "Inter",
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don’t have an account? ",
                          style: TextStyle(
                            fontSize: 23,
                            fontFamily: "OpenSans",
                            color: Colors.grey,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 23,
                              fontFamily: "OpenSans",
                              color: ColorsManager.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
