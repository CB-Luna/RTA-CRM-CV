import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';

import '../../../../models/issues.dart';
import '../../../../models/issues_x_user.dart';
import '../../../../models/vehicle.dart';
import '../../../../providers/users_provider.dart';
import '../../../../widgets/get_image_widget.dart';
import '../pop_up/reported_issues_pop_up.dart';

class EmployeeIssuesCard extends StatefulWidget {
  final IssuesXUser issueXUser;

  const EmployeeIssuesCard({
    super.key,
    required this.issueXUser,
  });

  @override
  State<EmployeeIssuesCard> createState() => _EmployeeIssuesCardState();
}

class _EmployeeIssuesCardState extends State<EmployeeIssuesCard> {
  @override
  Widget build(BuildContext context) {
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    //provider.issuesxUser.clear();

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 50,
            height: 50,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: getUserImage(provider.webImage),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.0, top: 5.0),
                child: Text(
                    "Nombre: ${widget.issueXUser.name} ${widget.issueXUser.lastName}"),
              ),
              Text("Empresa: ${widget.issueXUser.company} "),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                provider.getIssues(widget.issueXUser);
                provider.cambioVistaIssues();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
              ),
              child: Text(
                  "${widget.issueXUser.issuesR + widget.issueXUser.issuesD}")),
        ],
      ),
    );
  }
}
