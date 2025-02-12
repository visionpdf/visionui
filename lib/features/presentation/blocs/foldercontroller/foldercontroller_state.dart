part of 'foldercontroller_bloc.dart';

@immutable
sealed class FoldercontrollerState {}

class FoldercontrollerStateLoading extends FoldercontrollerState {}

final class FoldercontrollerInitial extends FoldercontrollerState {}

final class FoldercontrollerStateLoaded extends FoldercontrollerState {
  final int pageIndex;
  final String? search;
  final Folder folder;

  FoldercontrollerStateLoaded({required this.pageIndex, required this.search, required this.folder});
}

final class FoldercontrollerStateFailed extends FoldercontrollerState {
  final String message;

  FoldercontrollerStateFailed({required this.message});
}
