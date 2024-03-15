// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/public/colors.dart';

import '../../../../providers/jsa/jsa_document_list_provider.dart';
import '../../../../theme/theme.dart';
import 'plutogrid_document_list.dart';

class ContainerCardJSA extends StatefulWidget {
  final int index;
  bool isExpanded;

  ContainerCardJSA({required this.index, required this.isExpanded, super.key});

  @override
  State<ContainerCardJSA> createState() => _ContainerCardJSAState();
}

class _ContainerCardJSAState extends State<ContainerCardJSA> {
  @override
  Widget build(BuildContext context) {
    JSADocumentListProvider provider =
        Provider.of<JSADocumentListProvider>(context);

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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 100,
                        alignment: Alignment.center,
                        child: Text(
                          '${provider.listJSA[widget.index].id}',
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
                          width: 130,
                          alignment: Alignment.center,
                          child: Text(
                            '${provider.listJSA[widget.index].employee!.name}\n${provider.listJSA[widget.index].employee!.lastName}',
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
                        child: Visibility(
                          visible: !widget.isExpanded,
                          child: Text(
                            '${provider.listJSA[widget.index].docName}',
                            style: AppTheme.of(context).title3.override(
                                fontFamily: AppTheme.of(context).title3Family,
                                useGoogleFonts: false,
                                color: AppTheme.of(context).primaryText,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        alignment: Alignment.center,
                        child: Visibility(
                          visible: !widget.isExpanded,
                          child: Text(
                            '${provider.listJSA[widget.index].usersjsa.length}',
                            style: AppTheme.of(context).title3.override(
                                fontFamily: AppTheme.of(context).title3Family,
                                useGoogleFonts: false,
                                color: AppTheme.of(context).primaryText,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        margin: const EdgeInsets.only(left: 60),
                        child: Visibility(
                          visible: !widget.isExpanded,
                          child: Text(
                            DateFormat("MMM/dd/yyyy").format(
                                provider.listJSA[widget.index].createdAt!),
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
                          Visibility(
                            visible: !widget.isExpanded,
                            child: Text(
                              DateFormat("MMM/dd/yyyy").format(
                                  provider.listJSA[widget.index].createdAt!),
                              style: AppTheme.of(context).title3.override(
                                  fontFamily: AppTheme.of(context).title3Family,
                                  useGoogleFonts: false,
                                  color: AppTheme.of(context).primaryText,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: widget.isExpanded,
                        child: Container(
                          width: 120,
                          alignment: Alignment.center,
                          child: Text(
                            'Signed By:     ${provider.signedUsers}/ ${provider.listJSA[widget.index].usersjsa.length}',
                            style: AppTheme.of(context).bodyText2.override(
                                  fontFamily: AppTheme.of(context).title3Family,
                                  useGoogleFonts: false,
                                  color: AppTheme.of(context).primaryText,
                                ),
                          ),
                        ),
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 120,
                              decoration: BoxDecoration(
                                color: statusColor(
                                    provider.listJSA[widget.index].status,
                                    context),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    '${provider.listJSA[widget.index].status}',
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
              body: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      //horizontal: 24,
                      vertical: 6,
                    ),
                    child: PlutoGridDocumentList(
                      iDJSA: provider.listJSA[widget.index].id ?? 0,
                    )),
              ),
              isExpanded: widget.isExpanded,
              // isExpanded: provider.istaped,
            ),
          ],
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              widget.isExpanded = !widget.isExpanded;
              provider.getInformationJSA(widget.index);
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
    case "Signed": //Sen. Exec. Validate
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
