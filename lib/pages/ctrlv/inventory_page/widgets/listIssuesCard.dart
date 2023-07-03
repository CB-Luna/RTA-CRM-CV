import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../models/issues_open_close.dart';
import '../../../../providers/ctrlv/inventory_provider.dart';
import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';

class ListIssuesCard extends StatefulWidget {
  final List<IssueOpenclose> issuesComments;
  const ListIssuesCard({super.key, required this.issuesComments});

  @override
  State<ListIssuesCard> createState() => _ListIssuesCardState();
}

class _ListIssuesCardState extends State<ListIssuesCard> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    provider.getIssuesCarBodywork(provider.actualIssueXUser!);

    return Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
          ],
        ),
        height: 200,
        width: 850,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.centerLeft,
                // Este issue es el nombre
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(children: [
                        Text(
                          "Name Issue",
                          style: TextStyle(
                              color: AppTheme.of(context).contenidoTablas.color,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                        Text(
                          "Issue Open",
                          style: TextStyle(
                              color: AppTheme.of(context).contenidoTablas.color,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 120,
                        ),
                        Text(
                          "Issue Close",
                          style: TextStyle(
                              color: AppTheme.of(context).contenidoTablas.color,
                              fontFamily: 'Bicyclette-Thin',
                              fontSize:
                                  AppTheme.of(context).contenidoTablas.fontSize,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                    )
                  ],
                )),
            SizedBox(
              height: 154,
              width: 850,
              child: ListView(
                children: [
                  SizedBox(
                    //color: Colors.orange,
                    height: 120,
                    width: 600,
                    child: ListView.builder(
                      itemCount: widget.issuesComments.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 140.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                width: 150,
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "•${widget.issuesComments[index].nameIssue.capitalize.replaceAll("_", " ")}",
                                      style: TextStyle(
                                        color: Colors.orange,
                                        fontFamily: 'Bicyclette-Thin',
                                        fontSize: AppTheme.of(context)
                                            .contenidoTablas
                                            .fontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Text(
                                      DateFormat("MMM/dd/yyyy hh:mm:ss").format(
                                          widget.issuesComments[index]
                                              .dateAddedOpen),
                                      style: TextStyle(
                                        color: AppTheme.of(context)
                                            .contenidoTablas
                                            .color,
                                        fontFamily: 'Bicyclette-Thin',
                                        fontSize: AppTheme.of(context)
                                            .contenidoTablas
                                            .fontSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTextIconButton(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  width: 80,
                                  isLoading: false,
                                  icon: Icon(Icons.remove_red_eye_outlined,
                                      color: AppTheme.of(context)
                                          .primaryBackground),
                                  text: '',
                                  color: AppTheme.of(context).primaryColor,
                                  onTap: () async {
                                    // provider.selectIssuesComments(
                                    //     widget.issuesComments[index]);
                                    provider.cambiosVistaPhotosComments();
                                    provider.setIssueViewActual(2);
                                  },
                                ),
                              ),
                              // ElevatedButton(
                              //     onPressed: () {
                              //       provider.selectIssuesComments(
                              //           widget.issuesComments[index]);
                              //       provider.cambiosVistaPhotosComments();
                              //       provider.setIssueViewActual(2);
                              //     },
                              //     child:
                              //         const Icon(Icons.remove_red_eye_outlined))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
