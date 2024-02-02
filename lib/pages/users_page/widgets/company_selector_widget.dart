import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

import 'package:rta_crm_cv/providers/users_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../../models/company.dart';

class CompanySelectorWidget extends StatefulWidget {
  const CompanySelectorWidget({Key? key}) : super(key: key);

  @override
  State<CompanySelectorWidget> createState() => _CompanySelectorWidgetState();
}

class _CompanySelectorWidgetState extends State<CompanySelectorWidget> {
  @override
  Widget build(BuildContext context) {
    final UsersProvider provider = Provider.of<UsersProvider>(context);

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
        print(value);
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
        dialogWidth: 100,
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

// Color combinedStatusColor(List<String> statuses, BuildContext context) {
//   Color combinedColor = Colors.black; // Color por defecto

// statuses.forEach((statuses) {
  
//   switch (status) {
//       case "ODE": // Sales Form
//         combinedColor = AppTheme.of(context).odePrimary;
//         break;
//       case "SMI": // Sen. Exec. Validate
//         combinedColor = AppTheme.of(context).smiPrimary;
//         break;
//       case "CRY": // Finance Validate
//         combinedColor = AppTheme.of(context).cryPrimary;
//         break;
//       default:
//       // Puedes manejar un color por defecto aquí si es necesario
//     }})
//   return combinedColor;
// }
