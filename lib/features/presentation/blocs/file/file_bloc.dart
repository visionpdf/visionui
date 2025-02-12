import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/entity/file.dart';

part 'file_event.dart';
part 'file_state.dart';

class FileBloc extends Bloc<FileEvent, FileState> {
  FileBloc({required File file}) : super(FileStateStagnant(file: file)) {
    on<FileEvent>((event, emit) {});
    on<FileEventDelete>(_onFileEventDelete);
    on<FileEventDownload>(_onFileEventDownload);
    on<FileEventOpen>(_onFileEventOpen);
    on<FileEventFailed>(_onFileEventFailed);
  }

  void _onFileEventFailed(FileEventFailed event, Emitter<FileState> emit) {
    // Add your event handling logic here
  }

  void _onFileEventOpen(FileEventOpen event, Emitter<FileState> emit) {
    // Add your event handling logic here
  }

  void _onFileEventDownload(FileEventDownload event, Emitter<FileState> emit) {
    // Add your event handling logic here
  }

  void _onFileEventDelete(FileEventDelete event, Emitter<FileState> emit) {
    // Add your event handling logic here
  }
}
