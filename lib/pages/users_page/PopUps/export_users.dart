import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/custom_ddown_menu/custom_dropdown_inventory.dart';

import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

import '../../../providers/users_provider.dart';

class ExportUsers extends StatefulWidget {
  const ExportUsers({super.key});

  @override
  State<ExportUsers> createState() => _ExportUsersState();
}

class _ExportUsersState extends State<ExportUsers> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    UsersProvider provider = Provider.of<UsersProvider>(context);
    final formKey = GlobalKey<FormState>();

    List<String> companies = ["All","RTA", "ODE", "SMI", "CRY"];

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Export Data',
        height: 634,
        width: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextIconButton(
                  isLoading: false,
                  icon: Icon(Icons.arrow_back_outlined,
                      color: AppTheme.of(context).primaryBackground),
                  text: '',
                  onTap: () {
                    context.pop();
                  },
                ),
              ],
            ),
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomDropDownInventory(
                        hint: 'Choose a Company',
                        label: '1. Company*',
                        width: 350,
                        list: companies,
                        dropdownValue: provider.companySel,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.getCompanyFilter(val);
                        },
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextIconButton(
                    isLoading: false,
                    icon: Icon(Icons.save_outlined,
                        color: AppTheme.of(context).primaryBackground),
                    text: 'Export',
                    onTap: () async {
                      if (context.canPop()) context.pop();
                      await provider.excelActivityReports();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
