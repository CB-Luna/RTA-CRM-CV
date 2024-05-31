import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/dashboard_rta/circuits.dart';
import 'package:rta_crm_cv/models/dashboard_rta/comments.dart';
import 'package:rta_crm_cv/public/colors.dart';

class CircuitsProvider extends ChangeNotifier {
  int pageRowCount = 11;
  int page = 1;
  PlutoGridStateManager? stateManager;
  List<PlutoRow> rows = [];

  // Individual
  Circuits? circuitSelected;
  // Listas
  List<Circuits> listCircuits = [];

  // Controladores
  final searchController = TextEditingController();
  //  Circuits
  final pccidController = TextEditingController();
  final rtaCustomerController = TextEditingController();
  final cktStatusController = TextEditingController();
  final geMapController = TextEditingController();
  final carrierController = TextEditingController();
  final cktTypeController = TextEditingController();
  final cktUseController = TextEditingController();
  final cktIDController = TextEditingController();
  final evcController = TextEditingController();
  final caracctnumController = TextEditingController();
  final carcontIDController = TextEditingController();
  final contexpController = TextEditingController();
  final contLengthController = TextEditingController();

  // Info
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final zipController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();
  final cirController = TextEditingController();
  final portController = TextEditingController();
  final handoffController = TextEditingController();

  // APOP
  final apopStreetController = TextEditingController();
  final apopCityController = TextEditingController();
  final apopStateController = TextEditingController();
  final apopZipController = TextEditingController();
  final apopLatitudeController = TextEditingController();
  final apopLongitudeController = TextEditingController();

  // BPOP
  final bpopStreetController = TextEditingController();
  final bpopCityController = TextEditingController();
  final bpopStateController = TextEditingController();
  final bpopZipController = TextEditingController();
  final bpopLatitudeController = TextEditingController();
  final bpopLongitudeController = TextEditingController();

  final commentsController = TextEditingController();

  void setPageSize(String x) {
    switch (x) {
      case 'more':
        if (pageRowCount < rows.length) pageRowCount++;
        break;
      case 'less':
        if (pageRowCount > 1) pageRowCount--;
        break;
      default:
        return;
    }
    stateManager!.createFooter;
    notifyListeners();
  }

  void setPage(String x) {
    switch (x) {
      case 'next':
        if (page < stateManager!.totalPage) page++;
        break;
      case 'previous':
        if (page > 1) page--;
        break;
      case 'start':
        page = 1;
        break;
      case 'end':
        page = stateManager!.totalPage;
        break;
      default:
        return;
    }
    stateManager!.setPage(page);
    notifyListeners();
  }

  Future<void> updateState() async {
    rows.clear();
    await getCircuits();
  }

  final commentController = TextEditingController();
  List<CommentCircuit> comments = [];

  Future<void> addComment() async {
    if (commentController.text.isNotEmpty) {
      await supabaseDashboard.from('circuit_comments').insert(
        {
          "user_id": currentUser!.id,
          // "circuit_id": circuitSelected!.id,
          "circuit_id": 15,

          "comment": commentController.text,
          "sended": DateTime.now().toIso8601String(),
        },
      );
      comments.add(
        CommentCircuit(
          userfk: currentUser!.id,
          // id: circuitSelected!.id,
          id: 15,
          comment: commentController.text,
          sended: DateTime.now(),
        ),
      );
      commentController.clear();
      notifyListeners();
    }
  }

  Future<void> getCircuits() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      // SUPBASECTRlV es el control vehicular

      final query = supabaseDashboard
          .from('circuits_view')
          .select()
          // .or(
          //     'rta_customer.ilike.%${searchController.text}%,pccid.ilike.%${searchController.text}%,ckttype.ilike.%${searchController.text}%,carrier.ilike.%${searchController.text}%)');

          .like('rta_customer | pccid', '%${searchController.text}%');

      final res = await query;
      // final res = await supabaseDashboard.from('circuits_view').select();

      listCircuits = (res as List<dynamic>)
          .map((vehicles) => Circuits.fromJson(jsonEncode(vehicles)))
          .toList();

      rows.clear();
      for (Circuits circuit in listCircuits) {
        rows.add(
          PlutoRow(
            cells: {
              "pccid_Column": PlutoCell(value: circuit.pccid),
              "rta_customers_Column": PlutoCell(value: circuit.rtaCustomer),
              "CKTSTATUS_Column": PlutoCell(value: circuit.cktstatus),
              "CktID_Column": PlutoCell(value: circuit.cktid),
              "street_Column": PlutoCell(value: circuit.street),
              "state_Column": PlutoCell(value: circuit.state),
              "CKTType_Column": PlutoCell(value: circuit.ckttype),
              "cktuse_Column": PlutoCell(value: circuit.cktuse),
              "actions": PlutoCell(value: circuit.id),
            },
          ),
        );
      }

      if (stateManager != null) stateManager!.notifyListeners();
    } catch (e) {
      log('Error en getCircuits() - $e');
    }
    notifyListeners();
  }

  // Nos trae la información de los trainings por usuarios
  Future<void> getInformationCircuit(int id) async {
    try {
      circuitSelected = listCircuits.firstWhere((element) => element.id == id);
      pccidController.text = circuitSelected!.pccid.toString();
      rtaCustomerController.text = circuitSelected!.rtaCustomer.toString();
      cktStatusController.text = circuitSelected!.cktstatus!;
      geMapController.text = circuitSelected!.gemap!;
      carrierController.text = circuitSelected!.carrier!;
      cktTypeController.text = circuitSelected!.cktid!;
      cktUseController.text = circuitSelected!.cktuse!;
      cktIDController.text = circuitSelected!.cktid!;
      evcController.text = circuitSelected!.evc!;
      caracctnumController.text = circuitSelected!.caracctnum!;
      carcontIDController.text = circuitSelected!.carcontid!.toString();
      contexpController.text =
          DateFormat("MM/dd/yyyy").format(circuitSelected!.contexp!);
      contLengthController.text = circuitSelected!.contlength!.toString();
      streetController.text = circuitSelected!.street!;
      cityController.text = circuitSelected!.city!;
      stateController.text = circuitSelected!.state!;
      zipController.text = circuitSelected!.zip!.toString();
      latitudeController.text = circuitSelected!.latitude!;
      longitudeController.text = circuitSelected!.longitude!;
      cirController.text = circuitSelected!.cir!.toString();
      portController.text = circuitSelected!.port!.toString();
      handoffController.text = circuitSelected!.handoff!;
      apopStreetController.text = circuitSelected!.apopstreet!;
      apopCityController.text = circuitSelected!.apopcity!;
      apopStateController.text = circuitSelected!.apopzip.toString();
      apopZipController.text = circuitSelected!.apopzip.toString();
      apopLatitudeController.text = circuitSelected!.apoplat!;
      apopLongitudeController.text = circuitSelected!.apoplong!;
      bpopStreetController.text = circuitSelected!.bpopstreet!;
      bpopCityController.text = circuitSelected!.bpopcity!;
      bpopStateController.text = circuitSelected!.bpopstate!;
      bpopZipController.text = circuitSelected!.bpopzip.toString();
      bpopLatitudeController.text = circuitSelected!.bpoplat!;
      bpopLongitudeController.text = circuitSelected!.bpoplong!;
      commentsController.text = circuitSelected!.notes!;
    } catch (e) {
      print('Error en getInformationTraining() - $e');
    }
  }
}
