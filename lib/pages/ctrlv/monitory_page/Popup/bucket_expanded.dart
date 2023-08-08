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

class BucketCommentsImagesIssues extends StatefulWidget {
  const BucketCommentsImagesIssues({super.key});

  @override
  State<BucketCommentsImagesIssues> createState() => _BucketCommentsImagesIssuesState();
}

class _BucketCommentsImagesIssuesState extends State<BucketCommentsImagesIssues> {
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
              child:
                  CardHeader(text: "${provider.actualDetailField?.nameIssue.capitalize.replaceAll("_", ' ')}"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(20),
                  child: CustomTextIconButton(
                    width: 83,
                    isLoading: false,
                    icon: Icon(Icons.arrow_back_outlined,
                        color: AppTheme.of(context).primaryBackground),
                    text: '',
                    color: AppTheme.of(context).primaryColor,
                    onTap: () async {
                      provider.updateViewPopup(provider.popUpExtra);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:15.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.03,
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
            Padding(
              padding: const EdgeInsets.only(bottom:15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Text(
                  provider.actualDetailField!.status ? "Yes" : "No",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: provider.actualDetailField!.status
                        ? Color.fromARGB(200, 65, 155, 23)
                        : Color.fromARGB(200, 210, 0, 48),
                  ),
                ),
                ],
              ),
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
                  child: Text(provider.actualDetailField?.comments != "" ? "${provider.actualDetailField?.comments}" : "No Comments")),
            ),
            SizedBox(
              height: 300,
              width: 400,
              child: CarouselSlider.builder(
                itemCount: provider.actualDetailField?.listImages?.length ?? 0,
                itemBuilder: (context, index, realIndex) {
                  const urlImage =
                      "https://supa43.rtatel.com/storage/v1/object/public/assets/bg1.png";
                      // final urlImage =
                      // provider.actualDetailField?.listImages?[index] ?? "";
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

