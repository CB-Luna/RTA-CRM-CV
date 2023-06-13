import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/inventory_provider.dart';

class ListIssuesCard extends StatefulWidget {
  final String TextoPrueba;
  const ListIssuesCard({super.key, required this.TextoPrueba});

  @override
  State<ListIssuesCard> createState() => _ListIssuesCardState();
}

class _ListIssuesCardState extends State<ListIssuesCard> {
  final urlImages = [
    'https://imagenes.elpais.com/resizer/9z60jBhIovsFI96r_FIRvi-aITc=/1960x1470/cloudfront-eu-central-1.images.arcpublishing.com/prisa/SOXUZIBP5TXB6RCFPBNC5POUXA.jpg',
    'https://cdn0.ecologiaverde.com/es/posts/1/4/4/que_tipo_de_polucion_emite_el_tubo_de_escape_de_un_coche_441_orig.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    //InventoryProvider provider = Provider.of<InventoryProvider>(context);

    return SizedBox(
        child: Column(
      children: [
        Container(
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.centerLeft,
            child: Text(
              "Issue: ${widget.TextoPrueba}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Issue 1"),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Issue 2"),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.all(10.0),
                height: 100,
                width: 100,
                //color: Colors.green,
                child: CarouselSlider.builder(
                  itemCount: urlImages.length,
                  options: CarouselOptions(height: 100),
                  itemBuilder: ((context, index, realIndex) {
                    final urlImage = urlImages[index];
                    return buildImage(urlImage, index);
                  }),
                ))
          ],
        ),
      ],
    ));
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
}
