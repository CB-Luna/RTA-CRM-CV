import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/failed_toast.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/warning_toast.dart';
import 'package:rta_crm_cv/widgets/custom_ddown_menu/custom_dropdown_inventory.dart';
import 'package:rta_crm_cv/widgets/custom_text_fieldForm.dart';

import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../widgets/success_toast.dart';

class ExportMonitoryDataFilter extends StatefulWidget {
  const ExportMonitoryDataFilter({super.key});

  @override
  State<ExportMonitoryDataFilter> createState() =>
      _ExportMonitoryDataFilterState();
}

class _ExportMonitoryDataFilterState extends State<ExportMonitoryDataFilter> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    final formKey = GlobalKey<FormState>();

    List<String> companies = ["All", "ODE", "SMI", "CRY"];

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
                    provider.getCompanyFilter("All");
                    provider.getDateFilter(DateTime.now());
                    provider.getLastFilter(DateTime.now());
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: 'First Date*',
                          controller: provider.dateExportDataController,
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
                            if (newDate != null) {
                              provider.dateExportDataController.text =
                                  DateFormat("MM/dd/yyyy").format(newDate);
                              provider.getDateFilter(newDate);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: 'Final Date*',
                          controller: provider.dateFinalExportDataController,
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
                            if (newDate != null) {
                              provider.dateFinalExportDataController.text =
                                  DateFormat("MM/dd/yyyy").format(newDate);
                              provider.getLastFilter(newDate);
                            }
                          }),
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
                    onTap: () {
                      if(provider.enableButton()==true){
                        context.pop();
                      final validation = provider.excelActivityReports();
                      if (validation == true) {
                        fToast.showToast(
                          child: const SuccessToast(
                            message: 'Document Downloaded',
                          ),
                          gravity: ToastGravity.BOTTOM,
                          toastDuration: const Duration(seconds: 2),
                        );
                      } else {
                        fToast.showToast(
                          child: const FailedToast(
                            message: 'Error Downloading Document',
                          ),
                          gravity: ToastGravity.BOTTOM,
                          toastDuration: const Duration(seconds: 3),
                        );
                      }
                      }else{
                        fToast.showToast(
                          child: const WarningToast(
                            message: 'Error Downloading Document. Please Fill All Fields',
                          ),
                          gravity: ToastGravity.BOTTOM,
                          toastDuration: const Duration(seconds: 5),
                        );
                      }
                      
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
