import 'package:fpdart/fpdart.dart';
import 'package:visionui/core/entity/file.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/core/exception/failure.dart';
import 'package:visionui/features/presentation/widgets/fileupload_widget.dart';

abstract interface class FolderRepository {
  Future<Either<Folder, Failure>> getFolder({String? filter, required int pageIndex});

  Future<Either<List<AppFile>, Failure>> searchFile(String? search);

  Future<void> uploadFile(SelectedFile selectedFile);
}
