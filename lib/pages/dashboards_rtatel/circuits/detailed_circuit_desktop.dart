// ignore_for_file: unrelated_type_equality_checks, await_only_futures

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/date_format.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/circuits_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field_circuit.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';
import '../../../public/colors.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailedCircuitsPageDesktop extends StatefulWidget {
  const DetailedCircuitsPageDesktop({super.key});

  @override
  State<DetailedCircuitsPageDesktop> createState() =>
      _DetailedCircuitsPageDesktopState();
}

class _DetailedCircuitsPageDesktopState
    extends State<DetailedCircuitsPageDesktop> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final CircuitsProvider provider = Provider.of<CircuitsProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  @override
  Widget build(BuildContext context) {
    // SideMenuProvider provider = Provider.of<SideMenuProvider>(context);
    CircuitsProvider provider = Provider.of<CircuitsProvider>(context);
    // double txfFieldWidth = (MediaQuery.of(context).size.width / 7);
    double txfFieldWidth = (MediaQuery.of(context).size.width / 10);

    // double txfFieldPadding = 10;

    double cardHeight = 2.5;

    // double totalTitleWidth = 135;
    return Material(
        child: SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(children: [
        const SideMenu(),
        Flexible(
          child: Container(
              decoration: BoxDecoration(gradient: whiteGradient),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomCard(
                  title: "Circuit",
                  height: MediaQuery.of(context).size.height - 20,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height / cardHeight +
                                150,
                        width: MediaQuery.of(context).size.width - 30,
                        child: CustomScrollBar(
                          clipBehavior: Clip.antiAlias,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CustomCard(
                                height: MediaQuery.of(context).size.height /
                                        cardHeight +
                                    127,
                                width: MediaQuery.of(context).size.width / 5,
                                title: 'Order Info',
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
                                            key: const Key('PPCID'),
                                            required: true,
                                            enabled: false,
                                            width: txfFieldWidth,
                                            controller:
                                                provider.pccidController,
                                            label: 'PPCID',
                                            icon: Icons.cable_outlined,
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
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: CustomTextFieldCircuit(
                                        key: const Key('rta_customer'),
                                        required: true,
                                        enabled: false,
                                        width: txfFieldWidth,
                                        controller:
                                            provider.rtaCustomerController,
                                        label: 'RTA Customer',
                                        icon: Icons.account_circle_outlined,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: CustomTextFieldCircuit(
                                        key: const Key('cktStatus'),
                                        required: true,
                                        enabled: false,
                                        width: txfFieldWidth,
                                        controller:
                                            provider.cktStatusController,
                                        label: 'CKTStatus',
                                        icon: Icons
                                            .settings_input_component_outlined,
                                        keyboardType: TextInputType.text,
                                        /* validator: (value) {
                                              if (provider.dataCenterSelectedValue == 'New') {
                                                if (value == null || value.isEmpty) {
                                                  print('aqui3');
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              }
                                              return null;
                                            }, */
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: CustomTextFieldCircuit(
                                        key: const Key('geMap'),
                                        required: true,
                                        enabled: false,
                                        width: txfFieldWidth,
                                        controller: provider.geMapController,
                                        label: 'GeMap',
                                        icon: Icons.map_outlined,
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: CustomTextFieldCircuit(
                                        key: const Key('Carrier'),
                                        required: true,
                                        enabled: false,
                                        width: txfFieldWidth,
                                        controller: provider.carrierController,
                                        label: 'Carrier',
                                        icon: Icons.smartphone_outlined,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: CustomTextFieldCircuit(
                                        key: const Key('cktType'),
                                        required: true,
                                        enabled: false,
                                        width: txfFieldWidth,
                                        controller: provider.cktTypeController,
                                        label: 'CKTType',
                                        icon:
                                            Icons.settings_input_hdmi_outlined,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: CustomTextFieldCircuit(
                                        key: const Key('cktUse'),
                                        required: true,
                                        enabled: false,
                                        width: txfFieldWidth,
                                        controller: provider.cktUseController,
                                        label: 'CKTUse',
                                        icon: Icons.router_outlined,
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: CustomCard(
                                  height: MediaQuery.of(context).size.height /
                                          cardHeight +
                                      130,
                                  width: MediaQuery.of(context).size.width / 5,
                                  title: 'Order Info',
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10),
                                            child: CustomTextFieldCircuit(
                                              key: const Key('cktID'),
                                              required: true,
                                              enabled: false,
                                              width: txfFieldWidth,
                                              controller:
                                                  provider.cktIDController,
                                              label: 'CKTID',
                                              icon: Icons
                                                  .confirmation_number_outlined,
                                              keyboardType: TextInputType.text,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: CustomTextFieldCircuit(
                                          key: const Key('EVC'),
                                          required: true,
                                          enabled: false,
                                          width: txfFieldWidth,
                                          controller: provider.evcController,
                                          label: 'EVC',
                                          icon: Icons.dialpad_outlined,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: CustomTextFieldCircuit(
                                          key: const Key('Carractnum'),
                                          required: true,
                                          enabled: false,
                                          width: txfFieldWidth,
                                          controller:
                                              provider.caracctnumController,
                                          label: 'CaracctNum',
                                          icon: Icons.tag_outlined,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: CustomTextFieldCircuit(
                                          key: const Key('CarcontID'),
                                          required: true,
                                          enabled: false,
                                          width: txfFieldWidth,
                                          controller:
                                              provider.carcontIDController,
                                          label: 'CarcontID',
                                          icon: Icons.fingerprint_outlined,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: CustomTextFieldCircuit(
                                          key: const Key('ContExp'),
                                          required: true,
                                          enabled: false,
                                          width: txfFieldWidth,
                                          controller:
                                              provider.contexpController,
                                          label: 'ContExp',
                                          icon: Icons.calendar_today_outlined,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: CustomTextFieldCircuit(
                                          key: const Key('ContLength'),
                                          required: true,
                                          enabled: false,
                                          width: txfFieldWidth,
                                          controller:
                                              provider.contLengthController,
                                          label: 'ContLength',
                                          icon:
                                              Icons.supervisor_account_outlined,
                                          keyboardType: TextInputType.text,
                                        ),
                                      ),
                                      Row(children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, right: 20),
                                          child: CustomTextFieldCircuit(
                                            key: const Key('CIR'),
                                            required: true,
                                            enabled: false,
                                            width: 100,
                                            controller: provider.cirController,
                                            label: 'Cir',
                                            icon: Icons.pin_outlined,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: CustomTextFieldCircuit(
                                            key: const Key('Port'),
                                            required: true,
                                            enabled: false,
                                            width: 100,
                                            controller: provider.portController,
                                            label: 'Port',
                                            icon: Icons.router_outlined,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      ])
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: CustomCard(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4.7,
                                      width: MediaQuery.of(context).size.width *
                                          // 0.35,
                                          0.5,
                                      title: 'Circuit Info',
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
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: CustomTextFieldCircuit(
                                                  key: const Key('street'),
                                                  required: true,
                                                  enabled: false,
                                                  width: txfFieldWidth,
                                                  controller:
                                                      provider.streetController,
                                                  label: 'Street',
                                                  icon: Icons.signpost_outlined,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: CustomTextFieldCircuit(
                                                  key: const Key('State'),
                                                  required: true,
                                                  enabled: false,
                                                  width: 110,
                                                  controller:
                                                      provider.stateController,
                                                  label: 'State',
                                                  icon: Icons.domain_outlined,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: CustomTextFieldCircuit(
                                                  key: const Key('HandOff'),
                                                  required: true,
                                                  enabled: false,
                                                  width: txfFieldWidth,
                                                  controller: provider
                                                      .handoffController,
                                                  label: 'HandOff',
                                                  icon:
                                                      Icons.handshake_outlined,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: CustomTextFieldCircuit(
                                                  key: const Key('City'),
                                                  required: true,
                                                  enabled: false,
                                                  width: txfFieldWidth,
                                                  controller:
                                                      provider.cityController,
                                                  label: 'City',
                                                  icon:
                                                      Icons.apartment_outlined,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                              ),
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
                                                  key: const Key('zip'),
                                                  required: true,
                                                  enabled: false,
                                                  width: txfFieldWidth,
                                                  controller:
                                                      provider.zipController,
                                                  label: 'Zip',
                                                  icon: Icons
                                                      .location_city_outlined,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: CustomTextFieldCircuit(
                                                  key: const Key('Longitude'),
                                                  required: true,
                                                  enabled: false,
                                                  width: txfFieldWidth,
                                                  controller: provider
                                                      .longitudeController,
                                                  label: 'Longitude',
                                                  icon: Icons.public_outlined,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 10),
                                                child: CustomTextFieldCircuit(
                                                  key: const Key('Latitude'),
                                                  required: true,
                                                  enabled: false,
                                                  width: txfFieldWidth,
                                                  controller: provider
                                                      .latitudeController,
                                                  label: 'Latitude',
                                                  icon: Icons
                                                      .travel_explore_outlined,
                                                  keyboardType:
                                                      TextInputType.text,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: CustomCard(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                // 0.35,
                                                0.22,
                                            title: 'APOPS',
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child:
                                                          CustomTextFieldCircuit(
                                                        key: const Key(
                                                            'APOPStreet'),
                                                        required: true,
                                                        enabled: false,
                                                        width: txfFieldWidth,
                                                        controller: provider
                                                            .apopStreetController,
                                                        label: 'APOPStreet',
                                                        icon: Icons
                                                            .signpost_outlined,
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child:
                                                          CustomTextFieldCircuit(
                                                        key: const Key(
                                                            'ApopCity'),
                                                        required: true,
                                                        enabled: false,
                                                        width: txfFieldWidth,
                                                        controller: provider
                                                            .apopCityController,
                                                        label: 'ApopCity',
                                                        icon: Icons
                                                            .apartment_outlined,
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child:
                                                          CustomTextFieldCircuit(
                                                        key: const Key(
                                                            'ApopZip'),
                                                        required: true,
                                                        enabled: false,
                                                        width: txfFieldWidth,
                                                        controller: provider
                                                            .apopZipController,
                                                        label: 'ApopZip',
                                                        icon: Icons
                                                            .location_city_outlined,
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child:
                                                          CustomTextFieldCircuit(
                                                        key: const Key(
                                                            'ApopState'),
                                                        required: true,
                                                        enabled: false,
                                                        width: txfFieldWidth,
                                                        controller: provider
                                                            .apopStateController,
                                                        label: 'ApopState',
                                                        icon: Icons
                                                            .domain_outlined,
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child:
                                                          CustomTextFieldCircuit(
                                                        key: const Key(
                                                            'ApopLatitude'),
                                                        required: true,
                                                        enabled: false,
                                                        width: txfFieldWidth,
                                                        controller: provider
                                                            .apopLatitudeController,
                                                        label: 'ApopLatitude',
                                                        icon: Icons
                                                            .travel_explore_outlined,
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child:
                                                          CustomTextFieldCircuit(
                                                        key: const Key(
                                                            'ApopLongitude'),
                                                        required: true,
                                                        enabled: false,
                                                        width: txfFieldWidth,
                                                        controller: provider
                                                            .apopLongitudeController,
                                                        label: 'ApopLongitude',
                                                        icon: Icons
                                                            .public_outlined,
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: CustomCard(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                // 0.35,
                                                0.22,
                                            title: 'BPOPS',
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child:
                                                          CustomTextFieldCircuit(
                                                        key: const Key(
                                                            'BPOPStreet'),
                                                        required: true,
                                                        enabled: false,
                                                        width: txfFieldWidth,
                                                        controller: provider
                                                            .bpopStreetController,
                                                        label: 'BPOPStreet',
                                                        icon: Icons
                                                            .signpost_outlined,
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child:
                                                          CustomTextFieldCircuit(
                                                        key: const Key(
                                                            'BPOPCity'),
                                                        required: true,
                                                        enabled: false,
                                                        width: txfFieldWidth,
                                                        controller: provider
                                                            .bpopCityController,
                                                        label: 'BPOPCity',
                                                        icon: Icons
                                                            .apartment_outlined,
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child:
                                                          CustomTextFieldCircuit(
                                                        key: const Key(
                                                            'BPOPState'),
                                                        required: true,
                                                        enabled: false,
                                                        width: txfFieldWidth,
                                                        controller: provider
                                                            .bpopStateController,
                                                        label: 'BPOPState',
                                                        icon: Icons
                                                            .domain_outlined,
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child:
                                                          CustomTextFieldCircuit(
                                                        key: const Key(
                                                            'BPOPZip'),
                                                        required: true,
                                                        enabled: false,
                                                        width: txfFieldWidth,
                                                        controller: provider
                                                            .bpopZipController,
                                                        label: 'BPOPZip',
                                                        icon: Icons
                                                            .apartment_outlined,
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child:
                                                          CustomTextFieldCircuit(
                                                        key: const Key(
                                                            'BPOPLatitude'),
                                                        required: true,
                                                        enabled: false,
                                                        width: txfFieldWidth,
                                                        controller: provider
                                                            .bpopLatitudeController,
                                                        label: 'BPOPLatitude',
                                                        icon: Icons
                                                            .travel_explore_outlined,
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 10),
                                                      child:
                                                          CustomTextFieldCircuit(
                                                        key: const Key(
                                                            'BPOPLongitude'),
                                                        required: true,
                                                        enabled: false,
                                                        width: txfFieldWidth,
                                                        controller: provider
                                                            .bpopLongitudeController,
                                                        label: 'BPOPLongitude',
                                                        icon: Icons
                                                            .public_outlined,
                                                        keyboardType:
                                                            TextInputType.text,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 500,
                      //   width: 500,
                      //   child: GoogleMap(
                      //     onMapCreated: _onMapCreated,
                      //     initialCameraPosition: CameraPosition(
                      //       target: _center,
                      //       zoom: 11.0,
                      //     ),
                      //     markers: {
                      //       const Marker(
                      //         markerId: const MarkerId("Sydney"),
                      //         position: LatLng(-33.86, 151.20),
                      //       ), // Marker
                      //     }, // markers
                      //   ), // GoogleMap
                      //   // GoogleMap(
                      //   //   onMapCreated: _onMapCreated,
                      //   //   initialCameraPosition: CameraPosition(
                      //   //     target: LatLng(
                      //   //         double.parse(
                      //   //             provider.circuitSelected!.latitude!),
                      //   //         double.parse(
                      //   //             provider.circuitSelected!.longitude!)),
                      //   //     zoom: 11.0,
                      //   //   ),
                      //   //   markers: {
                      //   //     Marker(
                      //   //       markerId: MarkerId('Texas'),
                      //   //       position: LatLng(
                      //   //           double.parse(
                      //   //               provider.circuitSelected!.latitude!),
                      //   //           double.parse(
                      //   //               provider.circuitSelected!.longitude!)),
                      //   //     )
                      //   //   },
                      //   // )
                      // ),
                      CustomScrollBar(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          // color: Colors.black,
                          // padding: const EdgeInsets.all(0),
                          // margin: const EdgeInsets.all(0),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20, top: 0),
                                child: DetailCircuitComments(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 5 -
                                      20,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomTextFieldCircuit(
                                        height: 48,
                                        enabled: true,
                                        controller: provider.commentsController,
                                        icon: Icons.comment_outlined,
                                        label: 'Comment',
                                        keyboardType: TextInputType.text,
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                        5 -
                                                    20) -
                                                100,
                                        // onDone: provider.addComment(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: CustomTextIconButton(
                                          isLoading: false,
                                          height: 48,
                                          icon: Icon(
                                            Icons.send,
                                            color: AppTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          text: 'Send',
                                          onTap: () async =>
                                              provider.addComment(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        )
      ]),
    ));
  }
}

class DetailCircuitComments extends StatefulWidget {
  const DetailCircuitComments({super.key});

  @override
  State<DetailCircuitComments> createState() => _DetailCircuitCommentsState();
}

class _DetailCircuitCommentsState extends State<DetailCircuitComments> {
  @override
  Widget build(BuildContext context) {
    // DetailQuoteProvider provider = Provider.of<DetailQuoteProvider>(context);
    DateTime? sended;
    CircuitsProvider provider = Provider.of<CircuitsProvider>(context);

    return CustomCard(
      // height: MediaQuery.of(context).size.height / 2.25,
      // width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.height / 3.3,
      width: MediaQuery.of(context).size.width / 3,
      title: 'Comments',
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.25 - 150,
                width: MediaQuery.of(context).size.width / 3.2,
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppTheme.of(context).primaryBackground,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ]),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  // itemCount: provider.comments.length,
                  itemCount: provider.comments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 5 - 60,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color:
                                          AppTheme.of(context).secondaryColor),
                                  color: AppTheme.of(context).primaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0.1,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color:
                                            AppTheme.of(context).secondaryColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 5, bottom: 5),
                                        child: Row(
                                          children: [
                                            Text(
                                              "${provider.circuitSelected?.notes}",
                                              // '${provider.comments[index].role} - ${provider.comments[index].name}',
                                              style: TextStyle(
                                                  color: AppTheme.of(context)
                                                      .primaryBackground),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      //height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: CustomScrollBar(
                                          scrollDirection: Axis.vertical,
                                          child: SelectableText(
                                              // provider.comments[index].comment!
                                              "Prueba prueba 2"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SelectableText(
                                dateFormat(sended, true),

                                // dateFormat(provider.comments[index].sended, true),
                                style: AppTheme.of(context).hintText,
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
