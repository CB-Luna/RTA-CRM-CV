import 'package:flutter/material.dart';

class FailedToastJA extends StatelessWidget {
  const FailedToastJA({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
        // border: Border.all(
        //   color: Colors.redAccent,
        //   width: 2,
        // ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.close,
            color: Colors.white,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            message,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
