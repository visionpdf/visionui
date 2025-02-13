import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visionui/features/presentation/blocs/file_search/file_search_bloc.dart';
import 'package:visionui/features/presentation/blocs/foldercontroller/foldercontroller_bloc.dart';
import 'package:visionui/features/presentation/blocs/search_provider.dart';
import 'package:visionui/features/presentation/widgets/file_view_widget.dart';
import 'package:visionui/features/presentation/widgets/input_field.dart';
import 'package:visionui/features/presentation/widgets/search_file_widget.dart';

class FileSection extends StatefulWidget {
  const FileSection({super.key});

  @override
  State<FileSection> createState() => _FileSectionState();
}

class _FileSectionState extends State<FileSection> {
  FocusNode focusNode = FocusNode();
  late TextEditingController searchController;
  Timer? _searchDebounce; // Timer for handling debounce
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
    // Listen for search input changes
    searchController.addListener(_onSearchChanged);

    // focusNode.addListener(() {
    //   if (focusNode.hasFocus) {
    //     context.read<SearchProvider>().show();
    //   }
    // });
  }

  void _onSearchChanged() {
    _searchDebounce?.cancel(); // Cancel any existing timer
    _searchDebounce = Timer(const Duration(milliseconds: 250), () {
      final query = searchController.text.trim();
      if (query.isNotEmpty) {
        context.read<SearchProvider>().show();
        context.read<FileSearchBloc>().add(FileSearchEventSearchText(text: query));
      } else {
        context.read<SearchProvider>().hide();
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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, top: 15, right: 8, bottom: 8),
        child: ListView(
          children: [
            // search section
            SizedBox(
              height: 30,
              child: InputField(
                hintText: "search file",
                textAlign: TextAlign.center,
                controller: searchController,
                cursorHeight: 12,
                focusNode: focusNode,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            Consumer<SearchProvider>(
              builder: (context, value, child) {
                return value.showSearch ? SearchFileWidget() : const SizedBox(height: 0, width: 0);
              },
            ),
            Container(height: height, child: FileViewWidget())
            // file section
          ],
        ),
      ),
    );
  }
}
