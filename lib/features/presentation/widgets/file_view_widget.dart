import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/theme/color_palete.dart';
import 'package:visionui/features/presentation/blocs/file_view/file_view_bloc.dart';
import 'package:visionui/features/presentation/pages/document_viewer.dart';

class FileViewWidget extends StatelessWidget {
  const FileViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FileViewBloc, FileViewState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is FileViewUpdate) {
          if (state.appFile != null) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                border: Border.all(color: ColorPalete.fileBolder),
                borderRadius: BorderRadius.circular(10),
                // color: ColorPalete.greyColor, https://docs.google.com/gview?url=http://192.168.0.100:3000/view/vision.docx&embedded=true
              ),
              child: DocumentViewer(fileUrl: "http://192.168.0.100:3000/view/vision.docx"),
            );
          }
        }
        return SizedBox.shrink();
      },
    );
  }
}
