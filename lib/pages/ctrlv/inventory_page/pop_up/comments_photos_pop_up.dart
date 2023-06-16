import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
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
    final urlImages = [
      "https://twenergy.com/wp-content/uploads/2019/07/coches-y-contaminacion-1280x720.jpg",
      "https://www.lapatria.com/sites/default/files/styles/opengraph_1200x630/public/noticia/2023-01/644797-1121123.webp?itok=CCodtXHT",
    ];
    return CustomCard(
        title: "Photos and Comments",
        width: 450,
        height: 562,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () {
                  provider.cambiosVistaPhotosComments();
                },
                child: const Text("Back"),
              ),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20.0),
                  width: 200,
                  child: const Text("Date: 23/JUN/2024"),
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  height: 150,
                  alignment: Alignment.center,
                  width: 450,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          spreadRadius: 2,
                        )
                      ]),
                  child: const Text(
                      "The expiration date is due, need replacement as soon as posible."),
                ),
                CarouselSlider.builder(
                  itemCount: urlImages.length,
                  itemBuilder: (context, index, realIndex) {
                    final urlImage = urlImages[index];
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
      margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
