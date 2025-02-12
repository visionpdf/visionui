part of 'folder_bloc.dart';

@immutable
sealed class FolderState {
  final Folder folder;

  const FolderState({required this.folder});
}

final class FolderStateLoading extends FolderState {
  const FolderStateLoading({required super.folder});
}

final class FolderInitial extends FolderState {
  const FolderInitial({required super.folder});
}

class FolderStateDeleting extends FolderState {
  const FolderStateDeleting({required super.folder});
}

class FolderStateDeleted extends FolderState {
  const FolderStateDeleted({required super.folder});
}

class FolderStateOpen extends FolderState {
  const FolderStateOpen({required super.folder});
}

class FolderStateFailed extends FolderState {
  const FolderStateFailed({required super.folder});
}

class FolderStateStable extends FolderState {
  const FolderStateStable({required super.folder});
}
