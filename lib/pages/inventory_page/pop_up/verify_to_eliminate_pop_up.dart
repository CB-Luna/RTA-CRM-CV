import 'package:flutter/material.dart';

class DeletePopUp extends StatefulWidget {
  const DeletePopUp({super.key});

  @override
  State<DeletePopUp> createState() => _DeletePopUpState();
}

class _DeletePopUpState extends State<DeletePopUp> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            color: Colors.red,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(children: [
          ElevatedButton(onPressed: () {}, child: const Text("ACCEPT")),
          ElevatedButton(onPressed: () {}, child: const Text("CANCEL"))
        ]),
      ),
    );
  }
}
