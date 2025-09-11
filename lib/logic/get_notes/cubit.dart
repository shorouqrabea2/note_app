import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/data/note_model/note_model.dart';
import 'package:firebase_project/logic/get_notes/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetNotesCubit extends Cubit<GetNotesStates> {
  GetNotesCubit() : super(GetNotesInitialState());

  /// get notes from firebasefire store
  Future getNotes() async {
    emit(GetNotesLoadingState());
    try {
      final response = await FirebaseFirestore.instance
          .collection("Notes")
          .get();
          final notes=response.docs.map((doc)=> CreateNoteModel.fromJson(doc.data())).toList();
          emit(GetNotesSuccessState(notes: notes));
    } catch (e) {
      emit(GetNotesErrorState(errorMessage: e.toString()));
    }
  }
}

// list=[ob1,ob2,...]