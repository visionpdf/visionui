part of 'file_bloc.dart';

@immutable
sealed class FileEvent {
  final File file;

  const FileEvent({required this.file});
}

class FileEventDelete extends FileEvent {
  const FileEventDelete({required super.file});
}

class FileEventDownload extends FileEvent {
  const FileEventDownload({required super.file});
}

class FileEventOpen extends FileEvent {
  const FileEventOpen({required super.file});
}

class FileEventFailed extends FileEvent {
  const FileEventFailed({required super.file});
}
