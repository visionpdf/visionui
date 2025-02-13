import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:visionui/core/entity/file.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/core/exception/failure.dart';
import 'package:visionui/features/domain/repository/folder_repository.dart';

class FolerRepositoryImpl implements FolderRepository {
  @override
  Future<Either<Folder, Failure>> getFolder({String? filter, required int pageIndex}) async {
    final Folder res = await home();

    return left(res);
  }

  static Future<Folder> home() async {
    // Read the file as a string
    String jsonString = """{
  "home": {
    "name": "home",
    "subfolders": {
      "Pictures": {
        "name": "Pictures",
        "subfolders": {},
        "contents": [
          {
            "title": "Test8.pdf",
            "filePath": "home/Pictures/Test8.pdf",
            "fileType": "PDF",
            "fileSize": 26237
          },
          {
            "title": "Test9.pdf",
            "filePath": "home/Pictures/Test9.pdf",
            "fileType": "PDF",
            "fileSize": 26237
          },
          {
            "title": "Test10.pdf",
            "filePath": "home/Pictures/Test10.pdf",
            "fileType": "PDF",
            "fileSize": 26237
          }
        ]
      },
      "Documents": {
        "name": "Documents",
        "subfolders": {
          "Work": {
            "name": "Work",
            "subfolders": {},
            "contents": [
              {
                "title": "Test5.pdf",
                "filePath": "home/Documents/Work/Test5.pdf",
                "fileType": "PDF",
                "fileSize": 26237
              },
              {
                "title": "Test6.pdf",
                "filePath": "home/Documents/Work/Test6.pdf",
                "fileType": "PDF",
                "fileSize": 26237
              },
              {
                "title": "Test7.pdf",
                "filePath": "home/Documents/Work/Test7.pdf",
                "fileType": "PDF",
                "fileSize": 26237
              }
            ]
          }
        },
        "contents": [
          {
            "title": "Test2.pdf",
            "filePath": "home/Documents/Test2.pdf",
            "fileType": "PDF",
            "fileSize": 26237
          },
          {
            "title": "Test3.pdf",
            "filePath": "home/Documents/Test3.pdf",
            "fileType": "PDF",
            "fileSize": 26237
          }
        ]
      }
    },
    "contents": []
  }
}
""";

    // Decode the JSON string to a Dart object (Map or List depending on the structure of your JSON)
    var decodedJson = jsonDecode(jsonString);

    return Folder.fromJson(decodedJson["home"], "");
  }

  @override
  Future<Either<List<AppFile>, Failure>> searchFile(String? search) async {
    String data = """
  [
    {
        "title": "Test21.pdf",
        "filePath": "home/Pictures/Test21.pdf",
        "fileType": "PDF",
        "fileSize": 26237,
        "uploadedAt": "2025-02-14T01:25:56.02062",
        "uploadedBy": "root",
        "tags": []
    }
]
  """;
    var decoded = jsonDecode(data);

    List<AppFile> files = (decoded as List)
        .map(
          (e) => AppFile.fromJson(e),
        )
        .toList();

    return left(files);
  }
}
