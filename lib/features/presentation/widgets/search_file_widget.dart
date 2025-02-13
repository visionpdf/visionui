import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/entity/file.dart';
import 'package:visionui/core/theme/color_palete.dart';
import 'package:visionui/features/presentation/blocs/file_search/file_search_bloc.dart';
import 'package:visionui/features/presentation/blocs/file_view/file_view_bloc.dart';
import 'package:visionui/features/presentation/blocs/foldercontroller/foldercontroller_bloc.dart';
import 'package:visionui/features/presentation/blocs/search_provider.dart';

class SearchFileWidget extends StatelessWidget {
  const SearchFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 500,
      decoration: BoxDecoration(
        border: Border.all(color: ColorPalete.fileBolder),
        borderRadius: BorderRadius.circular(10),
        color: ColorPalete.scaffoldBackgroundColor,
      ),
      child: BlocConsumer<FileSearchBloc, FileSearchState>(
        listener: (context, state) {
          if (state is FileSearchStateLoaded) {
            // notify the repository with new folder structure
            context.read<FoldercontrollerBloc>().add(FoldercontrollerEventUpdateTextSearchFolders(appFiles: state.files));
          }
        },
        builder: (context, state) {
          if (state is FileSearchStateLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is FileSearchStateLoaded) {
            return getFilesList(state.files, context);
          }

          return Center(
            child: Text("content loaded"),
          );
        },
      ),
    );
  }

  Widget getFilesList(List<AppFile> appFiles, BuildContext context) {
    return ListView.builder(
      itemBuilder: (_, index) => getAppFileCard(appFiles[index], context),
      itemCount: appFiles.length,
    );
  }

  Widget getAppFileCard(AppFile appFile, BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: ColorPalete.fileBolder,
          ))),
          child: GestureDetector(
            onTap: () {
              context.read<SearchProvider>().hide();
              context.read<FileViewBloc>().add(FileViewEventViewFile(appFile: appFile));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 20,
              children: [
                Text(appFile.name),
                Text(
                  appFile.path,
                  style: TextStyle(color: const Color.fromARGB(255, 149, 148, 147)),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          // height: 30,
          width: double.infinity,
          color: ColorPalete.scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "...Search text appeared here....",
                style: TextStyle(color: const Color.fromARGB(255, 149, 148, 147)),
              ),
              Text(
                "...Search text appeared here....",
                style: TextStyle(color: const Color.fromARGB(255, 149, 148, 147)),
              ),
              Text(
                "...Search text appeared here....",
                style: TextStyle(color: const Color.fromARGB(255, 149, 148, 147)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
