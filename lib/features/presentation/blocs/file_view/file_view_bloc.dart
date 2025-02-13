import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'file_view_event.dart';
part 'file_view_state.dart';

class FileViewBloc extends Bloc<FileViewEvent, FileViewState> {
  FileViewBloc() : super(FileViewInitial()) {
    on<FileViewEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
