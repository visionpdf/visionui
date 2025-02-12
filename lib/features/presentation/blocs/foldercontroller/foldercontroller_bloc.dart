import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  }

  void _onFoldercontrollerEventSearch(FoldercontrollerEventSearch event, Emitter<FoldercontrollerState> emit) async {
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
}
