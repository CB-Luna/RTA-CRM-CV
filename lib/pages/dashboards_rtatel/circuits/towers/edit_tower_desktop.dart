// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/success_toast.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/circuits_provider.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/tower_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown_v2.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field_circuit.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class EditTowersDesktop extends StatefulWidget {
  const EditTowersDesktop({super.key});

  @override
  State<EditTowersDesktop> createState() => _EditTowersDesktopState();
}

class _EditTowersDesktopState extends State<EditTowersDesktop> {
  FToast fToast = FToast();
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    CircuitsProvider cIrcuitprovider = Provider.of<CircuitsProvider>(context);
    TowerProvider provider = Provider.of<TowerProvider>(context);
    double txfFieldWidth = (MediaQuery.of(context).size.width / 10);

    final formKey = GlobalKey<FormState>();

    double cardHeight = 2.5;

    return Material(
        child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        const SideMenu(),
        Flexible(
          child: Container(
            decoration: BoxDecoration(gradient: whiteGradient),
            child: CustomCard(
              title: provider.nameController == null
                  ? "Edit Tower "
                  : "Editing Tower - ${provider.nameController.text}",
              height: MediaQuery.of(context).size.height - 20,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextIconButton(
                          isLoading: false,
                          icon: Icon(Icons.arrow_back_outlined,
                              color: AppTheme.of(context).primaryBackground),
                          text: 'Go Back',
                          style: AppTheme.of(context).contenidoTablas.override(
                                fontFamily: 'Gotham-Regular',
                                useGoogleFonts: false,
                                color: AppTheme.of(context).primaryBackground,
                              ),
                          onTap: () async {
                            context.pushReplacement(routeCircuits);
                            // context.pop();
                            await cIrcuitprovider.setIndex(1);
                            setState() {}
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height / cardHeight + 150,
                    width: MediaQuery.of(context).size.width - 30,
                    child: CustomScrollBar(
                      clipBehavior: Clip.antiAlias,
                      scrollDirection: Axis.horizontal,
                      child: Form(
                        key: formKey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomCard(
                              height: MediaQuery.of(context).size.height /
                                      cardHeight +
                                  // 127,
                                  135,
                              width: MediaQuery.of(context).size.width / 5,
                              title: 'Tower Info',
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: CustomTextFieldCircuit(
                                          key: const Key('Tower Name'),
                                          required: true,
                                          enabled: false, // true
                                          width: txfFieldWidth + 50,
                                          controller: provider.nameController,
                                          label: 'Tower Name',
                                          icon: Icons.cell_tower_outlined,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextFieldCircuit(
                                      key: const Key('Opco'),
                                      required: true,
                                      enabled: false,
                                      width: txfFieldWidth,
                                      controller: provider.opcoController,
                                      label: 'Opco',
                                      icon: Icons.location_city_outlined,
                                      keyboardType: TextInputType.text,
                                      // validator: (value) {
                                      //   if (value == null ||
                                      //       value.isEmpty) {
                                      //     return 'Please enter some text';
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextFieldCircuit(
                                      key: const Key('height'),
                                      required: true,
                                      enabled: true,
                                      width: txfFieldWidth,
                                      controller: provider.heightController,
                                      label: 'Height',
                                      icon: Icons.height_outlined,
                                      keyboardType: TextInputType.text,
                                      // validator: (value) {
                                      //   if (value == null ||
                                      //       value.isEmpty) {
                                      //     return 'Please enter some text';
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextFieldCircuit(
                                      key: const Key('type'),
                                      required: true,
                                      enabled: true,
                                      width: txfFieldWidth,
                                      controller: provider.typeController,
                                      label: 'Type',
                                      icon: Icons.store_outlined,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextFieldCircuit(
                                      key: const Key('licensed'),
                                      required: true,
                                      enabled: true,
                                      width: txfFieldWidth,
                                      controller: provider.licensedController,
                                      label: 'Licensed',
                                      icon: Icons.view_timeline_outlined,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: CustomTextFieldCircuit(
                                      key: const Key('use'),
                                      required: true,
                                      enabled: true,
                                      width: txfFieldWidth,
                                      controller: provider.useController,
                                      label: 'Use',
                                      icon: Icons.sensor_door_outlined,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomTextIconButton(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          isLoading: false,
                                          icon: Icon(Icons.save_outlined,
                                              color: AppTheme.of(context)
                                                  .primaryBackground),
                                          text: 'Update Tower',
                                          onTap: () async {
                                            if (!formKey.currentState!
                                                .validate()) {
                                              return;
                                            }
                                            //Crear perfil de usuario
                                            bool res =
                                                await provider.updateTowers();

                                            if (!res) {
                                              await ApiErrorHandler.callToast(
                                                  'Error at Update Circuit');
                                              return;
                                            }

                                            if (!mounted) return;
                                            fToast.showToast(
                                              child: const SuccessToast(
                                                message:
                                                    'Tower Updated Succesfuly',
                                              ),
                                              gravity: ToastGravity.BOTTOM,
                                              toastDuration:
                                                  const Duration(seconds: 2),
                                            );
                                          }))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: CustomCard(
                                height: MediaQuery.of(context).size.height /
                                        cardHeight +
                                    60,
                                // 135,
                                width: MediaQuery.of(context).size.width / 5,
                                title: 'Tower Direction',
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: CustomTextFieldCircuit(
                                            key: const Key('address'),
                                            required: true,
                                            enabled: true,
                                            width: txfFieldWidth,
                                            controller:
                                                provider.addressController,
                                            label: 'Address',
                                            icon: Icons.signpost_outlined,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: CustomTextFieldCircuit(
                                        key: const Key('city'),
                                        required: true,
                                        enabled: true,
                                        width: txfFieldWidth,
                                        controller: provider.cityController,
                                        label: 'City',
                                        icon: Icons.apartment_outlined,
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: CustomTextFieldCircuit(
                                        key: const Key('longitude'),
                                        required: true,
                                        enabled: true,
                                        width: txfFieldWidth,
                                        controller: provider.longController,
                                        label: 'Longitude',
                                        icon: Icons.public_outlined,
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: CustomTextFieldCircuit(
                                        key: const Key('latitude'),
                                        required: true,
                                        enabled: true,
                                        width: txfFieldWidth,
                                        controller: provider.latController,
                                        label: 'Latitude',
                                        icon: Icons.travel_explore_outlined,
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: CustomTextFieldCircuit(
                                        key:
                                            const Key('number_customer_Served'),
                                        required: true,
                                        enabled: true,
                                        width: txfFieldWidth,
                                        controller: provider
                                            .numbCustomerServedController,
                                        label: 'Number Customer Served',
                                        icon: Icons.tag_outlined,
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: CustomCard(
                                    height: MediaQuery.of(context).size.height /
                                        // 4.5,
                                        4.2,
                                    width: MediaQuery.of(context).size.width *
                                        // 0.35,
                                        0.5,
                                    title: 'Tower Info',
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(
                                            //           bottom: 10),
                                            //   child:
                                            //       CustomTextFieldCircuit(
                                            //     key: const Key(
                                            //         'leased_owned'),
                                            //     required: true,
                                            //     enabled: true,
                                            //     width: txfFieldWidth,
                                            //     controller: provider
                                            //         .lessorController,
                                            //     label: 'leased/owned',
                                            //     icon: Icons
                                            //         .view_compact_alt_outlined,
                                            //     keyboardType:
                                            //         TextInputType.text,
                                            //   ),
                                            // ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: CustomDDownMenu(
                                                enabled: true,
                                                list: provider.leasedType,
                                                dropdownValue: provider
                                                    .leasedOwnerSelectedValue,
                                                onChanged: (p0) {
                                                  /* if (provider.idVendor == null) {
                                              if (p0 != null) provider.selectVendor(p0);
                                            } */
                                                  if (p0 != null) {
                                                    provider
                                                        .selectedLeasedType(p0);
                                                  }
                                                },
                                                width: txfFieldWidth,
                                                icon: Icons
                                                    .settings_input_component_outlined,
                                                label: 'Leased/Owned',
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: CustomTextFieldCircuit(
                                                key: const Key('lessor'),
                                                required: true,
                                                enabled: true,
                                                width: txfFieldWidth, //110
                                                controller:
                                                    provider.lessorController,
                                                label: 'Lessor',
                                                icon: Icons.cottage_outlined,
                                                keyboardType:
                                                    TextInputType.text,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: CustomTextFieldCircuit(
                                                key: const Key('frequency'),
                                                required: true,
                                                enabled: true,
                                                width: txfFieldWidth,
                                                controller: provider
                                                    .frequencyController,
                                                label: 'Frequency',
                                                icon: Icons
                                                    .autofps_select_outlined,
                                                keyboardType:
                                                    TextInputType.text,
                                              ),
                                            ),
                                            // Los Handoff no quedan
                                            // Padding(
                                            //   padding:
                                            //       const EdgeInsets.only(
                                            //           bottom: 10),
                                            //   child: CustomDDownMenuUser(
                                            //     width: txfFieldWidth,
                                            //     enabled: true,
                                            //     list: provider.handoffList
                                            //         .map((location) =>
                                            //             location.name!)
                                            //         .toList(),
                                            //     dropdownValue: provider
                                            //         .handoffSelectedValue,
                                            //     onChanged: (p0) {
                                            //       //if (p0 != null) provider.selectHandoff(p0);
                                            //     },
                                            //     icon: Icons
                                            //         .waving_hand_outlined,
                                            //     label: 'Handoff',
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: CustomTextFieldCircuit(
                                                key: const Key('make'),
                                                required: true,
                                                enabled: true,
                                                width: txfFieldWidth,
                                                controller:
                                                    provider.makeController,
                                                label: 'Make',
                                                icon: Icons
                                                    .autofps_select_outlined,
                                                keyboardType:
                                                    TextInputType.text,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: CustomTextFieldCircuit(
                                                key: const Key('model'),
                                                required: true,
                                                enabled: true,
                                                width: txfFieldWidth,
                                                controller:
                                                    provider.modelController,
                                                label: 'Model',
                                                icon: Icons
                                                    .autofps_select_outlined,
                                                keyboardType:
                                                    TextInputType.text,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   height: 500,
                  //   width: 500,
                  //   color: Colors.red,
                  //   child: HtmlElementView(viewType: 'mapbox-view-type'),
                  // ),

                  // GoogleMap(
                  //   onMapCreated: _onMapCreated,
                  //   initialCameraPosition: CameraPosition(
                  //     target: LatLng(
                  //         double.parse(
                  //             provider.circuitSelected!.latitude!),
                  //         double.parse(
                  //             provider.circuitSelected!.longitude!)),
                  //     zoom: 11.0,
                  //   ),
                  //   markers: {
                  //     Marker(
                  //       markerId: MarkerId('Texas'),
                  //       position: LatLng(
                  //           double.parse(
                  //               provider.circuitSelected!.latitude!),
                  //           double.parse(
                  //               provider.circuitSelected!.longitude!)),
                  //     )
                  //   },
                  // )
                ],
              ),
            ),
          ),
        )
      ]),
    ));
  }
}
