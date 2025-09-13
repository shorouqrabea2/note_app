import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/data/note_model/note_model.dart';
import 'package:firebase_project/logic/get_notes/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetNotesCubit extends Cubit<GetNotesStates> {
  GetNotesCubit() : super(GetNotesInitialState());

  /// function to get notes from firebase firestore
  Future getNotes() async {
    emit(GetNotesLoadingState());
    try {
      final response = await FirebaseFirestore.instance
          .collection("Notes")
          .get(); // docs
      // save in model => convert ()iterable to list[obj,obj,..]
      final notesList = response.docs
          .map((doc) => NoteModel.fromJson(doc.data()))
          .toList();
      emit(GetNotesSuccessState(notes: notesList));
    } catch (e) {
      emit(GetNotesErrorState(errorMessage: e.toString()));
    }
  }
}
