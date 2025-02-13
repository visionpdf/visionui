import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/entity/file.dart';
import 'package:visionui/features/domain/usecase/usecase_get_files.dart';

part 'file_search_event.dart';
part 'file_search_state.dart';

class FileSearchBloc extends Bloc<FileSearchEvent, FileSearchState> {
  final UsecaseGetFiles usecaseGetFiles;
  FileSearchBloc({required this.usecaseGetFiles}) : super(FileSearchInitial()) {
    on<FileSearchEvent>((event, emit) {
      emit(FileSearchStateLoading());
    });
    on<FileSearchEventSearchText>(_onFileSearchEventSearchText);
  }

  void _onFileSearchEventSearchText(FileSearchEventSearchText event, Emitter<FileSearchState> emit) async {
    // Add your implementation here
    await Future.delayed(Duration(seconds: 1));

    final res = await usecaseGetFiles(UsecaseGetFilesParams(search: event.text));
    res.fold(
      (l) => emit(FileSearchStateLoaded(index: 0, files: l)),
      (r) => emit(FileSearchStateFailed(message: 'Failed to load files')),
    );
  }
}
