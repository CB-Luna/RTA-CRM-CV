import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/role.dart';
import 'package:rta_crm_cv/providers/user_profile_provider.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown_user.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/get_image_widget.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';
import '../../../functions/sizes.dart';
import '../../../models/company.dart';
import '../../../public/colors.dart';
import '../../../widgets/captura/custom_ddown_menu/custom_dropdown.dart';
import '../../../widgets/custom_card.dart';
import '../../ctrlv/download_apk/widgets/success_toast.dart';

class UserProfileDesktop extends StatefulWidget {
  const UserProfileDesktop({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfileDesktop> createState() => _UserProfileDesktopState();
}

class _UserProfileDesktopState extends State<UserProfileDesktop> {
  FToast fToast = FToast();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final UserProfileProvider provider = Provider.of<UserProfileProvider>(
        context,
        listen: false,
      );

      provider.initEditUser();
      await provider.getCompanies(notify: true);
      await provider.getStates(notify: true);
      await provider.getRoles(notify: true);
      if (currentUser!.idVehicle != null) {
        await provider.getVehicleUser(notify: false);
      }
      await provider.getVehicleActiveInit(
        notify: false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    UserProfileProvider provider = Provider.of<UserProfileProvider>(context);
    fToast.init(context);

    double txfFieldWidth = (MediaQuery.of(context).size.width / 7);
    final formKey = GlobalKey<FormState>();
    final List<String> statusName = ["Not Active", "Active"];
    final List<String> statesNames =
        provider.states.map((state) => state.name).toList();
    final List<String> selectedRoles =
        provider.selectedRoles.map((role) => role.roleName).toList();
    final List<String> vehicleNames = provider.vehicles
        .map((vehicleName) => vehicleName.licesensePlates)
        .toList();

    final bool isVisible = selectedRoles.contains('Employee') ||
        selectedRoles.contains('Tech Supervisor') ||
        selectedRoles.contains('Manager');

    // bool _showTextField = false;
    return Material(
      // Container de toda la pantalla
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(gradient: whiteGradient),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SideMenu(),
            Flexible(
              child: CustomCard(
                width: MediaQuery.of(context).size.width - 200,
                height: MediaQuery.of(context).size.height,
                title: "User Profile ",
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          height: getHeight(850, context),
                          // width: getWidth(2450, context),
                          width: getWidth(850, context),

                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 3,
                                  color: AppTheme.of(context).cryPrimary),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await provider.selectImage();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 105,
                                            height: 105,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child:
                                                // Provider.webImage es cuando seleccionas la foto y provider.imageurl, debe ser la imagen que ya tiene
                                                getUserImage(
                                                    provider.webImage ??
                                                        // currentUser!.image)
                                                        provider.imageUrl),
                                            // child: currentUser!.image == null
                                            //     ? Image.asset(
                                            //         "assets/images/default-user-profile-picture.png")
                                            //     : Image.network(
                                            //         currentUser!.image!)
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            provider.clearImage();
                                          },
                                          child: Container(
                                              width: 105,
                                              height: 25,
                                              margin: const EdgeInsets.all(10),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: AppTheme.of(context)
                                                      .cryPrimary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Text(
                                                "Clear Image",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, right: 10),
                                        child: CustomTextField(
                                          key: const Key('First Name'),
                                          required: true,
                                          enabled: true,
                                          width: txfFieldWidth,
                                          controller: provider.nameController,
                                          label: 'First Name',
                                          icon: Icons.person_outline,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: CustomTextField(
                                          key: const Key('Middle Name'),
                                          required: true,
                                          enabled: true,
                                          width: txfFieldWidth,
                                          controller: provider.middleController,
                                          label: 'Middle Name',
                                          icon: Icons.person_outline,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, right: 10),
                                        child: CustomTextField(
                                          key: const Key('Last Name'),
                                          required: true,
                                          enabled: true,
                                          width: txfFieldWidth,
                                          controller:
                                              provider.lastNameController,
                                          label: 'Last Name',
                                          icon: Icons.person_outline,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: CustomTextField(
                                          key: const Key('Home Phone'),
                                          required: true,
                                          enabled: true,
                                          width: txfFieldWidth,
                                          controller:
                                              provider.homePhoneController,
                                          label: 'Home Phone',
                                          icon: Icons.smartphone_outlined,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, right: 10),
                                        child: CustomTextField(
                                          key: const Key('Mobile Phone'),
                                          required: true,
                                          enabled: true,
                                          width: txfFieldWidth,
                                          controller:
                                              provider.mobilePhoneController,
                                          label: 'Mobile Phone',
                                          icon: Icons.phone_outlined,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: CustomTextField(
                                          key: const Key('Address'),
                                          required: true,
                                          enabled: true,
                                          width: txfFieldWidth,
                                          controller:
                                              provider.addressController,
                                          label: 'Address',
                                          icon: Icons.home_outlined,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, right: 10),
                                        child: CustomTextField(
                                          key: const Key('Birthday'),
                                          required: true,
                                          enabled: true,
                                          width: txfFieldWidth,
                                          controller:
                                              provider.birthdayController,
                                          label: 'Birthday',
                                          icon: Icons.cake_outlined,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 35),
                                        child: CustomDDownMenuUser(
                                          hint: 'Choose a state*',
                                          label: 'State',
                                          icon: Icons.location_on_outlined,
                                          width: txfFieldWidth,
                                          list: statesNames,
                                          dropdownValue:
                                              provider.selectedState?.name,
                                          onChanged: (val) {
                                            if (val == null) return;
                                            provider.selectState(val);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, right: 10),
                                        child: CustomTextField(
                                          key: const Key('Current Password'),
                                          required: true,
                                          enabled: true,
                                          width: txfFieldWidth,
                                          controller:
                                              provider.latepasswordController,
                                          label: 'Current Password',
                                          icon: Icons.key_outlined,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: CustomTextField(
                                          key: const Key('New Password'),
                                          required: true,
                                          enabled: true,
                                          width: txfFieldWidth,
                                          controller:
                                              provider.passwordController,
                                          label: 'New Password',
                                          icon: Icons.vpn_key_outlined,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: CustomTextIconButton(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            isLoading: false,
                                            icon: Icon(Icons.save_outlined,
                                                color: AppTheme.of(context)
                                                    .primaryBackground),
                                            text: 'Save User',
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            onTap: () async {
                                              if (!formKey.currentState!
                                                  .validate()) {
                                                return;
                                              }

                                              await provider.validateImage(
                                                  currentUser!.image);

                                              //Editar perfil de usuario
                                              bool res =
                                                  await provider.updateUser();

                                              if (!res) {
                                                await ApiErrorHandler.callToast(
                                                    'Error Updating user profile');
                                                return;
                                              }

                                              res = await provider.editRoles();
                                              if (!res) {
                                                await ApiErrorHandler.callToast(
                                                    'Error updating roles');
                                                return;
                                              }

                                              res =
                                                  await provider.editCompanys();
                                              if (!res) {
                                                await ApiErrorHandler.callToast(
                                                    'Error updating companies');
                                                return;
                                              }

                                              await provider
                                                  .updateVehicleStatusUpdate();

                                              if (provider.passwordController
                                                  .text.isNotEmpty) {
                                                final res = await supabase.rpc(
                                                    'change_user_password',
                                                    params: {
                                                      'current_plain_password':
                                                          provider
                                                              .latepasswordController
                                                              .text,
                                                      'new_plain_password':
                                                          provider
                                                              .passwordController
                                                              .text,
                                                    });
                                                if (res) return;
                                                fToast.showToast(
                                                  child: const SuccessToast(
                                                    message: 'Password Updated',
                                                  ),
                                                  gravity: ToastGravity.BOTTOM,
                                                  toastDuration: const Duration(
                                                      seconds: 2),
                                                );
                                              }

                                              if (!mounted) return;
                                              fToast.showToast(
                                                child: const SuccessToast(
                                                  message: 'User Updated',
                                                ),
                                                gravity: ToastGravity.BOTTOM,
                                                toastDuration:
                                                    const Duration(seconds: 2),
                                              );
                                            }),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 50.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text("Companies: ",
                                              style: TextStyle(
                                                  color: AppTheme.of(context)
                                                      .cryPrimary,
                                                  fontSize: 20)),
                                          SizedBox(
                                            height: 45,
                                            width: txfFieldWidth,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: provider
                                                  .selectedCompanies.length,
                                              itemBuilder: (context, index) {
                                                Company currentCompany =
                                                    provider.selectedCompanies[
                                                        index];
                                                return Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                    height: 45,
                                                    alignment: Alignment.center,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 2,
                                                        vertical: 3),
                                                    decoration: BoxDecoration(
                                                      color: statusColor(
                                                          currentCompany
                                                              .company,
                                                          context),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                      currentCompany.company,
                                                      style:
                                                          AppTheme.of(context)
                                                              .contenidoTablas
                                                              .override(
                                                                fontFamily:
                                                                    'Gotham-Regular',
                                                                useGoogleFonts:
                                                                    false,
                                                                color: AppTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                              ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Row(
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Roles: ",
                                                style: TextStyle(
                                                    color: AppTheme.of(context)
                                                        .cryPrimary,
                                                    fontSize: 20)),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,
                                            width: txfFieldWidth,
                                            child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount:
                                                  provider.selectedRoles.length,
                                              itemBuilder: (context, index) {
                                                var currentRole = provider
                                                    .selectedRoles[index];
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(currentRole
                                                        .application),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.06,
                                                        height: 45,
                                                        alignment:
                                                            Alignment.center,
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 2,
                                                            vertical: 3),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: AppTheme.of(
                                                                      context)
                                                                  .cryPrimary),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Text(
                                                          currentRole.roleName,
                                                          style: AppTheme.of(
                                                                  context)
                                                              .contenidoTablas
                                                              .override(
                                                                fontFamily:
                                                                    'Gotham-Regular',
                                                                useGoogleFonts:
                                                                    false,
                                                                color: AppTheme.of(
                                                                        context)
                                                                    .cryPrimary,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ),

                                          // SizedBox(
                                          //   height:
                                          //       MediaQuery.of(context).size.height *
                                          //           0.1,
                                          //   width: txfFieldWidth,
                                          //   child: ListView.builder(
                                          //     scrollDirection: Axis.horizontal,
                                          //     itemCount:
                                          //         provider.selectedRoles.length,
                                          //     itemBuilder: (context, index) {
                                          //       // Role currentRole =
                                          //       //     provider.selectedRoles[index];
                                          //       return Column(
                                          //         children: [
                                          //           Row(
                                          //             children: [
                                          //               // Text(currentRole.application),
                                          //               Text(provider
                                          //                   .selectedRoles[index]
                                          //                   .application),

                                          //               Align(
                                          //                 alignment:
                                          //                     Alignment.centerRight,
                                          //                 child: Container(
                                          //                   width: MediaQuery.of(
                                          //                               context)
                                          //                           .size
                                          //                           .width *
                                          //                       0.04,
                                          //                   height: 45,
                                          //                   alignment:
                                          //                       Alignment.center,
                                          //                   margin: const EdgeInsets
                                          //                           .symmetric(
                                          //                       horizontal: 2,
                                          //                       vertical: 3),
                                          //                   decoration:
                                          //                       BoxDecoration(
                                          //                     border: Border.all(
                                          //                         color: AppTheme.of(
                                          //                                 context)
                                          //                             .cryPrimary),
                                          //                     borderRadius:
                                          //                         BorderRadius
                                          //                             .circular(10),
                                          //                   ),
                                          //                   child: Text(
                                          //                     provider
                                          //                         .selectedRoles[
                                          //                             index]
                                          //                         .roleName, // currentRole.roleName,
                                          //                     style: AppTheme.of(
                                          //                             context)
                                          //                         .contenidoTablas
                                          //                         .override(
                                          //                           fontFamily:
                                          //                               'Gotham-Regular',
                                          //                           useGoogleFonts:
                                          //                               false,
                                          //                           color: AppTheme.of(
                                          //                                   context)
                                          //                               .cryPrimary,
                                          //                         ),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ],
                                          //       );
                                          //     },
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       vertical: 10),
                                    //   child: SizedBox(
                                    //       width: txfFieldWidth,
                                    //       child:
                                    //           const RoleSelectorWidgetUserProfile()),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       vertical: 10),
                                    //   child: Container(
                                    //       width: txfFieldWidth,
                                    //       child:
                                    //           const CompanySelectorWidgetUserProf()),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: CustomDDownMenuUser(
                                        hint: 'Choose a status*',
                                        label: 'Status',
                                        icon: Icons
                                            .settings_backup_restore_outlined,
                                        width: txfFieldWidth,
                                        list: statusName,
                                        dropdownValue: provider.selectedStatus,
                                        onChanged: (val) {
                                          if (val == null) return;
                                          provider.getStatus(val);
                                          //print(val);
                                        },
                                      ),
                                    ),

                                    Visibility(
                                      visible: isVisible,
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: CustomDDownMenu(
                                              hint:
                                                  provider.vehiclexUser.isEmpty
                                                      ? "Choose a Vehicle"
                                                      : provider
                                                          .vehiclexUser
                                                          .first
                                                          .licesensePlates,
                                              label: 'Vehicle',
                                              icon: Icons.credit_card_outlined,
                                              width: 200,
                                              list: vehicleNames,
                                              dropdownValue: provider
                                                  .selectedVehicle
                                                  ?.licesensePlates,
                                              onChanged: (val) {
                                                if (val == null) return;
                                                //print(val);
                                                provider.selectedVehiclee(val);
                                              },
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: CustomTextIconButton(
                                                  isLoading: false,
                                                  icon: Icon(
                                                    Icons
                                                        .cleaning_services_outlined,
                                                    color: AppTheme.of(context)
                                                        .primaryBackground,
                                                  ),
                                                  text: 'Clear Plates',
                                                  onTap: () async {
                                                    provider.clearVehicle();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: isVisible,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: CustomTextField(
                                          label: 'License',
                                          icon: Icons.card_membership_outlined,
                                          controller:
                                              provider.licenseController,
                                          enabled: true,
                                          width: txfFieldWidth,
                                          keyboardType: TextInputType.text,
                                          maxLength: 10,
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isVisible,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: CustomTextField(
                                          label: 'Certification',
                                          icon:
                                              Icons.workspace_premium_outlined,
                                          controller:
                                              provider.certificationController,
                                          enabled: true,
                                          width: txfFieldWidth,
                                          keyboardType: TextInputType.text,
                                          maxLength: 5,
                                        ),
                                      ),
                                    ),
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }
}

Color statusColor(String status, BuildContext context) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = AppTheme.of(context).odePrimary;
      break;
    case "SMI": //Sen. Exec. Validate
      color = AppTheme.of(context).smiPrimary;
      break;
    case "CRY": //Finance Validate
      color = AppTheme.of(context).cryPrimary;
      break;

    default:
      return Colors.black;
  }
  return color;
}
