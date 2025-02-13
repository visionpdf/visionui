import 'dart:async';

import 'package:flutter/material.dart';
import 'package:visionui/features/presentation/widgets/file_view_widget.dart';
import 'package:visionui/features/presentation/widgets/input_field.dart';
import 'package:visionui/features/presentation/widgets/search_file_widget.dart';

class FileSection extends StatefulWidget {
  const FileSection({super.key});

  @override
  State<FileSection> createState() => _FileSectionState();
}

class _FileSectionState extends State<FileSection> {
  late TextEditingController searchController;
  Timer? _searchDebounce; // Timer for handling debounce
  bool showSearch = false;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
    // Listen for search input changes
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _searchDebounce?.cancel(); // Cancel any existing timer
    _searchDebounce = Timer(const Duration(milliseconds: 250), () {
      final query = searchController.text.trim();
      if (query.isNotEmpty) {
        // Dispatch search event when user stops typing
        setState(() {
          showSearch = true;
        });
      } else {
        setState(() {
          showSearch = false;
        });
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
        child: Column(
          children: [
            // search section
            SizedBox(
              height: 30,
              child: InputField(
                hintText: "search file",
                textAlign: TextAlign.center,
                controller: searchController,
                cursorHeight: 12,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(child: FileViewWidget()),
                  if (showSearch)
                    Positioned.fill(
                      bottom: height * 0.3,
                      child: SearchFileWidget(),
                    ),
                ],
              ),
            )
            // file section
          ],
        ),
      ),
    );
  }
}
