import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';
import '../../../../widgets/card_header.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class ExtraPopUp extends StatelessWidget {
  final String catalog;
  final int popUp;
  const ExtraPopUp({
    super.key,
    required this.catalog, required this.popUp,
  });
  //pedir ID de control form para conectar con als demas

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 700,
        height: 750,
        decoration: BoxDecoration(gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            CardHeader(text: catalog),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: CustomTextIconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      text: "",
                      isLoading: false,
                      onTap: () {
                        provider.updateViewPopup(0);
                      },),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right:15.0),
                    child: Container(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: MediaQuery.of(context).size.height * 0.03,
                    decoration: BoxDecoration(
                      color: statusColor(provider.monitoryActual!.vehicle.company.company),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        provider.monitoryActual!.vehicle.licesensePlates,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                                  ),
                  ),
                ],
              ),
            ),
            
            SizedBox(
              height: 550,
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
                              provider.actualIssuesComments[index].status ? "Good" : "Bad",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: provider.actualIssuesComments[index].status ? const Color.fromARGB(200, 65, 155, 23) : const Color.fromARGB(200, 210, 0, 48),
                              ),
                            ),
                          ),
                          InkWell(
                          child: provider.actualIssuesComments[index].status
                            ? Icon(Icons.remove_red_eye,
                                size: 30,
                                color: Color.fromARGB(200, 65, 155, 23))
                            : Icon(Icons.remove_red_eye,
                              size: 30,
                                color: Color.fromARGB(200, 210, 0, 48)),
                          onTap: () {
                            provider.getActualDetailField(provider.actualIssuesComments[index]);
                            // provider.getSection(index);
                            provider.updateViewPopup(9);
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

