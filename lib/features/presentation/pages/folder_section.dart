import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/core/theme/color_palete.dart';
import 'package:visionui/features/presentation/blocs/folder/folder_bloc.dart';
import 'package:visionui/features/presentation/blocs/foldercontroller/foldercontroller_bloc.dart';
import 'package:visionui/features/presentation/widgets/folder_widget.dart';
import 'package:visionui/features/presentation/widgets/input_field.dart';

class FolderSection extends StatefulWidget {
  final double initialWidthFactor;

  const FolderSection({super.key, this.initialWidthFactor = 0.25});

  @override
  State<FolderSection> createState() => _FolderSectionState();
}

class _FolderSectionState extends State<FolderSection> {
  late double widthFactor;
  late TextEditingController searchController;
  Timer? _searchDebounce; // Timer for handling debounce

  @override
  void initState() {
    super.initState();
    widthFactor = widget.initialWidthFactor;
    searchController = TextEditingController();
    context.read<FoldercontrollerBloc>().add(FoldercontrollerEventSearch(pageIndex: 0));

    // Listen for search input changes
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _searchDebounce?.cancel(); // Cancel any existing timer
    _searchDebounce = Timer(const Duration(milliseconds: 500), () {
      final query = searchController.text.trim();
      if (query.isNotEmpty) {
        // Dispatch search event when user stops typing
        context.read<FoldercontrollerBloc>().add(FoldercontrollerEventSearch(pageIndex: 0, search: query));
      } else {
        context.read<FoldercontrollerBloc>().add(FoldercontrollerEventSearch(pageIndex: 0));
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _searchDebounce?.cancel();
    super.dispose();
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
      behavior: HitTestBehavior.opaque,
      onHorizontalDragUpdate: (details) {
        setState(() {
          widthFactor += details.primaryDelta! / screenWidth;
          widthFactor = widthFactor.clamp(0.20, 0.45);
        });
      },
      child: Container(
        color: ColorPalete.repositoryBackgroundColor,
        width: screenWidth * widthFactor,
        height: double.infinity,
        child: Column(
          children: [
            getHeading(screenWidth),
            Expanded(
              child: BlocConsumer<FoldercontrollerBloc, FoldercontrollerState>(
                builder: (context, state) {
                  if (state is FoldercontrollerStateLoading || state is FoldercontrollerInitial) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is FoldercontrollerStateLoaded) {
                    return SingleChildScrollView(child: folderWidget(state.folder, state.search));
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

  Widget getHeading(double screenWidth) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SizedBox(
          width: screenWidth * widthFactor,
          child: Row(
            children: [
              getTitle,
              SizedBox(
                width: 10,
              ),
              // input boc
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: InputField(
                    hintText: "Search",
                    controller: searchController,
                    cursorHeight: 12,
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  Widget folderWidget(Folder folder, String? searchText) {
    String search = searchController.text.trim();
    return BlocProvider<FolderBloc>(
      create: (context) => FolderBloc(folder: folder, search: search.isEmpty ? searchText : search),
      child: FolderWidget(
        folder: folder,
        parentFolder: null,
        search: search.isEmpty ? searchText : search,
      ),
    );
  }
}
