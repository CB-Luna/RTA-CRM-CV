import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/failed_toastJA.dart';
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
    final List<String> statesNames =
        provider.states.map((state) => state.name).toList();

    final List<String> rolesNames =
        provider.roles.map((role) => role.roleName).toList();
    final List<String> companyNames =
        provider.companys.map((companyName) => companyName.company).toList();

    final List<String> vehicleNames = provider.vehicles
        .map((vehicleNames) => vehicleNames.licesensePlates)
        .toList();
    final List<String> statusName = ["Not Active", "Active"];
    var cardMaskNumber = MaskTextInputFormatter(
        mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')});

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
                          },
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () async {
                        bool valorImage = await provider.selectImage();
                        if (!valorImage) {
                          if (!mounted) return;
                          fToast.showToast(
                            child: const FailedToastJA(
                                message: 'The User image is larger than 1 MB'),
                            gravity: ToastGravity.BOTTOM,
                            toastDuration: const Duration(seconds: 2),
                          );
                        }
                      },
                      child: Container(
                        width: 105,
                        height: 105,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: getUserImage(widget.users, provider.webImage),
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
                        maxLength: 25,
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
                        maxLength: 25,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'Mobile Phone',
                        icon: Icons.phone_outlined,
                        controller: provider.phoneControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [cardMaskNumber],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'Address*',
                        icon: Icons.home_outlined,
                        controller: provider.addressControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.text,
                        maxLength: 25,
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
                          hint:
                              'Choose a Company [${widget.users.company.company}]',
                          label: 'Company',
                          icon: Icons.warehouse_outlined,
                          width: 350,
                          list: companyNames,
                          dropdownValue:
                              provider.selectedCompanyUpdate?.company,
                          onChanged: (val) async {
                            if (val == null) return;
                            provider.selectCompanyUpdate(val);
                            if (val != "RTA") {
                              await provider.getVehicleActive(val,
                                  notify: true);
                            }
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
                        dropdownValue: provider.dropdownvalueUpdate,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.getStatusupdate(val);
                          //print(val);
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomDDownMenu(
                            hint:
                                'Choose a Vehicle [${provider.selectVehiclePlates ?? 'No Vehicle'}]',
                            label: 'Vehicle',
                            icon: Icons.credit_card_outlined,
                            width: MediaQuery.of(context).size.width * 0.145,
                            list: vehicleNames,
                            dropdownValue:
                                provider.selectedVehicleUpdate?.licesensePlates,
                            onChanged: (val) {
                              if (val == null) return;
                              provider.selectVehicleUpdates(val);
                            },
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: CustomTextIconButton(
                                isLoading: false,
                                icon: Icon(
                                  Icons.cleaning_services_outlined,
                                  color: AppTheme.of(context).primaryBackground,
                                ),
                                text: '',
                                onTap: () async {
                                  provider.clearVehicleLicense(notify: false);
                                  provider.clearVehicleUpdate();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'License',
                        icon: Icons.card_membership_outlined,
                        controller: provider.licenseControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.text,
                        maxLength: 10,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextField(
                        label: 'Certification',
                        icon: Icons.workspace_premium_outlined,
                        controller: provider.certificationControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.text,
                        maxLength: 5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomTextIconButton(
              isLoading: false,
              icon: Icon(Icons.save_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Save User',
              mainAxisAlignment: MainAxisAlignment.center,
              width: MediaQuery.of(context).size.width * 0.1,
              onTap: () async {
                if (!formKey.currentState!.validate()) {
                  return;
                }
                await provider.deleteImage();
                await provider.uploadImage();

                // if (provider.webImage != null) {
                //   final res = await provider.uploadImage();
                //   if (res == null) {
                //     ApiErrorHandler.callToast('Error al subir imagen');
                //   }
                // }

                // Cambio del vehiculo del usuario a disponible
                if (provider.selectedVehicleUpdate == null) {
                  provider.updateVehiclestatusClear(widget.users);
                }

                //Crear perfil de usuario
                bool res = await provider.updateUser(widget.users);

                if (!res) {
                  await ApiErrorHandler.callToast(
                      'Error Updating user profile');
                  return;
                }

                if (!mounted) return;
                fToast.showToast(
                  child: const SuccessToast(
                    message: 'User Updated',
                  ),
                  gravity: ToastGravity.BOTTOM,
                  toastDuration: const Duration(seconds: 2),
                );
                provider.updateVehiclestatusUpdate(widget.users);
                provider.updateState();
                if (context.canPop()) context.pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
