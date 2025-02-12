import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/entity/file.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/core/theme/color_palete.dart';
import 'package:visionui/core/utils/widgets/delete_loading.dart';
import 'package:visionui/features/presentation/blocs/file/file_bloc.dart';
import 'package:visionui/features/presentation/blocs/folder/folder_bloc.dart';

class FileWidget extends StatelessWidget {
  final FolderBloc? parentFolder;
  final AppFile file;
  const FileWidget({
    super.key,
    required this.file,
    required this.parentFolder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FileBloc(file: file),
      child: BlocConsumer<FileBloc, FileState>(
        listener: (context, state) {
          if (state is FileStateDeleting) {
            // show a onscreen page uploading
            showLoadingDialog(context);
          } else if (state is FileStateDeleted) {
            // notify the parent folder structure to update
            if (parentFolder != null) {
              final folder = parentFolder!.state.folder;

              final updatedFolder = Folder(
                  name: folder.name,
                  folders: folder.folders,
                  files: folder.files
                    ..removeWhere(
                      (element) => element.name == state.file.name,
                    ));
              parentFolder!.add(FolderEventUpdateParent(folder: updatedFolder));
            }
          }
        },
        builder: (context, state) {
          if (state is FileStateDeleted) {
            return Center();
          }
          return getBorder(Container(
            // height: 50,
            alignment: Alignment.centerLeft,
            constraints: BoxConstraints(maxWidth: 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(state.file.name, overflow: TextOverflow.ellipsis),
                ),
                state is! FileStateDeleting
                    ? IconButton(
                        icon: Icon(
                          Icons.delete_outlined,
                          size: 15,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          context.read<FileBloc>().add(FileEventDelete(file: state.file));
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          height: 15,
                          width: 15,
                          child: DeleteLoading(),
                        ),
                      ),
                IconButton(
                  icon: Icon(
                    Icons.cloud_download_outlined,
                    size: 15,
                  ),
                  color: Colors.white,
                  onPressed: () {},
                ),
              ],
            ),
          ));
        },
      ),
    );
  }

  Widget getBorder(Widget child) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: ColorPalete.fileBolder),
          borderRadius: BorderRadius.circular(10),
        ),
        child: child);
  }

  Future<void> showLoadingDialog(BuildContext context) async {
    final fileBloc = context.read<FileBloc>(); // Get the existing FolderBloc

    await showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing while loading
      builder: (_) => BlocProvider.value(
        value: fileBloc, // Provide the existing bloc
        child: BlocListener<FileBloc, FileState>(
          listener: (context, state) {
            if (state is! FolderStateDeleting) {
              if (context.mounted) Navigator.of(context).pop();
            }
          },
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
