// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, unrelated_type_equality_checks

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/crm/quotes/quotes_tab.dart';

import '../../models/jsa/jsa.dart';
import '../../models/jsa/jsa_document_list.dart';
import '../../models/jsa/users_jsa.dart';

class JSADocumentListProvider extends ChangeNotifier {
  bool istaped = false;

  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  PlutoGridStateManager? stateManager;
  int pageRowCount = 10;
  int page = 1;
  List<JsaDocumentList> jsaDocuments = [];
  List<UsersJsa> usersJsa = [];
  List<Jsa> listJSA = [];
  List<Jsa> listJSAFiltered = [];

  List<Jsa> list = [];

  Jsa? jsaSelected;
  int signedUsers = 0;
  List<Usersjsa> filteredUsers = [];
  int numberJSA = 0;

  bool loadingGrid = false;
  Future<void> updateState() async {
    loadingGrid = false;
    await getDocumentList();
  }

  Future<void> getDocumentList() async {
    if (stateManager != null) {
      stateManager!.setShowLoading(true);
      notifyListeners();
    }
    try {
      if (currentUser!.isManagerJSA) {
        final res = await supabaseJsa
            .from('jsa_view')
            .select()
            .eq('company_fk', currentUser!.company_fk);
        if (res == null) {
          print('Error en getDocumentList()');
          return;
        }
        // print(res);
        listJSA = (res as List<dynamic>)
            .map((jSA) => Jsa.fromJson(jsonEncode(jSA)))
            .toList();
      } else {
        final res = await supabaseJsa.from('jsa_view').select();
        if (res == null) {
          print('Error en getDocumentList()');
          return;
        }
        // print(res);
        listJSA = (res as List<dynamic>)
            .map((jSA) => Jsa.fromJson(jsonEncode(jSA)))
            .toList();
      }

      // print("En getInformationJSA con el JSA_FK: con res: $res");
      rows.clear();
    } catch (e) {
      print('Error en getDocumentList() - $e');
    }
    notifyListeners();
  }

  void getInformationJSA(int index) {
    try {
      numberJSA = listJSA[index].id!;
      signedUsers = 0;
      rows.clear();
      jsaSelected = listJSA.firstWhere((element) => element.id == numberJSA);

      if (jsaSelected != null) {
        for (Usersjsa user in jsaSelected!.usersjsa) {
          // if (user.role!.application == "JSA") {
          // for (Usersjsa user in filteredUsers) {
          rows.add(
            PlutoRow(
              cells: {
                'ID_Column': PlutoCell(value: user.userFk),
                'NAME_Column':
                    PlutoCell(value: "${user.name} ${user.lastName}"),
                'ROLE_Column': PlutoCell(value: user.role!.name),
                'STATUS_Column': PlutoCell(value: user.status!.status),
              },
            ),
          );
          if (user.status!.status == "Signed") {
            signedUsers++;
          }
        }
      }
    } catch (e) {
      print('Error en getInformationJSA() - $e');
    }
    // notifyListeners();
  }

  void filterDocuments(String query) {
    listJSAFiltered = listJSA
        .where((document) =>
            document.docName!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    print("La lista listJSAFiltered: ${searchController.text}");
  }
}
