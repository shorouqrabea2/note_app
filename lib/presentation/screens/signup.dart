import 'package:firebase_project/core/utils/colors_manager.dart';
import 'package:firebase_project/logic/signup/cubit.dart';
import 'package:firebase_project/logic/signup/state.dart';
import 'package:firebase_project/presentation/screens/home_screen.dart';
import 'package:firebase_project/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Signup extends StatelessWidget {
  Signup({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUPCubit(),
      child: BlocConsumer<SignUPCubit, SignUpStates>(
        listener: (context, state) {
          if (state is SignUPSuccessState && state.fristTime == 1) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Successfully"),
                backgroundColor: ColorsManager.primary,
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
            );
          } else if (state is SignUPSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
            );
          } else if (state is SignUPErrorState) {
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
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: "OpenSans",
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.black,
                          indent: 220,
                          endIndent: 30,
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
                    AppButton(
                      function: () {
                        context.read<SignUPCubit>().signUp(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      },
                      text: "Continue",
                      loadingState: (state is SignUPLoadingState),
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
