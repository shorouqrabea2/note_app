import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/data/note_model/note_model.dart';
import 'package:firebase_project/logic/create_note/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateNoteCubit extends Cubit<CreateNoteStates> {
  CreateNoteCubit() : super(CreateNoteInitialState());

  /// create note in firebasefire store
  Future createNote(CreateNoteModel createNoteModel) async {
    emit(CreateNoteLoadingState());
    try {
      await FirebaseFirestore.instance
          .collection("Notes")
          .add(createNoteModel.toJson());
      emit(CreateNoteSuccessState());
    } catch (e) {
      emit(CreateNoteErrorState(errorMessage: e.toString()));
    }
  }
}
