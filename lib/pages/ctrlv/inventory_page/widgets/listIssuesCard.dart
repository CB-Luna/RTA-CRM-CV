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
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Issue 1"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text("Date:  23/JUN/2023"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                          onPressed: () {
                            provider.cambiosVistaPhotosComments();
                          },
                          child: const Icon(Icons.remove_red_eye_outlined)),
                    )
                    // Container(
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Issue 2"),
                    ),
                    const Text("Date:  23/JUN/2023"),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            provider.cambiosVistaPhotosComments();
                          },
                          child: const Icon(Icons.remove_red_eye_outlined)),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ));
  }
}
