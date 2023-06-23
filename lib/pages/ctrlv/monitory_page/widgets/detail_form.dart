import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/monitory_provider.dart';

import '../../../../models/issues_comments.dart';
import '../../../../public/colors.dart';

class DetailControlForm extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool state;
  final int index;
  final MonitoryProvider provider;
  final List<IssuesComments> list;

  const DetailControlForm(
      {super.key,
      required this.title,
      required this.icon,
      required this.state, 
      required this.index, required this.provider, required this.list});

  @override
  Widget build(BuildContext context) {

    return Tooltip(
      message: 
      title == "B. Inspection" ? "Bucket Inspection" : title == "C. Bodywork" ? "Car Bodywork" : title,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            height: 60,
            decoration: BoxDecoration(
                gradient: whiteGradient,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 0.1,
                    blurRadius: 3,
                    offset: const Offset(3, 3), // changes position of shadow
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                  child: Icon(icon, color: Colors.black),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      state
                          ? Text(
                              "Good",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(200, 65, 155, 23)),
                            )
                          : Text(
                              "Bad",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(200, 210, 0, 48)),
                            ),
                      state
                          ? Icon(Icons.check_circle_outline_outlined,
                              color: Color.fromARGB(200, 65, 155, 23))
                          : Icon(Icons.cancel_outlined,
                              color: Color.fromARGB(200, 210, 0, 48))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Icon(Icons.remove_red_eye_outlined,
                            color: Colors.black),
                        onTap: () {
                          provider.getActualIssuesComments(list);
                          provider.updateViewPopup(index);
                          
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
