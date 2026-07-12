import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:dr_nada_salma_med_edu_plat/core/local/auth_local_data_source.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';

class PdfViewerScreen extends StatefulWidget {
  final String pdfUrl;
  final String title;

  const PdfViewerScreen({super.key, required this.pdfUrl, required this.title});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  Uint8List? _pdfBytes;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = "حدث خطأ أثناء تحميل الملف";

  @override
  void initState() {
    super.initState();
    _fetchPdf();
  }

  String _getDirectPdfUrl(String url) {
    if (url.contains('drive.google.com/file/d/')) {
      final regExp = RegExp(r'file\/d\/([a-zA-Z0-9_-]+)');
      final match = regExp.firstMatch(url);
      if (match != null && match.groupCount >= 1) {
        final fileId = match.group(1);
        return 'https://drive.google.com/uc?export=download&id=$fileId';
      }
    } else if (url.toLowerCase().contains('1drv.ms') || url.toLowerCase().contains('onedrive')) {
      return url.contains('?') ? '${url.split('?').first}?download=1' : '$url?download=1';
    }
    return url;
  }

  Future<void> _fetchPdf() async {
    try {
      final token = sharedPreferences.get(cacheTokenConst);
      
      final downloadUrl = _getDirectPdfUrl(widget.pdfUrl);
      
      debugPrint("Fetching PDF from: $downloadUrl");
      
      final dio = Dio();
      final response = await dio.get(
        downloadUrl,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/pdf',
          },
        ),
      );
      
      if (mounted) {
        setState(() {
          // Properly convert List<int> to Uint8List
          if (response.data is Uint8List) {
            _pdfBytes = response.data;
          } else if (response.data is List<int>) {
            _pdfBytes = Uint8List.fromList(response.data);
          } else {
            _pdfBytes = Uint8List.fromList(List<int>.from(response.data));
          }
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("PDF Download Error: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
          if (e is DioException) {
             _errorMessage = "حدث خطأ: \${e.response?.statusCode ?? e.message}";
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyles.textStyleBold18.copyWith(color: white),
        ),
        backgroundColor: orangeBold,
        iconTheme: const IconThemeData(color: white),
      ),
      body: _isLoading 
          ? Center(child: CircularProgressIndicator(color: primary)) 
          : _hasError || _pdfBytes == null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyles.textStyleBold16.copyWith(color: primary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : SfPdfViewer.memory(
                  _pdfBytes!,
                  canShowScrollHead: false,
                  canShowScrollStatus: false,
                ),
    );
  }
}

