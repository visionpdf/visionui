import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/entity/file.dart';

part 'file_search_event.dart';
part 'file_search_state.dart';

class FileSearchBloc extends Bloc<FileSearchEvent, FileSearchState> {
  FileSearchBloc() : super(FileSearchInitial()) {
    on<FileSearchEvent>((event, emit) {
      emit(FileSearchStateLoading());
    });
    on<FileSearchEventSearchText>(_onFileSearchEventSearchText);
  }

  void _onFileSearchEventSearchText(FileSearchEventSearchText event, Emitter<FileSearchState> emit) async {
    // Add your implementation here
    await Future.delayed(Duration(seconds: 1));

    AppFile appFile1 = AppFile(name: "file1.pdf", format: "pdf", path: "home/folder1/file1.pdf");
    AppFile appFile2 = AppFile(name: "file2.pdf", format: "pdf", path: "home/folder2/file2.pdf");

    AppFile appFile3 = AppFile(name: "file3.pdf", format: "pdf", path: "home/folder1/folder2/file3.pdf");
    AppFile appFile4 = AppFile(name: "file4.pdf", format: "pdf", path: "home/folder3/file4.pdf");

    AppFile appFile5 = AppFile(name: "file5.pdf", format: "pdf", path: "home/folder1/file5.pdf");
    AppFile appFile6 = AppFile(name: "file6.pdf", format: "pdf", path: "home/folder2/file6.pdf");

    AppFile appFile7 = AppFile(name: "file7.pdf", format: "pdf", path: "home/folder1/file7.pdf");
    AppFile appFile8 = AppFile(name: "file8.pdf", format: "pdf", path: "home/folder2/file8.pdf");

    emit(FileSearchStateLoaded(index: 0, files: [
      appFile1,
      appFile2,
      appFile3,
      appFile4,
      appFile5,
      appFile6,
      appFile7,
      appFile8,
    ]));
  }
}
