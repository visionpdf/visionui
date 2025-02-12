import 'package:fpdart/fpdart.dart';
import 'package:visionui/core/entity/file.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/core/exception/failure.dart';
import 'package:visionui/features/domain/repository/folder_repository.dart';

class FolerRepositoryImpl implements FolderRepository {
  @override
  Future<Either<Folder, Failure>> getFolder({String? filter, required int pageIndex}) async {
    File file1 = File(name: "file1.pdf", format: "pdf");
    File file2 = File(name: "file2.pdf", format: "pdf");

    Folder folder1 = Folder(name: "folder1", folders: [], files: [file2]);
    Folder folder2 = Folder(name: "folder2", folders: [folder1], files: [file1]);
    Folder folder3 = Folder(name: "folder3", folders: [], files: [file2]);

    Folder home = Folder(name: "home", folders: [folder2, folder3], files: [file1, file2]);

    final Folder res = await Future.delayed(
      Duration(seconds: 1),
      () => home,
    );

    return left(res);
  }
}
