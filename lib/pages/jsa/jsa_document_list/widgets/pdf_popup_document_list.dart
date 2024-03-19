import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_document_list_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class PdfPopupJSADocumentList extends StatefulWidget {
  const PdfPopupJSADocumentList({super.key});

  @override
  State<PdfPopupJSADocumentList> createState() =>
      PdfPopupJSADocumentListState();
}

class PdfPopupJSADocumentListState extends State<PdfPopupJSADocumentList> {
  @override
  void initState() {
    super.initState();

    /*  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final PDFListProvider provider = Provider.of<PDFListProvider>(
        context,
        listen: false,
      );
      //await provider.crearPDF(widget.propuesta);
      //provider.controller.clear();
    }); */
  }

  @override
  Widget build(BuildContext context) {
    final JSADocumentListProvider provider =
        Provider.of<JSADocumentListProvider>(context);
    double width = MediaQuery.of(context).size.width / 1440;
    double height = MediaQuery.of(context).size.height / 1024;
    return AlertDialog(
      key: UniqueKey(),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      content: Container(
        width: 750,
        height: 750,
        decoration: BoxDecoration(
          gradient: whiteGradient,
          borderRadius: const BorderRadius.all(
            Radius.circular(21),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                //Pantalla Completa
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: IconButton(
                      icon: Icon(Icons.fullscreen,
                          color: AppTheme.of(context).primaryColor),
                      tooltip: 'Full Screen',
                      color: AppTheme.of(context).primaryColor,
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                content: SizedBox(
                                  width: width * 1000,
                                  height: height * 1000,
                                  child: PdfView(
                                    backgroundDecoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(21),
                                      ),
                                    ),
                                    controller: provider.pdfController!,
                                  ),
                                ));
                          },
                        );
                      }),
                ),
                //Descargar Anexo
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: IconButton(
                    icon: Icon(Icons.file_download_outlined,
                        color: AppTheme.of(context).primaryColor),
                    tooltip: 'Download',
                    color: AppTheme.of(context).primaryColor,
                    onPressed: () {
                      // provider.descargarArchivo(
                      //     provider.documento, '${provider.pdfController}');
                      // provider.anexo = true;
                      setState(() {});
                    },
                  ),
                ),

                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: IconButton(
                    icon: Icon(Icons.close,
                        color: AppTheme.of(context).primaryColor),
                    tooltip: 'Exit',
                    color: AppTheme.of(context).primaryColor,
                    onPressed: () {
                      provider.pdfController = null;
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: BoxDecoration(
                      color: const Color(0xff262626),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.of(context).primaryColor,
                        width: 1.5,
                      ),
                    ),
                    child: provider.pdfController == null
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
                            controller: provider.pdfController!,
                            onDocumentLoaded: (document) {},
                            onPageChanged: (page) {},
                            onDocumentError: (error) {},
                          )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
