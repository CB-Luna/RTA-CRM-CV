import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/public/colors.dart';

import '../../../../models/issues_comments.dart';
import '../../../../providers/ctrlv/inventory_provider.dart';

class ListIssuesCard extends StatefulWidget {
  final List<IssuesComments> issuesComments;
  final List<IssuesComments> issuesCommentsD;
  final int index;
  const ListIssuesCard(
      {super.key,
      required this.issuesComments,
      required this.index,
      required this.issuesCommentsD});

  @override
  State<ListIssuesCard> createState() => _ListIssuesCardState();
}

class _ListIssuesCardState extends State<ListIssuesCard> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    return SizedBox(
        height: 400,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(10.0),
                alignment: Alignment.centerLeft,
                // Este issue es el nombre
                child: Row(
                  children: [
                    const Text(
                      "Section: ",
                    ),
                    Text(
                      provider.titulosIssue[widget.index],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            Container(
              height: 161,
              width: 850,
              child: ListView(
                children: [
                  Container(
                    //color: Colors.orange,
                    height: 120,
                    width: 850,
                    child: ListView.builder(
                      itemCount: widget.issuesComments.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 200,
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: [
                                    Text(
                                      "•${widget.issuesComments[index].nameIssue.capitalize.replaceAll("_", " ")}",
                                      style:
                                          const TextStyle(color: Colors.orange),
                                    ),
                                    // Text(
                                    //   "•${widget.issuesCommentsD[index].nameIssue.capitalize.replaceAll("_", " ")}",
                                    //   style: TextStyle(color: Colors.green),
                                    // ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    const Text(
                                      "Date: ",
                                    ),
                                    Text(
                                      DateFormat("MMM/dd/yyyy hh:mm:ss").format(
                                          widget
                                              .issuesComments[index].dateAdded),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                  onPressed: () {
                                    provider.selectIssuesComments(
                                        widget.issuesComments[index]);
                                    provider.cambiosVistaPhotosComments();
                                    provider.setIssueViewActual(2);
                                  },
                                  child:
                                      const Icon(Icons.remove_red_eye_outlined))
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  // Container(
                  //   height: 10,
                  //   decoration: BoxDecoration(gradient: whiteGradient),
                  // ),
                  Container(
                    //color: const Color(0XFF25A531),
                    height: 120,
                    width: 850,
                    child: ListView.builder(
                      itemCount: widget.issuesCommentsD.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 200,
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  children: [
                                    // Text(
                                    //     "•${widget.issuesComments[index].nameIssue.capitalize.replaceAll("_", " ")}"),
                                    Text(
                                      "•${widget.issuesCommentsD[index].nameIssue.capitalize.replaceAll("_", " ")}",
                                      style: const TextStyle(
                                          color: Color(0XFF25A531)),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    const Text(
                                      "Date: ",
                                    ),
                                    Text(
                                      DateFormat("MMM/dd/yyyy hh:mm:ss").format(
                                          widget.issuesCommentsD[index]
                                              .dateAdded),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton(
                                  onPressed: () {
                                    provider.selectIssuesComments(
                                        widget.issuesCommentsD[index]);
                                    provider.cambiosVistaPhotosComments();
                                    provider.setIssueViewActual(2);
                                  },
                                  child:
                                      const Icon(Icons.remove_red_eye_outlined))
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
