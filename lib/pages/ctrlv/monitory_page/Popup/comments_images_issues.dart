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
  const CommentsImagesIssues({super.key});

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
        height: 700,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(20),
                  child: CustomTextIconButton(
                    width: 83,
                    isLoading: false,
                    icon: Icon(Icons.arrow_back_outlined,
                        color: AppTheme.of(context).primaryBackground),
                    text: 'Back',
                    color: AppTheme.of(context).primaryColor,
                    onTap: () async {
                      provider.updateViewPopup(0);
                    },
                  ),
                ),
                SizedBox(
                  width: 200,
                ),
                Text(
                  provider.actualDetailField!.status ? "Good" : "Bad",
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
