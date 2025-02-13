part of 'file_search_bloc.dart';

@immutable
sealed class FileSearchState {}

final class FileSearchInitial extends FileSearchState {}

class FileSearchStateLoading extends FileSearchState {}

class FileSearchStateFailed extends FileSearchState {
  final String message;

  FileSearchStateFailed({required this.message});
}

class FileSearchStateLoaded extends FileSearchState {
  final int index;
  final List<AppFile> files;

  FileSearchStateLoaded({required this.index, required this.files});
}
