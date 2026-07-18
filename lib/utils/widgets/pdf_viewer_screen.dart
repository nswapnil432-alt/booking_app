import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../widgets/appbar/appbar_cutom_widget.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfPath;
  final List<int>? pdfBytes;
  final String title;
  const PdfViewerScreen({
    super.key, 
    required this.pdfPath, 
    this.pdfBytes,
    this.title = "View Document",
  });

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  int totalPages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pdfPath.isEmpty) {
      return const Scaffold(body: Center(child: Text("Path is empty")));
    }

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppbarCutomWidget(
        title: widget.title,
        titleFontSize: 20.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.black,
            size: 18,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.pdfBytes == null ? widget.pdfPath : null,
            pdfData: widget.pdfBytes != null ? Uint8List.fromList(widget.pdfBytes!) : null,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: true,
            pageFling: true,
            fitEachPage: true,
            backgroundColor: Colors.white,
            onRender: (pages) {
              setState(() {
                totalPages = pages ?? 0;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = error.toString();
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                currentPage = page ?? 0;
              });
            },
          ),
          if (errorMessage.isNotEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Error loading PDF: $errorMessage\n\nPath: ${widget.pdfPath}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: isReady && totalPages > 1
          ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
                "${currentPage + 1} / $totalPages",
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
          )
          : null,
    );
  }
}
