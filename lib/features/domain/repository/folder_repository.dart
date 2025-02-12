import 'package:fpdart/fpdart.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/core/exception/failure.dart';

abstract interface class FolderRepository {
  Future<Either<Folder, Failure>> getFolder({String? filter, required int pageIndex});
}
