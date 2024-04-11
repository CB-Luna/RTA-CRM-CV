import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';

import '../../../../providers/jsa/jsa_provider.dart';
import '../../../../theme/theme.dart';

class PdfFullSize extends StatefulWidget {
  const PdfFullSize({
    super.key,
    required this.pdfController,
  });
  final PdfController pdfController;

  @override
  State<PdfFullSize> createState() => _PdfFullSizeState();
}

class _PdfFullSizeState extends State<PdfFullSize> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 1024;
    JsaProvider provider = Provider.of<JsaProvider>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: height * 820,
      width: MediaQuery.of(context).size.width * 0.5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: AppTheme.of(context).primaryColor,
                width: 1.5,
              ),
            ),
            child: provider.finalPdfController == null
                ? const CircularProgressIndicator()
                : PdfView(
                    pageSnapping: false,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    renderer: (PdfPage page) {
                      if (page.width >= page.height) {
                        return page.render(
                          width: page.width * 7,
                          height: page.height * 4,
                          format: PdfPageImageFormat.jpeg,
                          backgroundColor: '#15FF0D',
                        );
                      } else if (page.width == page.height) {
                        return page.render(
                          width: page.width * 4,
                          height: page.height * 4,
                          format: PdfPageImageFormat.jpeg,
                          backgroundColor: '#15FF0D',
                        );
                      } else {
                        return page.render(
                          width: page.width * 4,
                          height: page.height * 7,
                          format: PdfPageImageFormat.jpeg,
                          backgroundColor: '#15FF0D',
                        );
                      }
                    },
                    controller: provider.finalPdfController!,
                    onDocumentLoaded: (document) {},
                    onPageChanged: (page) {},
                    onDocumentError: (error) {},
                  )),
      ),
    );
  }
}
