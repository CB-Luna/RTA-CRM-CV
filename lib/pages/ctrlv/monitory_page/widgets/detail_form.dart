import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/Popup/measures.dart';

import '../../../../public/colors.dart';

class DetailControlForm extends StatelessWidget {
  const DetailControlForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      child:  Column(
        children: [
          Row(
            children: [
              Icon(Icons.access_alarm, color: Colors.black),
              Column(
                children: [
                  Text(
                    "Good",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(200, 65, 155, 23)),
                  ),
                  Icon(Icons.check_circle_outline_outlined,
                      color: Color.fromARGB(200, 65, 155, 23)),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                child: Icon(Icons.remove_red_eye_outlined, color: Colors.black),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return const MeasuresPopUp();
                        });
                      });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
