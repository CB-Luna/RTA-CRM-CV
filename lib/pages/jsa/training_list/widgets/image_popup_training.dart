import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_training_list_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/get_image_widget.dart';

class ImagePopupJSATraining extends StatefulWidget {
  final String name;
  const ImagePopupJSATraining({required this.name, super.key});

  @override
  State<ImagePopupJSATraining> createState() => ImagePopupJSATrainingState();
}

class ImagePopupJSATrainingState extends State<ImagePopupJSATraining> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    JsaTrainingListProvider provider =
        Provider.of<JsaTrainingListProvider>(context);
    // double width = MediaQuery.of(context).size.width / 1440;
    // double height = MediaQuery.of(context).size.height / 1024;
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

                //Descargar Anexo
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: IconButton(
                    icon: Icon(Icons.file_download_outlined,
                        color: AppTheme.of(context).primaryColor),
                    tooltip: 'Download',
                    color: AppTheme.of(context).primaryColor,
                    onPressed: () {
                      provider.downloadAndSaveImage(widget.name);
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Text(
                      "Download",
                      style: TextStyle(
                        fontFamily: 'Gotham-Light',
                        color: AppTheme.of(context).cryPrimary,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                    )),

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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          8), // Radio de las esquinas del clip

                      child: getAddImageSafetyBrifing(widget.name,
                          boxFit: BoxFit.contain),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
