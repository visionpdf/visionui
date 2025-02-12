import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/core/theme/color_palete.dart';
import 'package:visionui/core/utils/widgets/delete_loading.dart';
import 'package:visionui/features/presentation/blocs/folder/folder_bloc.dart';
import 'package:visionui/features/presentation/widgets/file_widget.dart';
import 'package:visionui/features/presentation/widgets/fileupload_widget.dart';

class FolderWidget extends StatelessWidget {
  final Folder folder; // Receive folder as parameter
  final FolderBloc? parentFolder;

  const FolderWidget({
    super.key,
    required this.folder,
    required this.parentFolder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FolderBloc(folder: folder),
      child: BlocConsumer<FolderBloc, FolderState>(
        listener: (context, state) {
          if (state is FolderStateDeleting) {
            showLoadingDialog(context);
          } else if (state is FolderStateDeleted) {
            // folder is deleted updated the parent folder bloc
            if (parentFolder != null) {
              // update the parent folder
              Folder parent = parentFolder!.state.folder;

              Folder newFolder = Folder(
                  name: parent.name,
                  folders: parent.folders
                    ..removeWhere(
                      (element) => element.name == state.folder.name,
                    ),
                  files: parent.files);

              parentFolder!.add(FolderEventUpdateParent(folder: newFolder));
            }
          }
        },
        builder: (context, state) {
          if (state is FolderStateDeleted) {
            return Center();
          }

          Folder folder = state.folder;

          List<Widget> subWidgets = [
            ...folder.folders.map(
              (f) => FolderWidget(
                folder: f,
                parentFolder: context.read<FolderBloc>(),
              ), // ✅ Pass folder directly
            ),
            ...folder.files.map(
              (f) => FileWidget(
                file: f,
                parentFolder: context.read<FolderBloc>(),
              ),
            ),
          ];

          if (state is FolderStateDeleting || state is FolderStateLoading) {
            return getBorder(getDeletingView(state));
          }

          return getBorder(Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        folder.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    if (parentFolder != null)
                      IconButton(
                        icon: Icon(
                          Icons.delete_outlined,
                          size: 15,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          context.read<FolderBloc>().add(FolderEventDelete(folder: state.folder));
                        },
                      ),
                    IconButton(
                      icon: Icon(
                        Icons.cloud_upload_outlined,
                        size: 15,
                      ),
                      color: Colors.white,
                      onPressed: () async {
                        await showUploadDialog(context, BlocProvider.of<FolderBloc>(context));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        state is FolderStateOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        size: 15,
                      ),
                      color: Colors.white,
                      onPressed: () {
                        if (state is FolderStateOpen) {
                          context.read<FolderBloc>().add(FolderEventClose(folder: state.folder));
                        } else {
                          context.read<FolderBloc>().add(FolderEventOpen(folder: state.folder));
                        }
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: state is FolderStateOpen,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: subWidgets.length,
                  itemBuilder: (context, index) => subWidgets[index],
                ),
              ),
            ],
          ));
        },
      ),
    );
  }

  Widget getDeletingView(FolderState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  folder.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SizedBox(
                  height: 15,
                  width: 15,
                  child: DeleteLoading(),
                ),
              )
            ],
          ),
        ),
      ],
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
    final folderBloc = context.read<FolderBloc>(); // Get the existing FolderBloc

    await showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing while loading
      builder: (_) => BlocProvider.value(
        value: folderBloc, // Provide the existing bloc
        child: BlocListener<FolderBloc, FolderState>(
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
