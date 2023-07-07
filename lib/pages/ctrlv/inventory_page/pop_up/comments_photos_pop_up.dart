import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class CommentsPhotosPopUp extends StatefulWidget {
  const CommentsPhotosPopUp({super.key});

  @override
  State<CommentsPhotosPopUp> createState() => _CommentsPhotosPopUpState();
}

class _CommentsPhotosPopUpState extends State<CommentsPhotosPopUp> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);

    return Container(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: CustomTextIconButton(
              width: 83,
              isLoading: false,
              icon: Icon(Icons.arrow_back_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Back',
              color: AppTheme.of(context).primaryColor,
              onTap: () async {
                provider.setIssueViewActual(1);
                provider.clearRegistroIssueComments;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(15.0),
                alignment: Alignment.center,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 4,
                        color: Colors.grey,
                        offset: Offset(10, 10))
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  DateFormat("MMM/dd/yyyy")
                      .format(provider.registroIssueComments!.dateAdded),
                  style: TextStyle(
                      color: AppTheme.of(context).contenidoTablas.color,
                      fontFamily: 'Bicyclette-Thin',
                      fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                      fontWeight: FontWeight.bold),
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
                        blurRadius: 4,
                        color: Colors.grey,
                        offset: Offset(10, 10))
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  provider.registroIssueComments!.nameIssue,
                  style: TextStyle(
                      color: AppTheme.of(context).contenidoTablas.color,
                      fontFamily: 'Bicyclette-Thin',
                      fontSize: AppTheme.of(context).contenidoTablas.fontSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
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
                        blurRadius: 4,
                        color: Colors.grey,
                        offset: Offset(10, 10))
                  ],
                ),
                child: SingleChildScrollView(
                    child:
                        Text("${provider.registroIssueComments!.comments}.")),
              ),
              SizedBox(
                height: 335,
                width: 400,
                child: CarouselSlider.builder(
                  itemCount: provider.registroIssueComments?.listImages!.length,
                  itemBuilder: (context, index, realIndex) {
                    // final urlImage =
                    //     provider.actualissuesComments?.listImages![index];
                    const urlImage =
                        "https://supa43.rtatel.com/storage/v1/object/public/assets/bg1.png";
                    return buildImage(urlImage, index);
                  },
                  options: CarouselOptions(height: 200),
                ),
              ),
            ],
          )
        ],
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
