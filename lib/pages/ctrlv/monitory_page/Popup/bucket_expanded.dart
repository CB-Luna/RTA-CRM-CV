import 'package:card_swiper/card_swiper.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/card_header.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class BucketCommentsImagesIssues extends StatefulWidget {
  const BucketCommentsImagesIssues({super.key});

  @override
  State<BucketCommentsImagesIssues> createState() => _BucketCommentsImagesIssuesState();
}

class _BucketCommentsImagesIssuesState extends State<BucketCommentsImagesIssues> {
  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    const urlImage = "https://supa43.rtatel.com/storage/v1/object/public/assets/no_image.jpg";
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: BoxDecoration(
          gradient: whiteGradient,
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CardHeader(text: "${provider.actualDetailField?.nameIssue.capitalize.replaceAll("_", ' ')}"),
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(20),
                        child: CustomTextIconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          text: "",
                          isLoading: false,
                          onTap: () {
                            provider.updateViewPopup(provider.popUpExtra);
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15.0),
                        alignment: Alignment.center,
                        width: 250,
                        child: Text(
                          provider.actualDetailField!.status ? "Yes" : "No",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: provider.actualDetailField!.status ? const Color.fromARGB(200, 65, 155, 23) : const Color.fromARGB(200, 210, 0, 48),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.1,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: BoxDecoration(
                            color: statusColor(provider.monitoryActual!.vehicle.company.company, context),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              provider.monitoryActual!.vehicle.licesensePlates,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          DateFormat("MMM/dd/yyyy").format(provider.actualDetailField!.dateAdded),
                          style: TextStyle(color: Colors.blue, fontFamily: 'Bicyclette-Thin', fontSize: AppTheme.of(context).contenidoTablas.fontSize, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      padding: const EdgeInsets.all(10.0),
                      alignment: Alignment.center,
                      width: 400,
                      height: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))],
                      ),
                      child: Column(
                        children: [
                          const Text("COMMENTS"),
                          SingleChildScrollView(
                            child: Text(provider.actualDetailField?.comments != "" ? "${provider.actualDetailField?.comments}" : "No Comments"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                provider.actualDetailField?.listImages?.length == null ||
                        // ignore: prefer_is_empty
                        provider.actualDetailField?.listImages?.length == 0
                    ? SizedBox(height: MediaQuery.of(context).size.height * 0.30, width: MediaQuery.of(context).size.width * 0.15, child: Image.network(urlImage, fit: BoxFit.contain))
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Swiper(
                          itemCount: provider.actualDetailField!.listImages!.length,
                          itemBuilder: (context, index) {
                            final urlImage = provider.actualDetailField!.listImages![index];
                            return Image.network(urlImage, fit: BoxFit.fill);
                          },
                          itemWidth: 300.0,
                          layout: SwiperLayout.STACK,
                        ),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildImage(String urlImage, int index) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );

Color statusColor(String status, BuildContext context) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = AppTheme.of(context).odePrimary;
      break;
    case "SMI": //Sen. Exec. Validate
      color = AppTheme.of(context).smiPrimary;
      break;
    case "CRY": //Finance Validate
      color = AppTheme.of(context).cryPrimary;
      break;

    default:
      return Colors.black;
  }
  return color;
}
