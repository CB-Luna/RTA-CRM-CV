import 'package:flutter/material.dart';

class ImagePopup extends StatelessWidget {
  final String imagePath;

  ImagePopup({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Container(
        height: MediaQuery.of(context).size.height *
            0.4, // Set the height to half of the screen height
        width: MediaQuery.of(context).size.width *
            0.9, // Set the width to 80% of the screen width
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0)),

        child: Center(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
