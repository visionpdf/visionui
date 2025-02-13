class AppFile {
  final String name;
  final String format;
  final String path;

  AppFile({required this.name, required this.format, required this.path});

  // Factory constructor to create AppFile from JSON
  factory AppFile.fromJson(Map<String, dynamic> data) {
    return AppFile(
      name: data['title'],
      format: data['fileType'],
      path: data['filePath'],
    );
  }

  @override
  String toString() {
    return "name: $name, format: $format, path :$path";
  }
}
