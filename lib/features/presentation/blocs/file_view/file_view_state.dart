part of 'file_view_bloc.dart';

@immutable
sealed class FileViewState {}

final class FileViewInitial extends FileViewState {}

final class FileViewUpdate extends FileViewState {
  final AppFile? appFile;

  FileViewUpdate({this.appFile});
}
