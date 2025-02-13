import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/theme/color_palete.dart';
import 'package:visionui/features/presentation/blocs/file_view/file_view_bloc.dart';
import 'package:visionui/features/presentation/pages/document_viewer.dart';
import 'package:visionui/features/presentation/pages/pdf_viewer.dart';

class FileViewWidget extends StatelessWidget {
  const FileViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FileViewBloc, FileViewState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(state);
        if (state is FileViewUpdate) {
          if (state.appFile != null) {
            print("appfile");
            return Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                border: Border.all(color: ColorPalete.fileBolder),
                borderRadius: BorderRadius.circular(10),
                // color: ColorPalete.greyColor,
              ),
              child: DocumentViewer(fileUrl: "http://10.10.25.215:3000/view/rest.txt"),
            );
          }
        }
        return SizedBox.shrink();
      },
    );
  }
}
