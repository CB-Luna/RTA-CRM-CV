import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_ddown_menu/custom_dropdown.dart';
import 'package:rta_crm_cv/widgets/custom_text_field.dart';
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

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'User Creation',
        height: 700,
        width: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 105,
                      width: 105,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor),
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomDrowDown(
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
                      child: CustomDrowDown(
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
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextIconButton(
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
                      await ApiErrorHandler.callToast(
                          'Error al registrar usuario');
                      return;
                    } else {
                      if (result['Error'] != null) {
                        await ApiErrorHandler.callToast(result['Error']!);
                        return;
                      }
                    }

                    final String? userId = result['userId'];

                    if (userId == null) {
                      await ApiErrorHandler.callToast(
                          'Error al registrar usuario');
                      return;
                    }

                    //Crear perfil de usuario
                    bool res = await provider.createUserProfile(userId);

                    if (!res) {
                      await ApiErrorHandler.callToast(
                          'Error al crear perfil de usuario');
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
                  icon: Icon(Icons.refresh_outlined,
                      color: AppTheme.of(context).primaryBackground),
                  text: 'Refresh',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
