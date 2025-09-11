import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/logic/get_notes/cubit.dart';
import 'package:firebase_project/logic/get_notes/state.dart';
import 'package:firebase_project/logic/login/cubit.dart';
import 'package:firebase_project/logic/login/state.dart';
import 'package:firebase_project/presentation/screens/create_note_screen.dart';
import 'package:firebase_project/presentation/screens/login.dart';
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
                Row(
                  spacing: 20,
                  children: [
                    // زرار إضافة Note
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NoteScreen()),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 50),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 50,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff4E55D7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Add Note",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    // زرار تسجيل الخروج
                    InkWell(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        context.read<LoginCubit>().saveScreen(
                              LoginSuccessState(homeScreen: false),
                            );
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                          (route) => false,
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 50,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xff4E55D7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Log Out",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // BlocBuilder لعرض النوتس
                BlocBuilder<GetNotesCubit, GetNotesStates>(
                  builder: (context, state) {
                    if (state is GetNotesLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GetNotesSuccessState) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.notes.length,
                          itemBuilder: (context, index) {
                            final note = state.notes[index];
                            return Card(
                              margin: const EdgeInsets.only(top: 16),
                              color: Colors.grey.shade200,
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      note.headline,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            note.description,
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                        ),
                                        Text(
                                          note.createdAt.toString(),
                                          style: const TextStyle(fontSize: 16),
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
                    } else if (state is GetNotesErrorState) {
                      return const Center(
                        child: Text("Failed to load notes"),
                      );
                    }
                    return const SizedBox.shrink();
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
