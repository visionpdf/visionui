part of 'foldercontroller_bloc.dart';

@immutable
sealed class FoldercontrollerEvent {}

class FoldercontrollerEventSearch extends FoldercontrollerEvent {
  final String? search;
  final int pageIndex;

  FoldercontrollerEventSearch({this.search, required this.pageIndex});
}
