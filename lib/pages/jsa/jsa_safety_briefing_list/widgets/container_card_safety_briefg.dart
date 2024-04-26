// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_safety_briefing_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import '../../../../theme/theme.dart';
import 'pdf_popup_safety_briefing.dart';
import 'plutogrid_safety_briefing.dart';

class ContainerCardJSASafety extends StatefulWidget {
  final int index;
  bool isExpanded;

  ContainerCardJSASafety(
      {required this.index, required this.isExpanded, super.key});

  @override
  State<ContainerCardJSASafety> createState() => _ContainerCardJSASafetyState();
}

class _ContainerCardJSASafetyState extends State<ContainerCardJSASafety> {
  @override
  Widget build(BuildContext context) {
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);

    return Container(
      // height: MediaQuery.of(context).size.height * 0.07,
      // width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          gradient: whiteGradient,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey)),
      child: SizedBox(
        child: ExpansionPanelList(
          expandedHeaderPadding: EdgeInsets.zero,
          elevation: 0,
          children: [
            ExpansionPanel(
              canTapOnHeader: true,
              backgroundColor: Colors.transparent,
              headerBuilder: (context, expanded) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 120,
                        alignment: Alignment.center,
                        child: Text(
                          '${provider.listSafety[widget.index].id}',
                          style: AppTheme.of(context).title2.override(
                              fontFamily: AppTheme.of(context).title3Family,
                              useGoogleFonts: false,
                              color: AppTheme.of(context).primaryText,
                              fontSize: 20),
                        ),
                      ),
                      Visibility(
                        visible: !widget.isExpanded,
                        child: Container(
                          width: 150,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.only(left: 50),
                          child: Text(
                            provider.listSafety[widget.index].preparedBy,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.of(context).title3.override(
                                fontFamily: AppTheme.of(context).title3Family,
                                useGoogleFonts: false,
                                color: AppTheme.of(context).primaryText,
                                fontSize: 20),
                          ),
                        ),
                      ),

                      Container(
                        width: 130,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(left: 50),
                        child: Visibility(
                          visible: !widget.isExpanded,
                          child: Text(
                            provider.listSafety[widget.index].title,
                            style: AppTheme.of(context).title3.override(
                                fontFamily: AppTheme.of(context).title3Family,
                                useGoogleFonts: false,
                                color: AppTheme.of(context).primaryText,
                                fontSize: 20),
                          ),
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 120,
                              margin: const EdgeInsets.only(left: 50),
                              decoration: BoxDecoration(
                                color: statusColor(
                                    provider
                                        .listSafety[widget.index].status.name,
                                    context),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    provider
                                        .listSafety[widget.index].status.name,
                                    style: AppTheme.of(context).title3.override(
                                        fontFamily:
                                            AppTheme.of(context).title3Family,
                                        useGoogleFonts: false,
                                        color: AppTheme.of(context)
                                            .primaryBackground,
                                        fontSize: 20),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      Visibility(
                        visible: widget.isExpanded,
                        child: InkWell(
                          onTap: () async {
                            await provider.pickDocument(
                                provider.listSafety[widget.index].docName);
                            await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return PdfPopUpSafetyBriefing(
                                    name: provider
                                        .listSafety[widget.index].docName);
                              },
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.12,
                            height: MediaQuery.of(context).size.height * 0.04,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).cryPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Preview Document',
                              style: AppTheme.of(context).bodyText2.override(
                                    fontFamily:
                                        AppTheme.of(context).title3Family,
                                    useGoogleFonts: false,
                                    color:
                                        AppTheme.of(context).primaryBackground,
                                  ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !widget.isExpanded,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.menu,
                              color: AppTheme.of(context).primaryText,
                            ),
                            Text(
                              'Preview',
                              style: AppTheme.of(context).title3.override(
                                  fontFamily: AppTheme.of(context).title3Family,
                                  useGoogleFonts: false,
                                  color: AppTheme.of(context).primaryText,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      //const SizedBox(width: 65),
                    ],
                  ),
                );
              },
              body: SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      //horizontal: 24,
                      vertical: 6,
                    ),
                    child: PlutoGridSafetyBriefing(
                      iDJSA: provider.listSafety[widget.index].id,
                    )),
              ),
              isExpanded: widget.isExpanded,
              // isExpanded: provider.istaped,
            ),
          ],
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              widget.isExpanded = !widget.isExpanded;
              provider.getInformationSafety(widget.index);
            });
          },
        ),
      ),
    );
  }
}

Color statusColor(String? status, BuildContext context) {
  late Color color;

  switch (status) {
    case "Pending": // Pending
      color = AppTheme.of(context).employeePrimary;
      break;
    case "Completed": //Sen. Exec. Validate
      color = Colors.green;
      break;
    case "Draft": //Finance Validate
      color = AppTheme.of(context).secondaryColor;
      break;

    default:
      return Colors.black;
  }
  return color;
}
