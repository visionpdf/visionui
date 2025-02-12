import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/core/theme/color_palete.dart';
import 'package:visionui/features/presentation/blocs/folder/folder_bloc.dart';
import 'package:visionui/features/presentation/blocs/foldercontroller/foldercontroller_bloc.dart';
import 'package:visionui/features/presentation/widgets/folder_widget.dart';

class FolderSection extends StatefulWidget {
  final double initialWidthFactor;

  const FolderSection({super.key, this.initialWidthFactor = 0.25});

  @override
  State<FolderSection> createState() => _FolderSectionState();
}

class _FolderSectionState extends State<FolderSection> {
  late double widthFactor;

  @override
  void initState() {
    super.initState();
    widthFactor = widget.initialWidthFactor;
    context.read<FoldercontrollerBloc>().add(FoldercontrollerEventSearch(pageIndex: 1));
  }

  void updateWidth(double factor) {
    setState(() {
      widthFactor = factor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          widthFactor += details.primaryDelta! / screenWidth;
          widthFactor = widthFactor.clamp(0.20, 0.50);
        });
      },
      child: Container(
        color: ColorPalete.repositoryBackgroundColor,
        width: screenWidth * widthFactor,
        height: double.infinity,
        child: Column(
          children: [
            getHeading,
            Expanded(
              child: BlocConsumer<FoldercontrollerBloc, FoldercontrollerState>(
                builder: (context, state) {
                  if (state is FoldercontrollerStateLoading || state is FoldercontrollerInitial) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FoldercontrollerStateLoaded) {
                    return SingleChildScrollView(child: folderWidget(state.folder));
                  }
                  return Center(
                    child: Text("Failed to get the repository details"),
                  );
                },
                listener: (context, state) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get getTitle => Text(
        "VisionPDF",
        style: TextTheme.of(context).titleMedium,
      );

  Widget get getHeading => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            getTitle,
            // input boc
          ],
        ),
      );

  Widget folderWidget(Folder folder) {
    return BlocProvider<FolderBloc>(
      create: (context) => FolderBloc(folder: folder),
      child: FolderWidget(
        folder: folder,
        parentFolder: null,
      ),
    );
  }
}
