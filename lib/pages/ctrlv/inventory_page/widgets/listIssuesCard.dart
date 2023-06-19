import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../models/issues_comments.dart';
import '../../../../providers/ctrlv/inventory_provider.dart';

class ListIssuesCard extends StatefulWidget {
  final List<IssuesComments> issuesComments;
  final int index;
  const ListIssuesCard(
      {super.key, required this.issuesComments, required this.index});

  @override
  State<ListIssuesCard> createState() => _ListIssuesCardState();
}

class _ListIssuesCardState extends State<ListIssuesCard> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    return SizedBox(
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
        SizedBox(
          height: 120,
          width: 450,
          child: ListView.builder(
            itemCount: widget.issuesComments.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(widget
                          .issuesComments[index].nameIssue.capitalize
                          .replaceAll("_", " ")),
                    ),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        " Date: ${DateFormat("MMM/dd/yyyy hh:mm:ss").format(widget.issuesComments[index].dateAdded)}",
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          provider.selectIssuesComments(
                              widget.issuesComments[index]);
                          provider.cambiosVistaPhotosComments();
                        },
                        child: const Icon(Icons.remove_red_eye_outlined))
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}
