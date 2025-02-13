import 'package:get_it/get_it.dart';
import 'package:visionui/features/data/repository/folder_repository_impl.dart';
import 'package:visionui/features/domain/usecase/usecase_get_files.dart';
import 'package:visionui/features/domain/usecase/usecase_get_repository.dart';
import 'package:visionui/features/presentation/blocs/file_search/file_search_bloc.dart';
import 'package:visionui/features/presentation/blocs/file_view/file_view_bloc.dart';
import 'package:visionui/features/presentation/blocs/foldercontroller/foldercontroller_bloc.dart';

final getIt = GetIt.instance;

Future<void> initServices() async {
  getIt.registerSingleton<FolerRepositoryImpl>(FolerRepositoryImpl());

  getIt.registerSingleton<UsecaseGetRepository>(UsecaseGetRepository(folderRepository: getIt<FolerRepositoryImpl>()));

  getIt.registerSingleton<UsecaseGetFiles>(UsecaseGetFiles(folderRepository: getIt<FolerRepositoryImpl>()));

  getIt.registerFactory<FoldercontrollerBloc>(
    () => FoldercontrollerBloc(usecaseGetRepository: getIt<UsecaseGetRepository>()),
  );

  getIt.registerFactory<FileSearchBloc>(
    () => FileSearchBloc(usecaseGetFiles: getIt<UsecaseGetFiles>()),
  );

  getIt.registerFactory<FileViewBloc>(
    () => FileViewBloc(),
  );
}
