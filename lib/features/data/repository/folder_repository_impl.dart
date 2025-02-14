import 'dart:async';
import 'dart:convert';
import 'dart:html' as html; // Import for Web (to handle Blob)
import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:visionui/core/entity/app_property.dart';
import 'package:visionui/core/entity/file.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/core/exception/failure.dart';
import 'package:visionui/features/domain/repository/folder_repository.dart';
import 'package:visionui/features/presentation/widgets/fileupload_widget.dart';
import 'package:http_parser/http_parser.dart';

class FolerRepositoryImpl implements FolderRepository {
  @override
  Future<Either<Folder, Failure>> getFolder({String? filter, required int pageIndex}) async {
    // await fetchData();
    try {
      final url = "${AppProperty.serverurl}/v1/api/folders/documents${filter != null ? "?filter=$filter" : ""}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Successful response

        // If the response is JSON, you can decode it like this:
        dynamic decodedJson = jsonDecode(response.body);

        if ((decodedJson as Map<String, dynamic>).isEmpty) return Left(Folder(name: "Home", folders: [], files: [], path: ""));

        return Left(Folder.fromJson(decodedJson["home"], ""));
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return Right(Failure(message: 'Failed to load data. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      return Right(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<List<AppFile>, Failure>> searchFile(String? search) async {
    try {
      final url = "${AppProperty.serverurl}/v1/api/search${search != null ? "?query=*$search*" : "?query=*"}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Successful response

        // If the response is JSON, you can decode it like this:
        var decoded = jsonDecode(response.body);

        List<AppFile> files = (decoded as List)
            .map(
              (e) => AppFile.fromJson(e),
            )
            .toList();
        return left(files);
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        return Right(Failure(message: 'Failed to load data. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      return Right(Failure(message: e.toString()));
    }
    // var decoded = jsonDecode(data);

    // List<AppFile> files = (decoded as List)
    //     .map(
    //       (e) => AppFile.fromJson(e),
    //     )
    //     .toList();

    // return left(files);
  }

  // Future<void> uploadFile() {}
//   @override
//   Future<void> uploadFile(SelectedFile selectedFile) async {
//     // The URL of the API endpoint
//     final String url = '${AppProperty.serverurl}/v1/api/upload';

//     // Log the selected file details
//     print("${selectedFile.name} -> ${selectedFile.basePath}");

//     // // Convert the Blob URL to a File if running on the web
//     // File file;
//     // if (selectedFile.file.path.startsWith('blob:')) {
//     //   // Handling Blob URL
//     //   try {
//     //     file = await _getFileFromBlobUrl(selectedFile.basePath);
//     //   } catch (e) {
//     //     print("Error converting blob to file: $e");
//     //     return;
//     //   }
//     // } else {
//     //   // Fallback: Use the file directly if it's a normal file path
//     //   file = selectedFile.file;
//     // }

//     // Prepare the multipart request
//     var request = http.MultipartRequest('POST', Uri.parse(url));

//     print("resquest formed");

//     // // Convert file to bytes
//     // try {
//     //   var fileBytes = await selectedFile.file.readAsBytes();
//     //   print(fileBytes);
//     // } catch (e) {
//     //   print(e);
//     // }
//     try {
//       var multipartFile = http.MultipartFile.fromBytes(
//         'file', // The name of the form field (must match what the server expects)
//         await selectedFile.file.readAsBytes(),
//         filename: selectedFile.name,
//         contentType: MediaType('application', "pdf"), // Set the content type
//       );
//     } catch (e) {
//       print("e");
//     }

//     print("resquest sent");

//     // var multipartFile = http.MultipartFile.fromBytes(
//     //   'file', // The name of the form field (must match what the server expects)
//     //   fileBytes,
//     //   filename: selectedFile.name,
//     //   contentType: MediaType('application', "pdf"), // Set the content type
//     // );

//     // // Attach other form fields (optional)
//     // request.fields['uploaded_by'] = '1'; // Replace with actual value
//     // request.fields['basepath'] = selectedFile.basePath; // Replace with actual value

//     // // Add the file to the request
//     // request.files.add(multipartFile);

//     // // Send the request and get the response
//     // try {
//     //   var response = await request.send();

//     //   // Check the response status code
//     //   if (response.statusCode == 200) {
//     //     print('File uploaded successfully');
//     //     // Optionally read the response body
//     //     var responseBody = await response.stream.bytesToString();
//     //     print(responseBody);
//     //   } else {
//     //     print('Failed to upload file. Status code: ${response.statusCode}');
//     //   }
//     // } catch (e) {
//     //   print('Error: $e');
//     //   rethrow;
//     // }
//   }

// // Helper function to convert a Blob URL to a File (for web)
//   Future<File> _getFileFromBlobUrl(String blobUrl) async {
//     final html.Blob blob = html.Blob([await html.window.fetch(blobUrl).then((res) => res.blob())]);
//     final reader = html.FileReader();
//     reader.readAsArrayBuffer(blob);
//     await reader.onLoadEnd.first;
//     final List<int> fileBytes = reader.result as List<int>;
//     return File.fromRawPath(Uint8List.fromList(fileBytes));
//   }

  Future<void> uploadFile(SelectedFile selectedFile) async {
    // The URL of the API endpoint
    final String url = '${AppProperty.serverurl}/v1/api/upload';

    // Log the selected file details
    print("${selectedFile.name} -> ${selectedFile.basePath}");

    // Prepare the multipart request
    var request = http.MultipartRequest('POST', Uri.parse(url));

    try {
      // Convert the html.File to bytes using FileReader (browser-specific)
      final fileBytes = await _readFileAsBytes(selectedFile.file);
      var multipartFile = http.MultipartFile.fromBytes(
        'file', // The name of the form field (must match what the server expects)
        fileBytes,
        filename: selectedFile.name,
        contentType: MediaType('application', selectedFile.name.split(".")[1]), // Set the content type
      );

      // Attach other form fields (optional)
      request.fields['uploaded_by'] = '1'; // Replace with actual value
      request.fields['basepath'] = selectedFile.basePath; // Replace with actual value

      // Add the file to the request
      request.files.add(multipartFile);

      // Send the request and get the response
      var response = await request.send();

      // Check the response status code
      if (response.statusCode == 200) {
        print('File uploaded successfully');
        // Optionally read the response body
        var responseBody = await response.stream.bytesToString();
        print(responseBody);
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

// Helper function to read html.File as bytes
  Future<List<int>> _readFileAsBytes(html.File file) async {
    final completer = Completer<List<int>>();
    final reader = html.FileReader();

    reader.readAsArrayBuffer(file);

    reader.onLoadEnd.listen((event) {
      completer.complete(reader.result as List<int>);
    });

    reader.onError.listen((event) {
      completer.completeError(Exception("Error reading file"));
    });

    return completer.future;
  }
}
