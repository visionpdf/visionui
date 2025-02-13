import 'package:flutter/material.dart';
import 'package:visionui/features/presentation/widgets/gradient_button.dart';

class DocxWebView extends StatelessWidget {
  const DocxWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("DocX is not supported for view on web"),
          GradientButton(onPressed: () {}, text: "Download"),
        ],
      ),
    );
  }
}
