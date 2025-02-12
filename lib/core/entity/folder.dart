import 'package:visionui/core/entity/file.dart';

class Folder {
  final String name;
  final List<Folder> folders;
  final List<AppFile> files;

  Folder({required this.name, required this.folders, required this.files});
}
