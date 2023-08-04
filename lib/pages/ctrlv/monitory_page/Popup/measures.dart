import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/captura/thousands_separator_input_formatter.dart';

import '../../../../models/monitory.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';
import '../../../../widgets/card_header.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class MeasuresPopUp extends StatelessWidget {
  final Monitory row;
  final int popUp;
  const MeasuresPopUp({super.key, required this.row, required this.popUp});

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 700,
        height: 650,
        decoration: BoxDecoration(gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
        child: 
        Column(
          children: [
            const CardHeader(text: "Measures"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20,top:20),
                  alignment: Alignment.centerLeft,
                  child: CustomTextIconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      text: "",
                      isLoading: false,
                      onTap: () {
                        provider.updateViewPopup(0);
                      },
                    ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height *.5,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: provider.actualIssuesComments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 250,
                            // color: Colors.red,
                            child: Text(
                              provider.actualIssuesComments[index].nameIssue.capitalize.replaceAll("_", ' '),
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            //color: Colors.yellow,
                            //alignment: Alignment.center,
                            child: Text(
                              provider.actualIssuesComments[index].nameIssue == "mileage" ? NumberFormat('#,###').format(provider.actualIssuesComments[index].mileage) : "${provider.actualIssuesComments[index].measure}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          InkWell(
                          child: 
                            Icon(Icons.remove_red_eye,
                                size: 30,
                                color: Color.fromARGB(200, 65, 155, 23)),
                          onTap: () {
                            provider.getActualDetailField(provider.actualIssuesComments[index]);
                            // provider.getSection(index);
                            provider.updateViewPopup(11);
                            provider.updatePopUpExtra(popUp);
                          },
                          
                        ),
                        ],
                      ),
                    );
                  }),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       const Text(
            //         "Mileage",
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //       ),
            //       Text(
            //         row.mileageR.toString(),
            //         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //       ),
                 
            //       InkWell(
            //         child: Icon(
            //           Icons.remove_red_eye,
            //           color: Color.fromARGB(200, 65, 155, 23),
            //           size: 40,
            //         ),
            //         onTap: () {
            //           provider.getActualDetailField(provider.measureR[3]);
            //           provider.updateViewPopup(11);
            //         },
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       const Text(
            //         "Gas/Diesel %",
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //       ),
            //       Text(
            //         row.gasR.toString(),
            //         style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //       ),
                  
            //       InkWell(
            //         child: Icon(
            //           Icons.remove_red_eye,
            //           color: Color.fromARGB(200, 65, 155, 23),
            //           size: 40,
            //         ),
            //         onTap: () {
            //           //provider.getActualDetailField(provider.actualIssuesComments[0]);
            //           provider.updateViewPopup(11);
            //         },
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
