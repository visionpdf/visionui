// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:visionui/core/entity/folder.dart';

void main() {
  print("Started");
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

  // Now you can use the decodedJson object as needed

  Folder folder = Folder.fromJson(decodedJson["home"], "");

  print(folder);
}
