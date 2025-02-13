import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/entity/file.dart';

part 'file_view_event.dart';
part 'file_view_state.dart';

class FileViewBloc extends Bloc<FileViewEvent, FileViewState> {
  FileViewBloc() : super(FileViewInitial()) {
    on<FileViewEvent>((event, emit) {});

    on<FileViewEventViewFile>(
      (event, emit) {
        emit(FileViewUpdate(appFile: event.appFile));
      },
    );
  }
}
