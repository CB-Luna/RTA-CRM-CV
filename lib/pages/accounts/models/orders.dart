import 'package:pluto_grid/pluto_grid.dart';

class QuoteOrder {
  QuoteOrder({
    required this.rowId,
    required this.orderType,
    required this.type,
    required this.existingCircuitID,
    required this.newCircuitID,
    required this.dataCenterType,
    required this.dataCenterLocation,
    required this.circuitType,
    required this.evcodType,
    required this.evcodCircuitID,
    required this.ddos,
    required this.bgp,
    required this.ipAdress,
    required this.ipInterface,
    required this.ipSubnet,
    /* required this.lineIten,
    required this.unitPrice,
    required this.unitCost,
    required this.quantity, */
    required this.items,
    this.stateManager,
    /*  'rowId': row.sortIdx,
              'orderType': row.cells['ORDER_TYPE_Column']!.value.toString(),
              'type': row.cells['TYPE_Column']!.value.toString(),
              'existingCircuitID': row.cells['EXISTING_CIRCUIT_Column']!.value.toString(),
              'newCircuitID': row.cells['NEW_CIRCUIT_Column']!.value.toString(),
              'dataCenterType': row.cells['DATA_CENTER_TYPE_Column']!.value.toString(),
              'dataCenterLocation': row.cells['DATA_CENTER_LOCATION_Column']!.value.toString(),
              ////////////////////////////////////////////////////////////////////
              'circuitType': row.cells['CIRCUIT_TYPE_Column']!.value.toString(),
              'evcodType': row.cells['EVCOD_TYPE_Column']!.value.toString(),
              'evcodCircuitID': row.cells['CIRCUIT_ID_Column']!.value.toString(),
              'ddos': row.cells['DDOS_Column']!.value.toString(),
              'bgp': row.cells['BGP_Column']!.value.toString(),
              'ipAdress': row.cells['IP_ADRESS_Column']!.value.toString(),
              'ipInterface': row.cells['IP_INTERFACE_Column']!.value.toString(),
              'ipSubnet': row.cells['IP_SUBNET_Column']!.value.toString(),
              ////////////////////////////////////////////////////////////////////
              'lineIten': row.cells['LINE_ITEM_Column']!.value.toString(),
              'unitPrice': row.cells['UNIT_PRICE_Column']!.value,
              'unitCost': row.cells['UNIT_COST_Column']!.value,
              'quantity': row.cells['QUANTITY_Column']!.value, */
    this.expanded = false,
  });

  int rowId;
  String orderType;
  String type;
  String existingCircuitID;
  String newCircuitID;
  String dataCenterType;
  String dataCenterLocation;
  String circuitType;
  String evcodType;
  String evcodCircuitID;
  String ddos;
  String bgp;
  String ipAdress;
  String ipInterface;
  String ipSubnet;
  /*  String lineIten;
  double unitPrice;
  double unitCost;
  int quantity;  */
  PlutoGridStateManager? stateManager;
  List<PlutoRow> items;

  bool expanded;
}
