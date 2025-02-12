import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionui/core/theme/app_theme.dart';
import 'package:visionui/core/theme/color_palete.dart';
import 'package:visionui/features/presentation/blocs/foldercontroller/foldercontroller_bloc.dart';
import 'package:visionui/features/presentation/pages/folder_section.dart';
import 'package:visionui/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<FoldercontrollerBloc>(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.getDarkTheme,
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              FolderSection(initialWidthFactor: 0.20), // Adjust width as needed
              Expanded(
                child: Container(color: ColorPalete.scaffoldBackgroundColor),
              ),
            ],
          );
        },
      ),
    );
  }
}
