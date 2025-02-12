part of 'file_bloc.dart';

@immutable
sealed class FileState {
  final AppFile file;

  const FileState({required this.file});
}

class FileStateStagnant extends FileState {
  const FileStateStagnant({required super.file});
}

class FileStateUploading extends FileState {
  const FileStateUploading({required super.file});
}

class FileStateDeleting extends FileState {
  const FileStateDeleting({required super.file});
}

class FileStateDeleted extends FileState {
  const FileStateDeleted({required super.file});
}

class FileStateFailed extends FileState {
  const FileStateFailed({required super.file});
}

class FileStateLoading extends FileState {
  const FileStateLoading({required super.file});
}
