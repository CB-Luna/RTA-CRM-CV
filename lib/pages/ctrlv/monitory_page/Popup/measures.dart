import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      text: "",
                      isLoading: false,
                      onTap: () {
                        provider.updateViewPopup(0);
                      },
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.03,
                    decoration: BoxDecoration(
                      color: statusColor(
                          provider.monitoryActual!.vehicle.company.company),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        provider.monitoryActual!.vehicle.licesensePlates,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
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
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          InkWell(
                          child: 
                            const Icon(Icons.remove_red_eye,
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
            
          ],
        ),
      ),
    );
  }
}

Color statusColor(String status) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = const Color(0XFFB2333A);
      break;
    case "SMI": //Sen. Exec. Validate
      color = const Color.fromRGBO(255, 138, 0, 1);
      break;
    case "CRY": //Finance Validate
      color = const Color(0XFF345694);
      break;

    default:
      return Colors.black;
  }
  return color;
}

