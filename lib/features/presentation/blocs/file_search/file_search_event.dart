part of 'file_search_bloc.dart';

@immutable
sealed class FileSearchEvent {}

class FileSearchEventSearchText extends FileSearchEvent {
  final String text;

  FileSearchEventSearchText({required this.text});
}
