import 'package:firebase_project/data/note_model/note_model.dart';

class GetNotesStates {}

class GetNotesInitialState extends GetNotesStates {}

class GetNotesLoadingState extends GetNotesStates {}

class GetNotesSuccessState extends GetNotesStates {
  List <CreateNoteModel> notes;
  GetNotesSuccessState({required this.notes});
}

class GetNotesErrorState extends GetNotesStates {
  final String errorMessage;
  GetNotesErrorState({required this.errorMessage});
}
