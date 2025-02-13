import 'package:visionui/core/entity/file.dart';

class Folder {
  final String name;
  final String path;
  final List<Folder> folders;
  final List<AppFile> files;

  Folder({required this.name, required this.folders, required this.files, required this.path});

  // Factory constructor to create Folder from JSON
  factory Folder.fromJson(Map<String, dynamic> data, String path) {
    // Parse subfolders into Folder objects
    List<Folder> subfolders = [];
    if (data['subfolders'] != null) {
      Map<String, dynamic> folders = data["subfolders"];

      folders.forEach(
        (key, value) {
          subfolders.add(Folder.fromJson(value, data["name"] + "/"));
        },
      );
    }

    // Parse contents into AppFile objects
    List<AppFile> contents = [];
    if (data['contents'] != null) {
      contents = (data['contents'] as List).map((file) {
        return AppFile.fromJson(file);
      }).toList();
    }

    // Return Folder object
    return Folder(
      name: data['name'],
      path: path + data['name'],
      folders: subfolders,
      files: contents,
    );
  }

  @override
  String toString() {
    return " \n name: $name Path: $path ,folders : $folders, Files : ${files.toString()} \n";
  }
}
