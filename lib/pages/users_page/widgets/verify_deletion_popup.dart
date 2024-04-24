import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/success_toast.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

import '../../../helpers/constants.dart';
import '../../../models/company.dart';
import '../../../models/user.dart';

class DeletePopUp extends StatefulWidget {
  final User user;
  const DeletePopUp({super.key, required this.user});

  @override
  State<DeletePopUp> createState() => _DeletePopUpState();
}

class _DeletePopUpState extends State<DeletePopUp> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);

    UsersProvider provider = Provider.of<UsersProvider>(context);
    List<String> companies = [];
    for (var company in widget.user.companies) {
      companies.add(company.company);
    }
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.5,
        title: 'Delete User',
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: CustomTextIconButton(
                width: MediaQuery.of(context).size.width * 0.04,
                isLoading: false,
                icon: Icon(Icons.arrow_back_outlined, color: AppTheme.of(context).primaryBackground),
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
                        child: Text(" ${widget.user.name} ${widget.user.lastName} "),
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
                        child: Text(" ${widget.user.sequentialId}"),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.user.companies.length,
                        itemBuilder: (context, index) {
                          Company currentCompany = widget.user.companies[index];
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.04,
                            height: rowHeight,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                            decoration: BoxDecoration(
                              color: statusColor(currentCompany.company, context),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              currentCompany.company,
                              style: AppTheme.of(context).contenidoTablas.override(
                                    fontFamily: 'Gotham-Regular',
                                    useGoogleFonts: false,
                                    color: AppTheme.of(context).primaryBackground,
                                  ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomTextIconButton(
                  width: 96,
                  isLoading: false,
                  icon: Icon(Icons.dangerous_outlined, color: AppTheme.of(context).primaryBackground),
                  text: 'Delete',
                  color: AppTheme.of(context).secondaryColor,
                  onTap: () async {
                    if (!mounted) return;
                    fToast.showToast(
                      child: const SuccessToast(
                        message: 'User Deleted',
                      ),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: const Duration(seconds: 2),
                    );
                    context.pop();
                    provider.deleteUser(widget.user);
                    //provider.deleteUser(widget.users);
                    provider.updateState();
                  },
                ),
                CustomTextIconButton(
                  width: 101,
                  isLoading: false,
                  icon: Icon(Icons.archive_outlined, color: AppTheme.of(context).primaryBackground),
                  text: 'Archive',
                  color: AppTheme.of(context).primaryColor,
                  onTap: () async {
                    if (!mounted) return;
                    fToast.showToast(
                      child: const SuccessToast(
                        message: 'The user has been successfully archived',
                      ),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: const Duration(seconds: 2),
                    );
                    provider.changeStatusUser(widget.user);
                    provider.updateState();
                    context.pop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Color statusColor(String status, BuildContext context) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = AppTheme.of(context).odePrimary;
      break;
    case "SMI": //Sen. Exec. Validate
      color = AppTheme.of(context).smiPrimary;
      break;
    case "CRY": //Finance Validate
      color = AppTheme.of(context).cryPrimary;
      break;

    default:
      return Colors.black;
  }
  return color;
}
