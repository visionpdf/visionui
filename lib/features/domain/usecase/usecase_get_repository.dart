import 'package:fpdart/fpdart.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/core/exception/failure.dart';
import 'package:visionui/core/usecase/usecase.dart';
import 'package:visionui/features/domain/repository/folder_repository.dart';

class UsecaseGetRepository implements Usecase<Folder, UsecaseGetRepositoryParams> {
  final FolderRepository _folderRepository;

  UsecaseGetRepository({required FolderRepository folderRepository}) : _folderRepository = folderRepository;
  @override
  Future<Either<Folder, Failure>> call(parameters) async {
    return await _folderRepository.getFolder(pageIndex: parameters.pageIndex, filter: parameters.filter);
  }
}

class UsecaseGetRepositoryParams {
  final int pageIndex;
  final String? filter;

  UsecaseGetRepositoryParams({required this.pageIndex, this.filter});
}
