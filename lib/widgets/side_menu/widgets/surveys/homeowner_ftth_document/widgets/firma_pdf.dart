// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/homeowner_ftth_document_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:signature/signature.dart';

class FirmaPDF extends StatefulWidget {
  const FirmaPDF({
    super.key,
  });
  @override
  State<FirmaPDF> createState() => FirmaPDFState();
}

class FirmaPDFState extends State<FirmaPDF> {
  @override
  void initState() {
    super.initState();
    /* WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final AprobacionSeguimientoPagosProvider provider = Provider.of<AprobacionSeguimientoPagosProvider>(
        context,
        listen: false,
      );
      //await provider.crearPDF(widget.propuesta);
    }); */
  }

  @override
  Widget build(BuildContext context) {
    final HomeownerFTTHDocumentProvider provider = Provider.of<HomeownerFTTHDocumentProvider>(context);
    double width = MediaQuery.of(context).size.width / 1440;
    double height = MediaQuery.of(context).size.height / 1024;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        provider.pdfController == null
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  decoration: BoxDecoration(border: Border.all(color: AppTheme.of(context).primaryColor)),
                  child: Signature(
                    controller: provider.clientSignatureController,
                    backgroundColor: AppTheme.of(context).primaryBackground,
                    width: width * 410,
                    height: height * 100,
                  ),
                ),
              ),
       
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CustomTextIconButton(
            width: width * 150,
            text: 'Clean Signature',
            isLoading: false,
            icon: const Icon(
              Icons.clear,
              color: Colors.red,
            ),
            color: AppTheme.of(context).primaryColor,
            onTap: () async{
              provider.clientSignatureController.clear();
              provider.firmaAnexo = false;
              await provider.clientPDF();
            },
          ),
        ),
      ],
    );
  }
}
