import 'package:fpdart/fpdart.dart';
import 'package:visionui/core/entity/file.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/core/exception/failure.dart';
import 'package:visionui/features/domain/repository/folder_repository.dart';

class FolerRepositoryImpl implements FolderRepository {
  @override
  Future<Either<Folder, Failure>> getFolder({String? filter, required int pageIndex}) async {
    final Folder res = await Future.delayed(
      Duration(milliseconds: 200),
      () => home,
    );

    return left(res);
  }

  static Folder get home {
    AppFile file1 = AppFile(name: "file1.txt", format: "pdf", path: "home/folder1/file1.txt");
    AppFile file2 = AppFile(name: "file2.txt", format: "pdf", path: "home/folder1/file1.txt");
    Folder folder1 = Folder(name: "folder1", folders: [], files: [file1, file2], path: "home/folder1");

    AppFile file3 = AppFile(name: "file3.txt", format: "pdf", path: "home/folder3/file3.txt");
    AppFile file4 = AppFile(name: "file4.txt", format: "pdf", path: "home/folder3/file4.txt");
    Folder folder2 = Folder(name: "folder2", folders: [], files: [file3, file4], path: "home/folder2");

    AppFile file5 = AppFile(name: "file5.txt", format: "pdf", path: "home/file5.txt");
    AppFile file6 = AppFile(name: "file6.txt", format: "pdf", path: "home/file6.txt");

    Folder home = Folder(name: "home", folders: [folder1, folder2], files: [file5, file6], path: "home");

    return home;
  }
}
