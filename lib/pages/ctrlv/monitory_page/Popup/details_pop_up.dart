import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/monitory_page/Popup/parts.dart';

import '../../../../models/monitory.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import '../widgets/detail_card_vehicle.dart';
import '../widgets/forms_answer_delivered.dart';
import '../widgets/forms_answer_received.dart';
import 'bucket_expanded.dart';
import 'comments_images_issues.dart';
import 'extra_parts.dart';
import 'measures.dart';
import 'package:rta_crm_cv/widgets/card_header.dart';

import 'measures_inspect.dart';

class DetailsPop extends StatelessWidget {
  final Monitory vehicle;
  const DetailsPop({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    return AlertDialog(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      content: provider.viewPopup == 0
          ? Container(
              width: 1300,
              height: 760,
              decoration: BoxDecoration(gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CardHeader(
                      text: 'DETAILS',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: CustomTextIconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              text: "",
                              isLoading: false,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )),
                      ],
                    ),
                  ),
                  DetailVehicleCard(vehicle: vehicle),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Container(
                                height: MediaQuery.of(context).size.height * 0.03,
                                width: MediaQuery.of(context).size.width * 0.07,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color.fromRGBO(171, 235, 198, 1),
                                  border: Border.all(color: AppTheme.lightTheme.tertiaryColor, width: 3),
                                ),
                                child: Center(
                                  child: Text(
                                    "Check Out",
                                    style: TextStyle(color: AppTheme.lightTheme.tertiaryColor, fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ]),
                        ),
                        const AnswerFormReceived(),
                        const SizedBox(
                          height: 10,
                        ),
                        vehicle.dateAddedD != null
                            ? Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                      Container(
                                        height: MediaQuery.of(context).size.height * 0.03,
                                        width: MediaQuery.of(context).size.width * 0.07,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: const Color.fromRGBO(195, 155, 211, 1),
                                          border: Border.all(color: const Color.fromRGBO(245, 6, 213, 1), width: 2),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Check In",
                                            style: TextStyle(color: Color.fromRGBO(245, 6, 213, 1), fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  const AnswerFormDelivered(),
                                ],
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  gradient: blueRadial,
                                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                                ),
                              ),
                      ],
                    ),
                  )
                ],
              ),
            )
          :
          //cambio de PopUp
          //Id enviarle el de control form para tomar todos los datos de las diferntes tablas.
          provider.viewPopup == 1
              ? MeasuresPopUp(row: vehicle, popUp: 1)
              : provider.viewPopup == 2
                  ? const ExtraPopUp(catalog: "Lights", popUp: 2)
                  : provider.viewPopup == 3
                      ? const ExtraPopUp(catalog: "Car Bodywork", popUp: 3)
                      : provider.viewPopup == 4
                          ? const ExtraPopUp(catalog: "Fluid Check", popUp: 4)
                          : provider.viewPopup == 5
                              ? const BucketExtraPopUp(popUp: 5)
                              : provider.viewPopup == 6
                                  ? const ExtraPopUp(catalog: "Security", popUp: 6)
                                  : provider.viewPopup == 7
                                      ? const ExtraPopUp(catalog: "Extra", popUp: 7)
                                      : provider.viewPopup == 8
                                          ? const ExtraPopUp(catalog: "Equipment", popUp: 8)
                                          : provider.viewPopup == 9
                                              ? CommentsImagesIssues(popUp: provider.popUpExtra)
                                              : provider.viewPopup == 10
                                                  ? const BucketCommentsImagesIssues()
                                                  : provider.viewPopup == 11
                                                      ? const MeasuresInspect()
                                                      : Container(),
    );
  }
}
