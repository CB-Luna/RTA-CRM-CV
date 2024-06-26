import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/user_profile_provider.dart';

import 'package:rta_crm_cv/theme/theme.dart';

class RoleSelectorWidgetUserProfile extends StatefulWidget {
  const RoleSelectorWidgetUserProfile({Key? key}) : super(key: key);

  @override
  State<RoleSelectorWidgetUserProfile> createState() =>
      _RoleSelectorWidgetUserProfileState();
}

class _RoleSelectorWidgetUserProfileState
    extends State<RoleSelectorWidgetUserProfile> {
  @override
  Widget build(BuildContext context) {
    final UserProfileProvider provider =
        Provider.of<UserProfileProvider>(context);

    if (provider.roles.isEmpty) {
      return Center(
        child: SizedBox(
          width: 350,
          height: 50,
          child: CircularProgressIndicator(
            color: AppTheme.of(context).primaryColor,
          ),
        ),
      );
    } else {
      final List<String> rolesNames =
          provider.roles.map((role) => role.roleName).toList();

      final List<String> selectedRolesNames =
          provider.selectedRoles.map((role) => role.roleName).toList();
      return MultiSelectDialogField(
        key: GlobalKey(),
        items: rolesNames.map((role) => MultiSelectItem(role, role)).toList(),
        initialValue: selectedRolesNames,
        onConfirm: (List<String> roles) {
          provider.setSelectedRoles(roles);
        },
        searchable: true,
        dialogHeight: 400,
        dialogWidth: 500,
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
            return 'At least one role is required';
          }
          return null;
        },
        selectedColor: AppTheme.of(context).primaryColor,
        title: Text(
          'Roles',
          style: AppTheme.of(context).bodyText2,
        ),
        buttonText: const Text('Roles'),
      );
    }
  }
}
