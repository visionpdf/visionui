import 'package:fpdart/fpdart.dart';
import 'package:visionui/core/entity/file.dart';
import 'package:visionui/core/exception/failure.dart';
import 'package:visionui/core/usecase/usecase.dart';
import 'package:visionui/features/domain/repository/folder_repository.dart';

class UsecaseGetFiles implements Usecase<List<AppFile>, UsecaseGetFilesParams> {
  final FolderRepository _folderRepository;

  UsecaseGetFiles({required FolderRepository folderRepository}) : _folderRepository = folderRepository;
  @override
  Future<Either<List<AppFile>, Failure>> call(UsecaseGetFilesParams parameters) async {
    return await _folderRepository.searchFile(parameters.search);
  }
}

class UsecaseGetFilesParams {
  final String? search;

  UsecaseGetFilesParams({this.search});
}
