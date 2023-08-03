import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart' hide State;
import 'package:pdfx/pdfx.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/crm/accounts/quotes_model.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_circuit_types.dart';
import 'package:rta_crm_cv/models/crm/catalogos/model_cat_vendor_model.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class OrdersProvider extends ChangeNotifier {
  final searchController = TextEditingController();
  List<PlutoRow> rows = [];
  List<String> vendorsList = [];
  PlutoGridStateManager? stateManager;
  bool editmode = false;
  int pageRowCount = 10;
  int page = 1;
  late int? id;
  DateTime create = DateTime.now();
  double slydervalue = 0, min = 0, max = 100;

  final newDataCenterController = TextEditingController();
  late String dataCenterSelectedValue;
  final existingCircuitIDController = TextEditingController();
  final newCircuitIDController = TextEditingController();
  final existingEVCController = TextEditingController();
  List<String> orderTypesList = ['Internal Circuit', 'External Customer'];
  late String orderTypesSelectedValue;
  List<String> typesList = ['New', 'Disconnect', 'Upgrade'];
  late String typesSelectedValue;
  List<String> dataCentersList = [
    'Austin - Logix',
    'Austin – Data Foundry',
    'Chicago - Equinix',
    'Chicago - Naperville',
    'Dallas',
    'Denver',
    'Helena',
    'Houston - Logix',
    'Houston – Data Foundry',
    'Salt Lake',
    'San Antonio',
    'Seattle',
    'St. Louis',
    'New'
  ];
  String vendorSelectedValue = '';
  List<String> circuitInfosList = ['NNI', 'DIA', 'CIR', 'Port Size', 'Multicast Required', 'Cross-Connect', 'EVCoD'];
  List<CatCircuitTypes> circuitTypeList = [CatCircuitTypes(name: 'NNI')];
  late String circuitTypeSelectedValue;
  List<String> ddosList = ['Yes', 'No'];
  late String ddosSelectedValue;
  List<String> evcodList = ['No', 'New', 'Existing EVC'];
  late String evcodSelectedValue;
  List<String> bgpList = ['No', 'IPv4', 'IPv6', 'Current ASN(s)'];
  late String bgpSelectedValue;
  List<String> ipAdressList = ['Interface', 'IP Subnet'];
  late String ipAdressSelectedValue;
  List<String> ipInterfaceList = ['IPv4', 'IPv6'];
  late String ipInterfaceSelectedValue;
  List<String> subnetList = ['No', 'IPv4', 'IPv6'];
  late String subnetSelectedValue;
//Listas DropdownMenu

  late String selectSaleStoreValue, selectAssignedTValue, selectLeadSourceValue;
  List<String> saleStoreList = [
    '',
    'None',
    'Mike Haddock',
    'Rosalia Silvey',
    'Tom Carrol',
    'Vini Garcia',
  ];
  List<String> assignedList = [
    '',
    'Frank Befera',
    'Rosalia Silvey',
    'Tom Carrol',
    'Mike Haddock',
  ];
  List<String> leadSourceList = [
    '',
    'Social Media',
    'Campain',
    'TV',
    'Email',
    'Web',
  ];

  void selectDataCenter(String selected) {
    dataCenterSelectedValue = selected;
    newDataCenterController.clear();
    notifyListeners();
  }

  void selectSaleStore(String selected) {
    selectSaleStoreValue = selected;
    notifyListeners();
  }

  void selectAssigned(String selected) {
    selectAssignedTValue = selected;
    notifyListeners();
  }

  void selectLeadSource(String selected) {
    selectLeadSourceValue = selected;
    notifyListeners();
  }

////////////////////////////////////////////////////////////////////////////
  OrdersProvider() {
    clearAll();
    updateState();
  }

  clearAll() {
    id = 0;
    editmode = false;
    create = DateTime.now();
    slydervalue = 0;

    dataCenterSelectedValue = dataCentersList.first;
    selectSaleStoreValue = saleStoreList.first;
    selectAssignedTValue = assignedList.first;
    selectLeadSourceValue = leadSourceList.first;

    orderTypesSelectedValue = orderTypesList.first;
    typesSelectedValue = typesList.first;
    dataCenterSelectedValue = dataCentersList.first;
    circuitTypeSelectedValue = circuitInfosList.first;
    evcodSelectedValue = evcodList.first;
    ddosSelectedValue = ddosList.first;
    bgpSelectedValue = bgpList.first;
    ipAdressSelectedValue = ipAdressList.first;
    ipInterfaceSelectedValue = ipInterfaceList.first;
    subnetSelectedValue = subnetList.first;
  }

  Future<void> updateState() async {
    rows.clear();
    await getData();
    await clearAll();
  }

  List<bool> tabBar = [
    false,
    false,
    true,
    false,
    false,
  ];
////////////////////////////////////////////////////////////////////////////

  Future<void> selectdate(
    BuildContext context,
  ) async {
    DateTime? newDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppTheme.of(context).primaryColor, // color Appbar
                onPrimary: AppTheme.of(context).primaryBackground, // Color letras
                onSurface: AppTheme.of(context).primaryColor, // Color Meses
              ),
              dialogBackgroundColor: AppTheme.of(context).primaryBackground,
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: create,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (newDate == null) return;
    create = newDate;
    notifyListeners();
  }

  Future<void> createOrder() async {
    try {
      //Registrar al usuario con una contraseña temporal
      var resp = (await supabaseCRM.from('leads').insert({
        "probability": slydervalue.toString(),
        "expected_close": create.toString(),
        "assigned_to": selectAssignedTValue,
        "status": "In process",
        "sales_stage": selectSaleStoreValue,
        "lead_source": selectLeadSourceValue,
      }).select())[0];

      await supabaseCRM.from('leads_history').insert({
        "user": currentUser!.id,
        "action": 'INSERT',
        "description": 'New Lead created',
        "table": 'leads',
        "id_table": resp["id"].toString(),
        "name": "${currentUser!.name} ${currentUser!.lastName}"
      });
    } catch (e) {
      log('Error en registrarOpportunity() - $e');
    }
  }

  Future<void> getData() async {
    if (id != 0) {
      var responseQuote = await supabaseCRM.from('quotes_view').select().eq('id', id);

      if (responseQuote == null) {
        log('Error en getData()-DetailQuoteProvider');
        return;
      }

      Quotes quote = Quotes.fromJson(jsonEncode(responseQuote[0]));

      orderTypesSelectedValue = quote.orderInfo.orderType;
      typesSelectedValue = quote.orderInfo.type;
      if (quote.orderInfo.type == 'New') {
        newCircuitIDController.text = quote.orderInfo.newCircuitId!;
      } else if (quote.orderInfo.type == 'Disconnect') {
        existingCircuitIDController.text = quote.orderInfo.existingCircuitId!;
      } else if (quote.orderInfo.type == 'Upgrade') {
        existingCircuitIDController.text = quote.orderInfo.existingCircuitId!;
        newCircuitIDController.text = quote.orderInfo.newCircuitId!;
      }

      if (quote.orderInfo.dataCenterType == 'New') {
        dataCenterSelectedValue = 'New';
        newDataCenterController.text = quote.orderInfo.dataCenterLocation;
      } else {
        dataCenterSelectedValue = quote.orderInfo.dataCenterLocation;
      }

      await getVendors();
      var responseVendor = await supabaseCRM.from('cat_vendors').select().eq('id', quote.idVendor);
      Vendor vendor = Vendor.fromJson(jsonEncode(responseVendor[0]));
      vendorSelectedValue = vendor.vendorName!;

      circuitTypeSelectedValue = quote.orderInfo.circuitType;
      if (quote.orderInfo.circuitType == 'EVCoD') {
        evcodSelectedValue = quote.orderInfo.evcodType!;
        if (quote.orderInfo.evcodType == 'Existing EVC') {
          existingEVCController.text = quote.orderInfo.evcCircuitId!;
        }
      }

      ddosSelectedValue = quote.orderInfo.ddosType;
      bgpSelectedValue = quote.orderInfo.bgpType;

      ipAdressSelectedValue = quote.orderInfo.ipType;
      if (quote.orderInfo.ipType == 'Interface') {
        ipInterfaceSelectedValue = quote.orderInfo.interfaceType!;
      } else {
        subnetSelectedValue = quote.orderInfo.subnetType!;
      }

      notifyListeners();
    }
  }

  Future<void> getVendors() async {
    var response = await supabaseCRM.from('cat_vendors').select();

    List<Vendor> vendors = (response as List<dynamic>).map((vendor) => Vendor.fromJson(jsonEncode(vendor))).toList();

    vendorsList.clear();
    for (var vendor in vendors) {
      vendorsList.add(vendor.vendorName!);
    }
    notifyListeners();
  }

  Future setIndex(int index) async {
    for (var i = 0; i < tabBar.length; i++) {
      tabBar[i] = false;
    }
    tabBar[index] = true;

    notifyListeners();
  }

//Controladores Paginado Pluto?
  void clearControllers({bool notify = true}) {
    searchController.clear();

    if (notify) notifyListeners();
  }

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

  void load() {
    stateManager!.setShowLoading(true);
  }

  bool popupVisorPdfVisible = true;
  FilePickerResult? docProveedor;
  PdfController? pdfController;

  void verPdf(bool visible) {
    popupVisorPdfVisible = visible;
    notifyListeners();
  }

  Uint8List? imageBytes;
  Future<void> pickProveedorDoc() async {
    FilePickerResult? picker = await FilePickerWeb.platform.pickFiles(type: FileType.custom, allowedExtensions: ['jpg', 'png']);
    //get and load pdf
    if (picker != null) {
      docProveedor = picker;
      imageBytes = picker.files.single.bytes;
    } else {
      imageBytes = null;
    }

    notifyListeners();
    return;
  }
}
