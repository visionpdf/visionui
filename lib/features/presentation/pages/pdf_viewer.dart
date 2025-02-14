import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:http/http.dart' as http;

class PdfViewer extends StatefulWidget {
  final String url;
  const PdfViewer({super.key, required this.url});

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  PdfControllerPinch? pdfController;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      print(widget.url);
      final response = await http.get(Uri.parse(widget.url));
      print("Response status: ${response.statusCode}");
      print("Response length: ${response.bodyBytes.length}");

      if (response.statusCode == 200 && response.bodyBytes.isNotEmpty) {
        setState(() {
          pdfController = PdfControllerPinch(document: PdfDocument.openData(response.bodyBytes));
        });
      } else {
        throw Exception("Invalid PDF response");
      }
    } catch (e) {
      print("Error loading PDF: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Viewing pdf");

    return Scaffold(
      body: pdfController == null
          ? const Center(child: CircularProgressIndicator())
          : LayoutBuilder(
              builder: (context, constraints) {
                double height = constraints.maxHeight;
                if (height.isNegative || height < 100) {
                  height = 500; // Set a default height
                }

                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 100, // Ensure a minimum height
                    maxHeight: height,
                  ),
                  child: PdfViewPinch(controller: pdfController!),
                );
              },
            ),
    );
  }
}
