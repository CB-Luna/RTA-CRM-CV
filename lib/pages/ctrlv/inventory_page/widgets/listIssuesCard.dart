import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/inventory_provider.dart';

class ListIssuesCard extends StatefulWidget {
  final String TextoPrueba;
  const ListIssuesCard({super.key, required this.TextoPrueba});

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
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.centerLeft,
            child: Text(
              "Issue: ${widget.TextoPrueba}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Issue 1"),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Issue 2"),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              height: 100,
              width: 100,
              color: Colors.green,
            )
          ],
        ),
      ],
    ));
  }
}
