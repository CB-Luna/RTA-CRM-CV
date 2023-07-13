import 'package:carousel_slider/carousel_slider.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../providers/ctrlv/inventory_provider.dart';

class CommentsPhotosPopUp extends StatefulWidget {
  const CommentsPhotosPopUp({super.key});

  @override
  State<CommentsPhotosPopUp> createState() => _CommentsPhotosPopUpState();
}

class _CommentsPhotosPopUpState extends State<CommentsPhotosPopUp> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);

    return CustomCard(
        title: provider.actualissuesComments!.nameIssue.capitalize.replaceAll("_", " "),
        width: 450,
        height: 562,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  provider.setIssueViewActual(1);
                },
                child: const Text("Back"),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Text("Date: "),
                      Text(
                        DateFormat("MMM/dd/yyyy").format(provider.actualissuesComments!.dateAdded),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
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
                    boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))],
                  ),
                  child: SingleChildScrollView(child: Text("${provider.actualissuesComments!.comments}.")),
                ),
                CarouselSlider.builder(
                  itemCount: provider.actualissuesComments?.listImages!.length,
                  itemBuilder: (context, index, realIndex) {
                    // final urlImage =
                    //     provider.actualissuesComments?.listImages![index];
                    const urlImage = "https://supa43.rtatel.com/storage/v1/object/public/assets/bg1.png";
                    return buildImage(urlImage, index);
                  },
                  options: CarouselOptions(height: 200),
                )
              ],
            )
          ],
        ));
  }
}

Widget buildImage(String urlImage, int Index) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
