// Automatic FlutterFlow imports
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// Begin custom widget code
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';

class FlutterFlowCarousel extends StatefulWidget {
  const FlutterFlowCarousel({
    Key? key,
    required this.width,
    required this.height,
    required this.listaImagenes,
    required this.deleteImage,
  }) : super(key: key);

  final double width;
  final double height;
  final List<ImageEvidence> listaImagenes;
  final void Function(ImageEvidence value)? deleteImage;

  @override
  _FlutterFlowCarouselState createState() => _FlutterFlowCarouselState();
}

class _FlutterFlowCarouselState extends State<FlutterFlowCarousel> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: widget.listaImagenes.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () async {},
              onLongPress: () async {
                bool? booleano = await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                      ),
                    );
                  },
                );
                if (booleano != null && booleano == true) {
                  setState(() {
                    widget.deleteImage!(i);
                  });
                }
              },
              child: Hero(
                tag: i.path,
                transitionOnUserGestures: true,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                  ),
                  child: //TODO: manejar imagen de red
                      Image.file(
                    File(i.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class ImageEvidence {
  final String path;
  final Uint8List uint8List;
  final String name;

  ImageEvidence({
    required this.path,
    required this.uint8List,
    required this.name,
  });

  factory ImageEvidence.fromJson(String str) =>
      ImageEvidence.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ImageEvidence.fromMap(Map<String, dynamic> json) => ImageEvidence(
        path: json["path"],
        uint8List: json["uint8List"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "path": path,
        "uint8List": uint8List,
        "name": name,
      };
}
