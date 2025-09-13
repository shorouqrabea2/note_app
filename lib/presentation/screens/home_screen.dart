import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/logic/get_notes/cubit.dart';
import 'package:firebase_project/logic/get_notes/state.dart';
import 'package:firebase_project/logic/login/cubit.dart';
import 'package:firebase_project/logic/login/state.dart';
import 'package:firebase_project/presentation/screens/create_note_screen.dart';
import 'package:firebase_project/presentation/screens/login.dart';
import 'package:firebase_project/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetNotesCubit()..getNotes(),
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: Row(
                    spacing: 20,
                    children: [
                      AppButton(
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoteScreen(),
                            ),
                          );
                        },
                        text: "Add Note",
                        width: 150,
                      ),
                      AppButton(
                        function: () async {
                          await FirebaseAuth.instance.signOut();
                          LoginCubit().saveScreen(
                            LoginSuccessState(homeScreen: false),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        text: "Log out",
                        width: 150,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                BlocBuilder<GetNotesCubit, GetNotesStates>(
                  builder: (context, state) {
                    if (state is GetNotesLoadingState) {
                      return Lottie.asset("");
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.only(top: 16),
                            color: Colors.grey.shade200,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 40,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Meeting",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Excepteur sint occaecat cupidatat non proiden.",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      Spacer(),
                                      Text(
                                        "9:00 am",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
