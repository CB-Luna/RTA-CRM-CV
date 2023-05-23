import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/users_providers/add_users_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

class AddUserPopUp extends StatefulWidget {
  const AddUserPopUp({super.key});

  @override
  State<AddUserPopUp> createState() => _AddUserPopUpState();
}

class _AddUserPopUpState extends State<AddUserPopUp> {
  @override
  Widget build(BuildContext context) {
    AddUsersProvider provider = Provider.of<AddUsersProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'User Creation',
        height: 700,
        width: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 105,
              width: 105,
              decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: primaryColor)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(label: 'Name', icon: Icons.person_outline, controller: provider.nameController, enabled: true, width: 350),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(label: 'Last Name', icon: Icons.person_outline, controller: provider.lastNameController, enabled: true, width: 350),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(label: 'Email', icon: Icons.alternate_email, controller: provider.emailController, enabled: true, width: 350),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(label: 'Mobile Phone', icon: Icons.phone_outlined, controller: provider.phoneController, enabled: true, width: 350),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(label: 'Country', icon: Icons.location_on_outlined, controller: provider.coutryController, enabled: true, width: 350),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomTextField(label: 'Role', icon: Icons.local_offer_outlined, controller: provider.roleController, enabled: true, width: 350),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextIconButton(icon: Icon(Icons.save_outlined, color: AppTheme.of(context).primaryBackground), text: 'Save User'),
                CustomTextIconButton(icon: Icon(Icons.refresh_outlined, color: AppTheme.of(context).primaryBackground), text: 'Refresh'),
              ],
            )
          ],
        ),
      ),
    );
  }
}
