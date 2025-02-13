import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/theme/color_palete.dart';
import 'package:visionui/features/presentation/blocs/file_view/file_view_bloc.dart';

class FileViewWidget extends StatelessWidget {
  const FileViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FileViewBloc, FileViewState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Container(
          margin: EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
            border: Border.all(color: ColorPalete.fileBolder),
            borderRadius: BorderRadius.circular(10),
            // color: ColorPalete.greyColor,
          ),
          // height: double.infinity,
          // width: double.infinity,
        );
      },
    );
  }
}
