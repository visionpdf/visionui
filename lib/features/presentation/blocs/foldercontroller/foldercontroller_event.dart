part of 'foldercontroller_bloc.dart';

@immutable
sealed class FoldercontrollerEvent {}

class FoldercontrollerEventSearch extends FoldercontrollerEvent {
  final String? search;
  final int pageIndex;

  FoldercontrollerEventSearch({this.search, required this.pageIndex});
}

class FoldercontrollerEventUpdateTextSearchFolders extends FoldercontrollerEvent {
  final List<AppFile> appFiles;

  FoldercontrollerEventUpdateTextSearchFolders({required this.appFiles});
}
