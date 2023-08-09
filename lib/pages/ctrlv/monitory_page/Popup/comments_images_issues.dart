import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/card_header.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class CommentsImagesIssues extends StatefulWidget {
  final int popUp;
  const CommentsImagesIssues({super.key, required this.popUp});

  @override
  State<CommentsImagesIssues> createState() => _CommentsImagesIssuesState();
}

class _CommentsImagesIssuesState extends State<CommentsImagesIssues> {
  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 700,
        height: 750,
        decoration: BoxDecoration(
            gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CardHeader(
                  text:
                      "${provider.actualDetailField?.nameIssue.capitalize.replaceAll("_", ' ')}"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(20),
                  child: CustomTextIconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    text: "",
                    isLoading: false,
                    onTap: () {
                      provider.updateViewPopup(provider.popUpExtra);
                    },
                  ),
                ),
                 Padding(
                   padding: const EdgeInsets.only(right: 15),
                   child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.04,
                      decoration: BoxDecoration(
                        color: statusColor(
                            provider.monitoryActual!.vehicle.company.company),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          provider.monitoryActual!.vehicle.licesensePlates,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                 ),
              ],
            ),
            // 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                    provider.actualDetailField!.status ? "Good" : "Bad",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: provider.actualDetailField!.status
                          ? Color.fromARGB(200, 65, 155, 23)
                          : Color.fromARGB(200, 210, 0, 48),
                    ),
                  ),
                ),
              ],
            ),
            
            Container(
              padding: const EdgeInsets.all(15.0),
              alignment: Alignment.center,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                DateFormat("MMM/dd/yyyy")
                    .format(provider.actualDetailField!.dateAdded),
                style: TextStyle(
                    color: AppTheme.of(context).contenidoTablas.color,
                    fontFamily: 'Bicyclette-Thin',
                    fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                    fontWeight: FontWeight.bold),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(20.0),
              padding: const EdgeInsets.all(10.0),
              height: 150,
              alignment: Alignment.center,
              width: 350,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
                ],
              ),
              child: SingleChildScrollView(
                  child: Text(provider.actualDetailField?.comments != ""
                      ? "${provider.actualDetailField?.comments}"
                      : "No Comments")),
            ),
            provider.actualDetailField?.listImages?.length == null ||
                    provider.actualDetailField?.listImages?.length == 0
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: CarouselSlider.builder(
                      itemCount: 1,
                      itemBuilder: (context, index, realIndex) {
                        const urlImage =
                            "https://supa43.rtatel.com/storage/v1/object/public/assets/no_image.jpg";

                        return buildImage(urlImage, index);
                      },
                      options: CarouselOptions(height: 200),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: CarouselSlider.builder(
                      itemCount: provider.actualDetailField?.listImages?.length,
                      itemBuilder: (context, index, realIndex) {
                        final urlImage =
                            provider.actualDetailField!.listImages![index];

                        return buildImage(urlImage, index);
                      },
                      options: CarouselOptions(height: 200),
                    ),
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
        boxShadow: const [
          BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );

Color statusColor(String status) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = const Color(0XFFB2333A);
      break;
    case "SMI": //Sen. Exec. Validate
      color = const Color.fromRGBO(255, 138, 0, 1);
      break;
    case "CRY": //Finance Validate
      color = const Color(0XFF345694);
      break;

    default:
      return Colors.black;
  }
  return color;
}
