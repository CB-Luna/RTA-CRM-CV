// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/models/models.dart' hide State;
import 'package:rta_crm_cv/providers/user_profile_provider.dart';

import 'package:rta_crm_cv/theme/theme.dart';

class CompanySelectorWidgetUserProf extends StatefulWidget {
  const CompanySelectorWidgetUserProf({Key? key}) : super(key: key);

  @override
  State<CompanySelectorWidgetUserProf> createState() =>
      _CompanySelectorWidgetUserProfState();
}

class _CompanySelectorWidgetUserProfState
    extends State<CompanySelectorWidgetUserProf> {
  @override
  Widget build(BuildContext context) {
    final UserProfileProvider provider =
        Provider.of<UserProfileProvider>(context);

    if (provider.companies.isEmpty) {
      return Center(
        child: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            color: AppTheme.of(context).primaryColor,
          ),
        ),
      );
    } else {
      final List<String> companyNames =
          provider.companies.map((companyName) => companyName.company).toList();

      final List<String> selectedCompanyNames =
          provider.selectedCompanies.map((comp) => comp.company).toList();

      String value = "";
      for (Company currenteCompany in provider.selectedCompanies) {
        value = currenteCompany.company;
      }

      return MultiSelectDialogField(
        key: GlobalKey(),
        items: companyNames.map((comp) => MultiSelectItem(comp, comp)).toList(),
        initialValue: selectedCompanyNames,
        onConfirm: (List<String> companies) {
          provider.setSelectedCompany(companies);
        },
        searchable: true,
        dialogHeight: 250,
        dialogWidth: 350,
        buttonIcon: Icon(
          Icons.arrow_drop_down,
          color: AppTheme.of(context).primaryColor,
        ),
        decoration: BoxDecoration(
          color: AppTheme.of(context).primaryBackground,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.1,
              blurRadius: 3,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        validator: (valores) {
          if (valores == null || valores.isEmpty) {
            return 'At least one Company is required';
          }
          return null;
        },
        selectedColor: AppTheme.of(context).primaryColor,
        // selectedColor: combinedStatusColor(selectedCompanyNames, context),
        title: Text(
          'Company',
          style: AppTheme.of(context).bodyText2,
        ),
        buttonText: const Text('Company'),
      );
    }
  }
}
