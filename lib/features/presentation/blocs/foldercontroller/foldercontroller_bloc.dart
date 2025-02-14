import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/entity/file.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/features/domain/usecase/usecase_get_repository.dart';

part 'foldercontroller_event.dart';
part 'foldercontroller_state.dart';

class FoldercontrollerBloc extends Bloc<FoldercontrollerEvent, FoldercontrollerState> {
  final UsecaseGetRepository _usecaseGetRepository;
  FoldercontrollerBloc({required UsecaseGetRepository usecaseGetRepository})
      : _usecaseGetRepository = usecaseGetRepository,
        super(FoldercontrollerInitial()) {
    on<FoldercontrollerEvent>((event, emit) {
      emit(FoldercontrollerStateLoading());
    });
    on<FoldercontrollerEventSearch>(_onFoldercontrollerEventSearch);
    on<FoldercontrollerEventUpdateTextSearchFolders>(_onFoldercontrollerEventUpdateTextSearchFolders);
  }

  void _onFoldercontrollerEventSearch(FoldercontrollerEventSearch event, Emitter<FoldercontrollerState> emit) async {
    await Future.delayed(Duration(milliseconds: 200));
    final res = await _usecaseGetRepository(UsecaseGetRepositoryParams(pageIndex: event.pageIndex, filter: event.search));

    res.fold(
      (l) {
        // got new folder details
        emit(FoldercontrollerStateLoaded(pageIndex: event.pageIndex, search: event.search, folder: l));
      },
      (r) {
        // got an error while getting new folder
        emit(FoldercontrollerStateFailed(message: r.message));
      },
    );
  }

  void _onFoldercontrollerEventUpdateTextSearchFolders(FoldercontrollerEventUpdateTextSearchFolders event, Emitter<FoldercontrollerState> emit) async {
    if (event.appFiles.isEmpty) {
      add(FoldercontrollerEventSearch(pageIndex: 0, search: "junksearch"));
    } else {
      await Future.delayed(Duration(milliseconds: 400));
      Folder updated = buildFolderStructure(event.appFiles);
      emit(FoldercontrollerStateLoaded(pageIndex: 0, search: "*", folder: updated));
    }
  }

  Folder buildFolderStructure(List<AppFile> files) {
    Folder root = Folder(name: "home", path: "home", folders: [], files: []);

    for (var file in files) {
      List<String> parts = file.path.split("/");
      Folder current = root;

      for (int i = 1; i < parts.length - 1; i++) {
        String folderName = parts[i];
        String folderPath = parts.sublist(0, i + 1).join("/");

        // Check if folder already exists
        Folder? existingFolder = current.folders.firstWhere(
          (f) => f.name == folderName,
          orElse: () {
            Folder newFolder = Folder(name: folderName, path: folderPath, folders: [], files: []);
            current.folders.add(newFolder);
            return newFolder;
          },
        );

        current = existingFolder;
      }

      // Add file to the correct folder
      current.files.add(file);
    }

    return root;
  }
}
