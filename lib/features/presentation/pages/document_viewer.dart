import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui' as ui;

class DocumentViewer extends StatelessWidget {
  final String fileUrl; // Example: "http://localhost:8080/view?fileName=example.docx"

  const DocumentViewer({super.key, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    registerIframe(fileUrl);
    return Scaffold(
      appBar: AppBar(title: Text("View Document")),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: HtmlElementView(
            viewType: fileUrl,
          ),
        ),
      ),
    );
  }
}

void registerIframe(String url) {
  final iframe = html.IFrameElement()
    ..src = url
    ..style.border = "none"
    ..width = "100%"
    ..height = "100%";

  html.document.body!.append(iframe);
  // Register the iframe as a view
  // ignore: undefined_prefixed_name
  ui.platformViewRegistry.registerViewFactory(url, (int viewId) => iframe);
}
