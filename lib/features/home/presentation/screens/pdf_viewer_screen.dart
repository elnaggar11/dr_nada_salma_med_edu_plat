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

  Future<void> _fetchPdf() async {
    try {
      final token = sharedPreferences.get(cacheTokenConst);
      debugPrint("Fetching PDF from: \${widget.pdfUrl}");
      
      final dio = Dio();
      final response = await dio.get(
        widget.pdfUrl,
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
        backgroundColor: primary,
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

