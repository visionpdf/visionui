import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visionui/core/entity/file.dart';
import 'package:visionui/core/entity/folder.dart';
import 'package:visionui/features/presentation/blocs/folder/folder_bloc.dart';
import 'package:visionui/features/presentation/widgets/gradient_button.dart';
import 'package:visionui/features/presentation/widgets/input_field.dart';

class FileUploadWidget extends StatefulWidget {
  final FolderBloc folderBloc;
  const FileUploadWidget({super.key, required this.folderBloc});

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _folderController = TextEditingController();

  final TextEditingController _fileController = TextEditingController();

  bool createSubFolder = false;
  SelectedFile? selectedFile;
  bool isUploading = false;

  @override
  void dispose() {
    _folderController.dispose();
    _fileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isUploading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : AlertDialog(
            title: Text(
              "Upload",
              textAlign: TextAlign.center,
              style: GoogleFonts.inriaSerif(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            content: Form(
              key: _formKey,
              child: SizedBox(
                // height: 200,
                width: 500,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Create subfolder"),
                          Checkbox(
                            value: createSubFolder,
                            onChanged: (value) => setState(() {
                              createSubFolder = value ?? false;
                            }),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: createSubFolder,
                      child: InputField(
                        controller: _folderController,
                        hintText: 'Sub folder name',
                        validator: (p0) => hasFolderAlready(p0),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: true,
                      child: InputField(
                        controller: _fileController,
                        enabled: false,
                        hintText: selectedFile == null ? 'No file selected' : selectedFile!.name,
                        validator: (p0) => hasFolderAlready(p0),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GradientButton(
                      onPressed: () async {
                        final file = await pickFile();
                        if (file != null) {
                          setState(() {
                            selectedFile = file;
                            _fileController.text = selectedFile!.name;
                          });
                        }
                      },
                      text: selectedFile != null ? "Pick again" : "Pick a file",
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // Visibility(
                    //   visible: selectedFile != null,
                    //   child: selectedFile != null ? Text(selectedFile!.name) : SizedBox.shrink(),
                    // ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context), // Close the dialog
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  if ((!_formKey.currentState!.validate() && createSubFolder) || selectedFile == null) {
                    return;
                  }

                  setState(() {
                    isUploading = true;
                  });
                  Folder folder = widget.folderBloc.state.folder;
                  // emit state for the respective bloc that state is updating
                  widget.folderBloc.add(FolderEventLoading(folder: folder));

                  try {
                    await Future.delayed(Duration(seconds: 2));

                    AppFile appFile = AppFile(
                        name: selectedFile!.name,
                        format: "pdf",
                        path: "${folder.path}${createSubFolder ? _folderController.text.trim() : ""}/${selectedFile!.name}");
                    Folder updatedFolder;
                    if (createSubFolder == true) {
                      Folder newfolder = Folder(
                          name: _folderController.text.trim(),
                          folders: [],
                          files: [appFile],
                          path: "${folder.path}/${_folderController.text.trim()}");
                      updatedFolder = Folder(name: folder.name, folders: folder.folders..add(newfolder), files: folder.files, path: folder.path);
                    } else {
                      updatedFolder = Folder(name: folder.name, folders: folder.folders, files: folder.files..add(appFile), path: folder.path);
                    }

                    widget.folderBloc.add(FolderEventUpdate(folder: updatedFolder));

                    if (context.mounted) Navigator.of(context).pop();
                  } catch (e) {
                    widget.folderBloc.add(FolderEventFailed(folder: widget.folderBloc.state.folder));
                    if (context.mounted) Navigator.of(context).pop();
                  }
                },
                child: Text("Upload"),
              ),
            ],
          );
  }

  String? hasFolderAlready(String folderName) {
    return widget.folderBloc.state.folder.folders.where((element) => element.name == folderName).isEmpty ? null : "Folder name already exists";
  }
}

Future<void> showUploadDialog(BuildContext context, FolderBloc folderBloc) async {
  await showDialog(
    context: context,
    builder: (_) => FileUploadWidget(folderBloc: folderBloc),
  );
}

Future<SelectedFile?> pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    final fileName = result.files.single.xFile.name;
    return SelectedFile(name: fileName, file: File(result.files.single.xFile.path));
  }
  return null;
}

class SelectedFile {
  final String name;
  final File file;

  SelectedFile({required this.name, required this.file});
}
