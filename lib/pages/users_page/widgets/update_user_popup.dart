import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/widgets/get_image_widget.dart';

import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/success_toast.dart';

import '../../../models/user.dart';

class UpdateUserPopUp extends StatefulWidget {
  final User users;
  const UpdateUserPopUp({
    super.key,
    required this.users,
  });

  @override
  State<UpdateUserPopUp> createState() => _UpdateUserPopUpState();
}

class _UpdateUserPopUpState extends State<UpdateUserPopUp> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    UsersProvider provider = Provider.of<UsersProvider>(context);
    final formKey = GlobalKey<FormState>();

    final List<String> statesNames = provider.states.map((state) => state.name).toList();

    final List<String> rolesNames = provider.roles.map((role) => role.roleName).toList();
    final List<String> CompanyNames = provider.companys.map((companyName) => companyName.company).toList();

    return Dialog(
      shape: const RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      insetPadding: EdgeInsets.zero,
      child: CustomCard(
        title: 'Update User',
        height: 709,
        width: 380,
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        await provider.selectImage();
                      },
                      child: Container(
                        width: 105,
                        height: 105,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: getUserImage(provider.webImage),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'Name',
                        icon: Icons.person_outline,
                        controller: provider.nameControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'Last Name',
                        icon: Icons.person_outline,
                        controller: provider.lastNameControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: CustomTextField(
                    //     label: 'Email',
                    //     icon: Icons.alternate_email,
                    //     controller: provider.emailControllerUpdate,
                    //     enabled: true,
                    //     width: 350,
                    //     keyboardType: TextInputType.emailAddress,
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'Mobile Phone',
                        icon: Icons.phone_outlined,
                        controller: provider.phoneControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomDDownMenu(
                        hint: 'Choose a state [${widget.users.state.name}]',
                        label: 'State',
                        icon: Icons.location_on_outlined,
                        width: 350,
                        list: statesNames,
                        dropdownValue: provider.selectedStateUpdate?.name,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.selectStateUpdate(val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomDDownMenu(
                        hint: 'Choose a role [${widget.users.role.roleName}]',
                        label: 'Role',
                        icon: Icons.local_offer_outlined,
                        width: 350,
                        list: rolesNames,
                        dropdownValue: provider.selectedRoleUpdate?.roleName,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.selectRoleUpdate(val);
                        },
                      ),
                    ),
                    if (currentUser!.isCV)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomDDownMenu(
                          hint: 'Choose a Company [${widget.users.company.company}]',
                          label: 'Company',
                          icon: Icons.warehouse_outlined,
                          width: 350,
                          list: CompanyNames,
                          dropdownValue: provider.selectedCompanyUpdate?.company,
                          onChanged: (val) {
                            if (val == null) return;
                            provider.selectCompanyUpdate(val);
                          },
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'Status',
                        icon: Icons.settings_backup_restore_outlined,
                        controller: provider.statusControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'License',
                        icon: Icons.settings_backup_restore_outlined,
                        controller: provider.licenseControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'Certification',
                        icon: Icons.settings_backup_restore_outlined,
                        controller: provider.certificationControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.text,
                      ),
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
                  icon: Icon(Icons.save_outlined, color: AppTheme.of(context).primaryBackground),
                  text: 'Save User',
                  onTap: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    // if (provider.webImage != null) {
                    //   final res = await provider.uploadImage();
                    //   if (res == null) {
                    //     ApiErrorHandler.callToast('Error al subir imagen');
                    //   }
                    // }

                    //Crear perfil de usuario
                    bool res = await provider.updateUser(widget.users);

                    if (!res) {
                      await ApiErrorHandler.callToast('Error Updating user profile');
                      return;
                    }

                    if (!mounted) return;
                    fToast.showToast(
                      child: const SuccessToast(
                        message: 'Usuario Actualizado',
                      ),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: const Duration(seconds: 2),
                    );

                    if (context.canPop()) context.pop();
                  },
                ),
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
