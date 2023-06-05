import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/accounts/tabs/leads_provider.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/success_toast.dart';

class CreateLead extends StatefulWidget {
  const CreateLead({super.key});

  @override
  State<CreateLead> createState() => _CreateLeadState();
}

class _CreateLeadState extends State<CreateLead> {
  FToast fToast = FToast();
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    LeadsProvider provider = Provider.of<LeadsProvider>(context);
    final formKey = GlobalKey<FormState>();
    final formKey2 = GlobalKey<FormState>();

    final List<String> statesNames = provider.states.map((state) => state.name).toList();

    final List<String> rolesNames = provider.roles.map((role) => role.roleName).toList();

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Create Lead',
        height: 920,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Tarjeta Basic Information
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomCard(
                    title: 'Basic Information',
                    height: 590,
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
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'First Name',
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
                                    controller: provider.lastnameController,
                                    enabled: true,
                                    width: 350,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomDDownMenu(
                                    hint: 'None',
                                    label: 'Sales Stage',
                                    icon: Icons.attach_money,
                                    width: 350,
                                    list: statesNames,
                                    dropdownValue: provider.selectedState?.name,
                                    onChanged: (val) {
                                      if (val == null) return;
                                      provider.selectStage(val);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'Account',
                                    icon: Icons.business_outlined,
                                    controller: provider.accountController,
                                    enabled: true,
                                    width: 350,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'Email',
                                    icon: Icons.email,
                                    controller: provider.emailController,
                                    enabled: true,
                                    width: 350,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomDDownMenu(
                                    hint: 'None',
                                    label: 'Lead Source',
                                    icon: Icons.menu,
                                    width: 350,
                                    list: rolesNames,
                                    dropdownValue: provider.selectedRole?.roleName,
                                    onChanged: (val) {
                                      if (val == null) return;
                                      provider.selectLead(val);
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'Phone',
                                    icon: Icons.phone,
                                    controller: provider.phoneController,
                                    enabled: true,
                                    width: 350,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Tarjeta Other Information
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomCard(
                    title: 'Other Information',
                    height: 590,
                    width: 380,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Form(
                          key: formKey2,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'Expected Close Date',
                                    icon: Icons.calendar_month,
                                    controller: provider.closedateController,
                                    enabled: true,
                                    width: 350,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'Quote Amount',
                                    icon: Icons.attach_money,
                                    controller: provider.quoteamountController,
                                    enabled: true,
                                    width: 350,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'Probability',
                                    icon: Icons.percent,
                                    controller: provider.probabilityController,
                                    enabled: true,
                                    width: 350,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomDDownMenu(
                                    hint: 'None',
                                    label: 'Assigned To',
                                    icon: Icons.assignment_ind,
                                    width: 350,
                                    list: rolesNames,
                                    dropdownValue: provider.selectedRole?.roleName,
                                    onChanged: (val) {
                                      if (val == null) return;
                                      provider.selectAssigned(val);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //Tarjeta Descripcion
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomCard(
                title: 'Description',
                height: 160,
                width: 760,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomTextField(
                    label: 'Description',
                    icon: Icons.person_outline,
                    controller: provider.descriptionController,
                    enabled: true,
                    width: 740,
                    height: 51,
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
            ),
            //Row Botones Crear
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextIconButton(
                    isLoading: false,
                    icon: Icon(Icons.add, color: AppTheme.of(context).primaryBackground),
                    text: 'Create',
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
                      final Map<String, String>? result = await provider.registerUser();

                      if (result == null) {
                        await ApiErrorHandler.callToast('Error al registrar usuario');
                        return;
                      } else {
                        if (result['Error'] != null) {
                          await ApiErrorHandler.callToast(result['Error']!);
                          return;
                        }
                      }

                      final String? userId = result['userId'];

                      if (userId == null) {
                        await ApiErrorHandler.callToast('Error al registrar usuario');
                        return;
                      }

                      //Crear perfil de usuario
                      bool res = await provider.createUserProfile(userId);

                      if (!res) {
                        await ApiErrorHandler.callToast('Error al crear perfil de usuario');
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
                    icon: Icon(Icons.refresh_outlined, color: AppTheme.of(context).primaryBackground),
                    text: 'Refresh',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
