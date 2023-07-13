import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/providers.dart';

import '../../../../public/colors.dart';
import '../../../models/user.dart';

class DeletePopUp extends StatefulWidget {
  final User users;
  const DeletePopUp({super.key, required this.users});

  @override
  State<DeletePopUp> createState() => _DeletePopUpState();
}

class _DeletePopUpState extends State<DeletePopUp> {
  @override
  Widget build(BuildContext context) {
    UsersProvider provider = Provider.of<UsersProvider>(context);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(gradient: whiteGradient, boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(10, 10))], borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      " ¿Are you sure you want to Delete?",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          " User: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(" ${widget.users.name} "),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          " User ID: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(" ${widget.users.sequentialId}"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ElevatedButton(
                  onPressed: () {
                    provider.deleteUser(widget.users);
                    print("Entro aqui");
                    print("ID DEL Usuario: ${widget.users.sequentialId}");
                    provider.updateState();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: secondaryColor, elevation: 20, shadowColor: secondaryColor),
                  child: const Text(
                    "ACCEPT",
                    style: TextStyle(fontSize: 20),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, elevation: 20, shadowColor: Colors.blue),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(fontSize: 20),
                  ))
            ]),
          ],
        ),
      ),
    );
  }
}
