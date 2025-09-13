import 'package:firebase_project/core/utils/colors_manager.dart';
import 'package:firebase_project/data/note_model/note_model.dart';
import 'package:firebase_project/logic/create_note/cubit.dart';
import 'package:firebase_project/logic/create_note/state.dart';
import 'package:firebase_project/presentation/screens/home_screen.dart';
import 'package:firebase_project/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteScreen extends StatelessWidget {
  NoteScreen({super.key});
  TextEditingController headlineController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateNoteCubit(),
      child: BlocConsumer<CreateNoteCubit, CreateNoteStates>(
        listener: (context, state) {
          if (state is CreateNoteSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Successfully"),
                backgroundColor: Color(0xff4E55D7),
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false,
            );
          } else if (state is CreateNoteErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Color(0xff4E55D7),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.only(top: 130, right: 50, left: 50),
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Create New Note",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("Head line", style: TextStyle(fontSize: 20)),
                    TextFormField(
                      controller: headlineController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        hintText: "Enter Note Address",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    Text("Description", style: TextStyle(fontSize: 20)),
                    TextFormField(
                      controller: descriptionController,
                      textAlignVertical: TextAlignVertical(y: -1),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: EdgeInsets.only(
                          bottom: 200,
                          left: 20,
                          top: 10,
                        ),
                        hintText: "Enter Your Description",
                        hintStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 100),
                    Center(
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(16),
                          color: ColorsManager.primary
                        ),
                        child: Center(
                          child: Text(
                            "Select Media",
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: "OpenSans",
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    AppButton(
                      function: () {
                        context.read<CreateNoteCubit>().createNote(
                          NoteModel(
                            headline: headlineController.text,
                            description: descriptionController.text,
                            createdAt: DateTime.now(),
                          ),
                        );
                      },
                      text: "Create",
                      loadingState: (state is CreateNoteLoadingState),
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
