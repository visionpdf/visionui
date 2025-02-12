part of 'folder_bloc.dart';

@immutable
sealed class FolderEvent {
  final Folder folder;

  const FolderEvent({required this.folder});
}

class FolderEventOpen extends FolderEvent {
  const FolderEventOpen({required super.folder});
}

class FolderEventClose extends FolderEvent {
  const FolderEventClose({required super.folder});
}

class FolderEventDelete extends FolderEvent {
  const FolderEventDelete({required super.folder});
}

class FolderEventFailed extends FolderEvent {
  const FolderEventFailed({required super.folder});
}

class FolderEventUpdate extends FolderEvent {
  const FolderEventUpdate({required super.folder});
}
