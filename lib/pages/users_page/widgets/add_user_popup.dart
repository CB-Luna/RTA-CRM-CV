import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/get_image_widget.dart';

import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/success_toast.dart';

class AddUserPopUp extends StatefulWidget {
  const AddUserPopUp({super.key});

  @override
  State<AddUserPopUp> createState() => _AddUserPopUpState();
}

class _AddUserPopUpState extends State<AddUserPopUp> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    UsersProvider provider = Provider.of<UsersProvider>(context);
    final formKey = GlobalKey<FormState>();

    final List<String> statesNames =
        provider.states.map((state) => state.name).toList();

    final List<String> rolesNames =
        provider.roles.map((role) => role.roleName).toList();
    final List<String> statusName = ["Not Active", "Active"];
    final List<String> CompanyNames =
        provider.companys.map((companyName) => companyName.company).toList();

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
        title: 'User Creation',
        height: 709,
        width: 380,
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formKey,
              child: CustomScrollBar(
                scrollDirection: Axis.vertical,
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
                        controller: provider.nameController,
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
                        controller: provider.lastNameController,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'Email',
                        icon: Icons.alternate_email,
                        controller: provider.emailController,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'Mobile Phone',
                        icon: Icons.phone_outlined,
                        controller: provider.phoneController,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomDDownMenu(
                        hint: 'Choose a state',
                        label: 'State',
                        icon: Icons.location_on_outlined,
                        width: 350,
                        list: statesNames,
                        dropdownValue: provider.selectedState?.name,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.selectState(val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomDDownMenu(
                        hint: 'Choose a role',
                        label: 'Role',
                        icon: Icons.local_offer_outlined,
                        width: 350,
                        list: rolesNames,
                        dropdownValue: provider.selectedRole?.roleName,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.selectRole(val);
                        },
                      ),
                    ),
                    if (currentUser!.isCV)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomDDownMenu(
                          hint: 'Choose a Company',
                          label: 'Company',
                          icon: Icons.warehouse_outlined,
                          width: 350,
                          list: CompanyNames,
                          dropdownValue: provider.selectedCompany?.company,
                          onChanged: (val) {
                            if (val == null) return;
                            provider.selectCompany(val);
                          },
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomDDownMenu(
                        hint: 'Choose a status',
                        label: 'Status',
                        icon: Icons.settings_backup_restore_outlined,
                        width: 350,
                        list: statusName,
                        dropdownValue: provider.dropdownvalue,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.dropdownvalue = val;
                          print(val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'License',
                        icon: Icons.settings_backup_restore_outlined,
                        controller: provider.licenseController,
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
                        controller: provider.certificationController,
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
                  icon: Icon(Icons.save_outlined,
                      color: AppTheme.of(context).primaryBackground),
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

                    //Registrar usuario
                    final Map<String, String>? result =
                        await provider.registerUser();

                    if (result == null) {
                      await ApiErrorHandler.callToast('Error registering user');
                      return;
                    } else {
                      if (result['Error'] != null) {
                        await ApiErrorHandler.callToast(result['Error']!);
                        return;
                      }
                    }

                    final String? userId = result['userId'];

                    if (userId == null) {
                      await ApiErrorHandler.callToast('Error registering user');
                      return;
                    }

                    //Crear perfil de usuario
                    bool res = await provider.createUserProfile(userId);

                    if (!res) {
                      await ApiErrorHandler.callToast(
                          'Error creating user profile');
                      return;
                    }

                    if (!mounted) return;
                    fToast.showToast(
                      child: const SuccessToast(
                        message: 'Usuario creado',
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
