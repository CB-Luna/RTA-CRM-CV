import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

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
      content: CustomCard(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.5,
        title: 'Delete User',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.03,
              alignment: Alignment.centerLeft,
              child: CustomTextIconButton(
                isLoading: false,
                icon: Icon(Icons.arrow_back_outlined,
                    color: AppTheme.of(context).primaryBackground),
                text: '',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
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
                        child: Text(
                            " ${widget.users.name} ${widget.users.lastName} "),
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
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.03,
                      decoration: BoxDecoration(
                        color: statusColor(widget.users.company.company),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          widget.users.company.company,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              CustomTextIconButton(
                width: 96,
                isLoading: false,
                icon: Icon(Icons.dangerous_outlined,
                    color: AppTheme.of(context).primaryBackground),
                text: 'Delete',
                color: AppTheme.of(context).secondaryColor,
                onTap: () async {
                  context.pop();
                  provider.deleteUser(widget.users);
                  provider.updateState();
                },
              ),
              CustomTextIconButton(
                width: 101,
                isLoading: false,
                icon: Icon(Icons.archive_outlined,
                    color: AppTheme.of(context).primaryBackground),
                text: 'Archive',
                color: AppTheme.of(context).primaryColor,
                onTap: () async {
                  context.pop();
                  provider.changeStatusUser(widget.users);
                  provider.updateState();
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

Color statusColor(String status) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = const Color(0XFFB2333A);
      break;
    case "SMI": //Sen. Exec. Validate
      color = const Color.fromRGBO(255, 138, 0, 1);
      break;
    case "CRY": //Finance Validate
      color = const Color(0XFF345694);
      break;

    default:
      return Colors.black;
  }
  return color;
}
