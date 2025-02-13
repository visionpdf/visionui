import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/theme/color_palete.dart';
import 'package:visionui/features/presentation/blocs/file_search/file_search_bloc.dart';

class SearchFileWidget extends StatelessWidget {
  const SearchFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FileSearchBloc, FileSearchState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            border: Border.all(color: ColorPalete.fileBolder),
            borderRadius: BorderRadius.circular(10),
            color: ColorPalete.fileBolder,
          ),
          // height: double.maxFinite,
          // width: double.maxFinite,
        );
      },
    );
  }
}
