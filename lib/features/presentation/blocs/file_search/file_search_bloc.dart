import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'file_search_event.dart';
part 'file_search_state.dart';

class FileSearchBloc extends Bloc<FileSearchEvent, FileSearchState> {
  FileSearchBloc() : super(FileSearchInitial()) {
    on<FileSearchEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
