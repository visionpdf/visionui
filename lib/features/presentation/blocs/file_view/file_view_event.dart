part of 'file_view_bloc.dart';

@immutable
sealed class FileViewEvent {}

class FileViewEventViewFile extends FileViewEvent {
  final AppFile? appFile;

  FileViewEventViewFile({this.appFile});
}
