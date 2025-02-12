import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/entity/folder.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  FolderBloc({required Folder folder}) : super(FolderInitial(folder: folder)) {
    on<FolderEvent>((event, emit) {
      emit(FolderStateLoading(folder: event.folder));
    });
    on<FolderEventOpen>(_onFolderEventOpen);
    on<FolderEventClose>(_onFolderEventClose);
    on<FolderEventDelete>(_onFolderEventDelete);
    on<FolderEventFailed>(_onFolderEventFailed);
    on<FolderEventUpdate>(_onFolderEventUpdate);
  }
  void _onFolderEventFailed(FolderEventFailed event, Emitter<FolderState> emit) {
    // Add your event handling logic here
  }
  void _onFolderEventDelete(FolderEventDelete event, Emitter<FolderState> emit) {
    // Add your event handling logic here
  }
  void _onFolderEventClose(FolderEventClose event, Emitter<FolderState> emit) {
    // Add your event handling logic here
  }

  void _onFolderEventOpen(FolderEventOpen event, Emitter<FolderState> emit) {
    // Add your event handling logic here
    emit(FolderStateOpen(folder: event.folder));
  }

  void _onFolderEventUpdate(FolderEventUpdate event, Emitter<FolderState> emit) {
    // Add your event handling logic here
  }
}
