
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/widgets/custom_ddown_menu/custom_dropdown_inventory.dart';
import 'package:rta_crm_cv/widgets/custom_text_fieldForm.dart';

import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

class ExportDataFilter extends StatefulWidget {
  const ExportDataFilter({super.key});

  @override
  State<ExportDataFilter> createState() => _ExportDataFilterState();
}

class _ExportDataFilterState extends State<ExportDataFilter> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    final formKey = GlobalKey<FormState>();
    DateTime date = DateTime.now();
    DateTime selectedDate = DateTime.now();
    DateTime? newDate;
    String? company;
    
  List<String> companies = ["All", "Ode", "Smi", "Cry"];
    final List<String> companyName =
        provider.company.map((companies) => companies.company).toList();

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Export Data',
        height: 634,
        width: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                        dropdownValue: company,
                        onChanged: (val) {
                          company = val;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: 'Date*',
                          controller: provider.dateTimeControllerOil,
                          enabled: true,
                          onTapCheck: true,
                          width: 350,
                          keyboardType: TextInputType.name,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2050));

                           
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextIconButton(
                    isLoading: false,
                    icon: Icon(Icons.save_outlined,
                        color: AppTheme.of(context).primaryBackground),
                    text: 'Export',
                    onTap: () async {
                     await provider.excelActivityReports(newDate!) ==
                                      false
                                  ? Container()
                                  : Container();
                    }),
                CustomTextIconButton(
                  isLoading: false,
                  icon: Icon(Icons.exit_to_app_outlined,
                      color: AppTheme.of(context).primaryBackground),
                  text: 'Exit',
                  onTap: () {
                    context.pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
