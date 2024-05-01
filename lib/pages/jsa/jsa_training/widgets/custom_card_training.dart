import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_training.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/captura/custom_text_field.dart';
import '../../../../widgets/custom_card.dart';

class CustomCardTraining extends StatefulWidget {
  const CustomCardTraining({super.key});

  @override
  State<CustomCardTraining> createState() => _CustomCardTrainingState();
}

class _CustomCardTrainingState extends State<CustomCardTraining> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final JsaTraining provider = Provider.of<JsaTraining>(
        context,
        listen: false,
      );
      // await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    JsaTraining provider = Provider.of<JsaTraining>(context);

    // provider.listJSA.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    // provider.listJSA.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));

    // JsaProvider jsaProvider = Provider.of<JsaProvider>(context);
    return CustomCard(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        title: "Training List",
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Container(
                width: double.infinity,
                //                 height: MediaQuery.of(context).size.height * 0.15,
                height: MediaQuery.of(context).size.height * 0.13,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xffB6D0FD)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 60,
                                child: CustomTextIconButton(
                                  color: Colors.white,
                                  isLoading: false,
                                  icon: Icon(Icons.filter_alt_outlined,
                                      color: AppTheme.of(context).primaryText),
                                  text: ' ',
                                  // onTap: () => provider.stateManager!.setShowColumnFilter(!provider.stateManager!.showColumnFilter),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: CustomTextField(
                                  height: 35,
                                  width: 500,
                                  enabled: true,
                                  controller: provider.searchController,
                                  icon: Icons.search,
                                  label: 'Search',
                                  keyboardType: TextInputType.text,
                                  onChanged: (String query) async {
                                    // provider.filterDocuments(query);
                                    // provider.updateState();
                                  },
                                ),
                              ),
                              CustomTextIconButton(
                                width: 225,
                                isLoading: false,
                                icon: Icon(Icons.add_outlined,
                                    color:
                                        AppTheme.of(context).primaryBackground),
                                text: 'Add Training',
                                color: AppTheme.of(context).primaryColor,
                                onTap: () async {
                                  // jsaProvider.titleController.clear();
                                  // jsaProvider.taskController.clear();
                                  // jsaProvider.searchController.clear();
                                  // jsaProvider.setButtonViewTaped(0);
                                  // jsaProvider.setIcons(0);
                                  // context.pushReplacement(routeJSACreation);
                                },
                              ),
                            ],
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 30,
                                color: AppTheme.of(context).primaryText,
                              ),
                              Text(
                                'ID',
                                style: AppTheme.of(context).title2.override(
                                    fontFamily:
                                        AppTheme.of(context).title3Family,
                                    useGoogleFonts: false,
                                    color: AppTheme.of(context).primaryText,
                                    fontSize: 22),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.document_scanner_outlined,
                                size: 30,
                                color: AppTheme.of(context).primaryText,
                              ),
                              Text(
                                'Employee',
                                style: AppTheme.of(context).title3.override(
                                    fontFamily:
                                        AppTheme.of(context).title3Family,
                                    useGoogleFonts: false,
                                    color: AppTheme.of(context).primaryText,
                                    fontSize: 22),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.work_outlined,
                                size: 30,
                                color: AppTheme.of(context).primaryText,
                              ),
                              Text(
                                'No. Trainings',
                                style: AppTheme.of(context).title3.override(
                                    fontFamily:
                                        AppTheme.of(context).title3Family,
                                    useGoogleFonts: false,
                                    color: AppTheme.of(context).primaryText,
                                    fontSize: 22),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.sell_outlined,
                                size: 30,
                                color: AppTheme.of(context).primaryText,
                              ),
                              Text(
                                'Rol',
                                style: AppTheme.of(context).title3.override(
                                    fontFamily:
                                        AppTheme.of(context).title3Family,
                                    useGoogleFonts: false,
                                    color: AppTheme.of(context).primaryText,
                                    fontSize: 22),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.credit_card_outlined,
                                color: AppTheme.of(context).primaryText,
                                size: 30,
                              ),
                              Text(
                                'Company',
                                style: AppTheme.of(context).title3.override(
                                    fontFamily:
                                        AppTheme.of(context).title3Family,
                                    useGoogleFonts: false,
                                    color: AppTheme.of(context).primaryText,
                                    fontSize: 22),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.50,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext ctx, index) {
                  return Container(
                    color: Colors.red,
                    height: 50,
                    width: 50,
                  );
                  // return ContainerCardJSASafety(
                  //     index: index, isExpanded: false);
                },
              ),
            )
          ],
        ));
  }
}
