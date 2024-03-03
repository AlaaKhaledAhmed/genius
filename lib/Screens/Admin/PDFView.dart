import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../Widget/AppBar.dart';
import '../../Widget/AppColor.dart';
import '../../Widget/GeneralWidget.dart';

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl;
  final String titleName;
  const PDFViewerPage(
      {super.key, required this.pdfUrl, required this.titleName});

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  bool _isLoading = true;
  late String _pdfPath = '';

  @override
  void initState() {
    super.initState();
    _downloadPDF(widget.pdfUrl);
  }

  Future<void> _downloadPDF(String url) async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final filePath = '${documentDirectory.path}/mypdf.pdf';
    final file = File(filePath);

    if (file.existsSync()) {
      setState(() {
        _pdfPath = filePath;
        _isLoading = false;
      });
    } else {
      final response = await http.get(Uri.parse(url));
      await file.writeAsBytes(response.bodyBytes);
      setState(() {
        _pdfPath = filePath;
        _isLoading = false;
      });
    }
  }

  void _downloadToDevice() async {
    final response = await http.get(Uri.parse(widget.pdfUrl));
    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File('${documentDirectory.path}/mypdf.pdf');
    await file.writeAsBytes(response.bodyBytes);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'تم تحميل ملف PDF إلى الجهاز',
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Delete the PDF file when the screen is disposed
    if (_pdfPath.isNotEmpty) {
      File(_pdfPath).deleteSync();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        text: widget.titleName,
        isBasics: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.download,
              color: AppColor.white,
            ),
            onPressed: () {
              _downloadToDevice();
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              width: GeneralWidget.width(context),
              height: GeneralWidget.height(context),
              child: PDFView(
                pageSnap: false,
                // autoSpacing: false,
                filePath: _pdfPath,
              ),
            ),
    );
  }
}
