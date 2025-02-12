import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/features/presentation/blocs/foldercontroller/foldercontroller_bloc.dart';

class FolderSection extends StatefulWidget {
  const FolderSection({super.key});

  @override
  State<FolderSection> createState() => _FolderSectionState();
}

class _FolderSectionState extends State<FolderSection> {
  @override
  void initState() {
    super.initState();
    context.read<FoldercontrollerBloc>().add(FoldercontrollerEventSearch(pageIndex: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FoldercontrollerBloc, FoldercontrollerState>(
        builder: (context, state) {
          print(state);
          return Center();
        },
        listener: (context, state) {},
      ),
    );
  }
}
