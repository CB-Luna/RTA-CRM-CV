import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/vehicle.dart';
import '../../../providers/inventory_provider.dart';
import '../../../public/colors.dart';

class DeletePopUp extends StatefulWidget {
  final Vehicle vehicle;
  const DeletePopUp({super.key, required this.vehicle});

  @override
  State<DeletePopUp> createState() => _DeletePopUpState();
}

class _DeletePopUpState extends State<DeletePopUp> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(" Are you sure you want to Delete?"),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                  onPressed: () {
                    provider.deleteVehicle(widget.vehicle);
                    print("Entro aqui");
                    print("ID DEL VEHICULO: ${widget.vehicle.idVehicle}");
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: secondaryColor),
                  child: const Text("ACCEPT")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("CANCEL"))
            ]),
          ],
        ),
      ),
    );
  }
}
