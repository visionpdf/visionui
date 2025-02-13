import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/entity/folder.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  final FolderBloc? parentBloc;
  FolderBloc({this.parentBloc, required Folder folder, String? search})
      : super(
          search == null
              ? (parentBloc == null ? FolderStateOpen(folder: folder) : FolderStateStable(folder: folder))
              : FolderStateOpen(folder: folder),
        ) {
    on<FolderEvent>((event, emit) {});
    on<FolderEventOpen>(_onFolderEventOpen);
    on<FolderEventClose>(_onFolderEventClose);
    on<FolderEventDelete>(_onFolderEventDelete);
    on<FolderEventFailed>(_onFolderEventFailed);
    on<FolderEventUpdate>(_onFolderEventUpdate);
    on<FolderEventLoading>(_onFolderEventLoading);
    on<FolderEventUpdateParent>(_onFolderEventUpdateParent);
  }

  void _onFolderEventLoading(FolderEventLoading event, Emitter<FolderState> emit) {
    // Add your event handling logic here
    emit(FolderStateLoading(folder: event.folder));
  }

  void _onFolderEventFailed(FolderEventFailed event, Emitter<FolderState> emit) {
    // Add your event handling logic here
  }
  void _onFolderEventDelete(FolderEventDelete event, Emitter<FolderState> emit) async {
    emit(FolderStateDeleting(folder: event.folder));
    // Add your event handling logic here
    await Future.delayed(Duration(seconds: 4));

    // give a update notification to parent
    emit(FolderStateDeleted(folder: event.folder));
  }

  void _onFolderEventClose(FolderEventClose event, Emitter<FolderState> emit) {
    // Add your event handling logic here
    emit(FolderStateStable(folder: event.folder));
  }

  void _onFolderEventOpen(FolderEventOpen event, Emitter<FolderState> emit) {
    // Add your event handling logic here
    emit(FolderStateOpen(folder: event.folder));
  }

  void _onFolderEventUpdate(FolderEventUpdate event, Emitter<FolderState> emit) async {
    // Add your event handling logic here
    emit(FolderStateOpen(folder: event.folder));
    // transfer the call to the parent
    add(FolderEventUpdateParent(folder: event.folder));
    // notifybth eparent to update itself
  }

  void _onFolderEventUpdateParent(FolderEventUpdateParent event, Emitter<FolderState> emit) {
    if (parentBloc == null) return;
    // Add your event handling logic here
    Folder folderParent = parentBloc!.state.folder;

    folderParent.folders.removeWhere(
      (element) => element.name == event.folder.name,
    );

    folderParent.folders.add(event.folder);

    parentBloc!.add(FolderEventUpdateParent(folder: folderParent));
  }
}
