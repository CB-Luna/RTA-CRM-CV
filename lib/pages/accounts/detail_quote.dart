import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/money_format.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/pages/accounts/tabs/table_top_text.dart';
import 'package:rta_crm_cv/providers/accounts/detail_quote_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

class DetailQuotePage extends StatefulWidget {
  const DetailQuotePage({super.key});

  @override
  State<DetailQuotePage> createState() => _DetailQuotePageState();
}

class _DetailQuotePageState extends State<DetailQuotePage> {
  @override
  Widget build(BuildContext context) {
    double txfFieldWidth = (MediaQuery.of(context).size.width / 7);
    // double txfFieldPadding = 10;

    DetailQuoteProvider provider = Provider.of<DetailQuoteProvider>(context);

    return Material(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SideMenu(),
            Expanded(
              child: Container(
                decoration: BoxDecoration(gradient: whiteGradient),
                child: CustomCard(
                  title: 'Quote Detail',
                  height: MediaQuery.of(context).size.height - 20,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.9,
                        width: MediaQuery.of(context).size.width - 30,
                        child: SingleChildScrollView(
                          clipBehavior: Clip.antiAlias,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CustomCard(
                                height: MediaQuery.of(context).size.height / 2,
                                width: MediaQuery.of(context).size.width / 5,
                                title: 'Cost',
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height / 2 - 100,
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width / 10,
                                            child: RichText(
                                              text: TextSpan(
                                                style: AppTheme.of(context).encabezadoTablas,
                                                children: const [
                                                  TextSpan(text: 'Cost: '),
                                                  TextSpan(text: '-----'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                ':',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                ':',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                ':',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                ':',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Container(
                                              color: provider.margin < 20 ? secondaryColor : AppTheme.of(context).primaryColor,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  ':',
                                                  style: TextStyle(
                                                      fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                                                      fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                                                      fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                                                      fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                                                      color: AppTheme.of(context).primaryBackground),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                provider.quotes.length.toString(),
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                '\$ ${moneyFormat(provider.subtotal)} USD',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                '\$ ${moneyFormat(provider.cost)} USD',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                '\$ ${moneyFormat(provider.total)} USD',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: provider.margin < 20 ? secondaryColor : AppTheme.of(context).primaryColor,
                                                borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomRight: Radius.circular(15),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  '${moneyFormat(provider.margin)}%',
                                                  style: TextStyle(
                                                      fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                                                      fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                                                      fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                                                      fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                                                      color: AppTheme.of(context).primaryBackground),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CustomCard(
                                height: MediaQuery.of(context).size.height / 2,
                                width: MediaQuery.of(context).size.width / 5,
                                title: 'Comments',
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height / 2 - 100,
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: SizedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  'Quotes',
                                                  style: AppTheme.of(context).encabezadoTablas,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: SizedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  'Subtotal',
                                                  style: AppTheme.of(context).encabezadoTablas,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: SizedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  'Cost',
                                                  style: AppTheme.of(context).encabezadoTablas,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: SizedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  'Total',
                                                  style: AppTheme.of(context).encabezadoTablas,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: provider.margin < 20 ? secondaryColor : AppTheme.of(context).primaryColor,
                                                borderRadius: const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomLeft: Radius.circular(15),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  'Margin',
                                                  style: TextStyle(
                                                      fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                                                      fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                                                      fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                                                      fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                                                      color: AppTheme.of(context).primaryBackground),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                ':',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                ':',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                ':',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                ':',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Container(
                                              color: provider.margin < 20 ? secondaryColor : AppTheme.of(context).primaryColor,
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  ':',
                                                  style: TextStyle(
                                                      fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                                                      fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                                                      fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                                                      fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                                                      color: AppTheme.of(context).primaryBackground),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                provider.quotes.length.toString(),
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                '\$ ${moneyFormat(provider.subtotal)} USD',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                '\$ ${moneyFormat(provider.cost)} USD',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                '\$ ${moneyFormat(provider.total)} USD',
                                                style: AppTheme.of(context).encabezadoTablas,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: provider.margin < 20 ? secondaryColor : AppTheme.of(context).primaryColor,
                                                borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomRight: Radius.circular(15),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Text(
                                                  '${moneyFormat(provider.margin)}%',
                                                  style: TextStyle(
                                                      fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                                                      fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                                                      fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                                                      fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                                                      color: AppTheme.of(context).primaryBackground),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          height: 35,
                          width: MediaQuery.of(context).size.width - 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTextField(
                                  enabled: true,
                                  width: txfFieldWidth,
                                  controller: provider.lineItemCenterController,
                                  label: 'Line Item',
                                  icon: Icons.local_offer_outlined,
                                  keyboardType: TextInputType.text,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTextField(
                                  enabled: true,
                                  width: txfFieldWidth,
                                  controller: provider.unitPriceController,
                                  label: 'Unit Price',
                                  icon: Icons.attach_money_outlined,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTextField(
                                  enabled: true,
                                  width: txfFieldWidth,
                                  controller: provider.unitCostController,
                                  label: 'Unit Cost',
                                  icon: Icons.price_check_outlined,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTextField(
                                  enabled: true,
                                  width: txfFieldWidth,
                                  controller: provider.quantityController,
                                  label: 'Quantity',
                                  icon: Icons.shopping_cart_outlined,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTextIconButton(
                                  icon: Icon(Icons.add, color: AppTheme.of(context).primaryBackground),
                                  text: 'Add',
                                  onTap: () => provider.isValidated(),
                                ),
                              ),
                              CustomTextIconButton(
                                icon: Icon(Icons.remove, color: AppTheme.of(context).primaryBackground),
                                text: 'Reset',
                                onTap: () => provider.resetForm(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width - 20,
                        child: const ExpansionPanelListCotizador(),
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

class ExpansionPanelListCotizador extends StatefulWidget {
  const ExpansionPanelListCotizador({super.key});

  @override
  State<ExpansionPanelListCotizador> createState() => _ExpansionPanelListCotizadorState();
}

class _ExpansionPanelListCotizadorState extends State<ExpansionPanelListCotizador> {
  @override
  Widget build(BuildContext context) {
    // double txfFieldPadding = 10;

    DetailQuoteProvider provider = Provider.of<DetailQuoteProvider>(context);
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TableTopText(
                text: 'Order Info',
                style: AppTheme.of(context).contenidoTablas,
                group: provider.tableTopGroup,
              ),
            ),
            Expanded(
              child: TableTopText(
                text: 'Circuit Info',
                style: AppTheme.of(context).contenidoTablas,
                group: provider.tableTopGroup,
              ),
            ),
            Expanded(
              child: TableTopText(
                text: 'DDOS Migration',
                style: AppTheme.of(context).contenidoTablas,
                group: provider.tableTopGroup,
              ),
            ),
            Expanded(
              child: TableTopText(
                text: 'BGP Perring',
                style: AppTheme.of(context).contenidoTablas,
                group: provider.tableTopGroup,
              ),
            ),
            Expanded(
              child: TableTopText(
                text: 'IP Info',
                style: AppTheme.of(context).contenidoTablas,
                group: provider.tableTopGroup,
              ),
            ),
            const SizedBox(width: 50),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: provider.quotes.length,
            itemBuilder: (context, index) {
              return ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.zero,
                elevation: 0,
                expansionCallback: ((panelIndex, isExpanded) {
                  setState(() {
                    provider.quotes[index].expanded = !isExpanded;
                  });
                }),
                children: [
                  ExpansionPanel(
                    canTapOnHeader: true,
                    isExpanded: provider.quotes[index].expanded,
                    headerBuilder: (context, expanded) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: provider.quotes[index].expanded == true
                              ? AppTheme.of(context).primaryColor
                              : AppTheme.of(context).primaryBackground == Colors.white
                                  ? AppTheme.of(context).secondaryText
                                  : Colors.grey,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TableTopText(
                                    text: '${provider.quotes[index].type} - ${provider.quotes[index].orderType}',
                                    style: AppTheme.of(context).contenidoTablas,
                                    group: provider.tableTopGroup,
                                  ),
                                  if (provider.quotes[index].type == 'Disconnect') Text('ID: ${provider.quotes[index].existingCircuitID}'),
                                  if (provider.quotes[index].type == 'Upgrade')
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(text: 'Existing ID: ', style: TextStyle(color: Colors.red)),
                                          TextSpan(text: provider.quotes[index].existingCircuitID),
                                          const TextSpan(text: ' - '),
                                          const TextSpan(text: 'New ID: ', style: TextStyle(color: Colors.green)),
                                          TextSpan(text: provider.quotes[index].newCircuitID),
                                        ],
                                      ),
                                    ),
                                  TableTopText(
                                    text: provider.quotes[index].dataCenterLocation,
                                    style: AppTheme.of(context).contenidoTablas,
                                    group: provider.tableTopGroup,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  if (provider.quotes[index].circuitType != 'EVCoD')
                                    TableTopText(
                                      text: provider.quotes[index].circuitType,
                                      style: AppTheme.of(context).contenidoTablas,
                                      group: provider.tableTopGroup,
                                    ),
                                  if (provider.quotes[index].circuitType == 'EVCoD')
                                    TableTopText(
                                      text: '${provider.quotes[index].circuitType} - ${provider.quotes[index].evcodType}',
                                      style: AppTheme.of(context).contenidoTablas,
                                      group: provider.tableTopGroup,
                                    ),
                                  if (provider.quotes[index].evcodType == 'Existing EVC')
                                    TableTopText(
                                      text: 'EVCoD ID: ${provider.quotes[index].evcodCircuitID}',
                                      style: AppTheme.of(context).contenidoTablas,
                                      group: provider.tableTopGroup,
                                    ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: TableTopText(
                                  text: provider.quotes[index].ddos,
                                  style: AppTheme.of(context).contenidoTablas,
                                  group: provider.tableTopGroup,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: TableTopText(
                                  text: provider.quotes[index].bgp,
                                  style: AppTheme.of(context).contenidoTablas,
                                  group: provider.tableTopGroup,
                                ),
                              ),
                            ),
                            if (provider.quotes[index].ipAdress == 'Interface')
                              Expanded(
                                child: Center(
                                  child: TableTopText(
                                    text: '${provider.quotes[index].ipAdress} - ${provider.quotes[index].ipInterface}',
                                    style: AppTheme.of(context).contenidoTablas,
                                    group: provider.tableTopGroup,
                                  ),
                                ),
                              ),
                            if (provider.quotes[index].ipAdress == 'IP Subnet')
                              Expanded(
                                child: Center(
                                  child: TableTopText(
                                    text: '${provider.quotes[index].ipAdress} - ${provider.quotes[index].ipSubnet}',
                                    style: AppTheme.of(context).contenidoTablas,
                                    group: provider.tableTopGroup,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                    body: Column(
                      children: [
                        SizedBox(
                          height: 285,
                          child: Row(
                            children: [
                              Expanded(
                                child: PlutoGrid(
                                  key: UniqueKey(),
                                  configuration: PlutoGridConfiguration(
                                    scrollbar: plutoGridScrollbarConfig(context),
                                    style: plutoGridStyleConfig(context),
                                    columnFilter: PlutoGridColumnFilterConfig(
                                      filters: const [
                                        ...FilterHelper.defaultFilters,
                                      ],
                                      resolveDefaultColumnFilter: (column, resolver) {
                                        if (column.field == 'LINE_ITEM_Column') {
                                          return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                        } else if (column.field == 'UNIT_PRICE_Column') {
                                          return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                        } else if (column.field == 'UNIT_COST_Column') {
                                          return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                        } else if (column.field == 'QUANTITY_Column') {
                                          return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                        }
                                        return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                                      },
                                    ),
                                  ),
                                  columns: [
                                    PlutoColumn(
                                      titleSpan: TextSpan(children: [
                                        WidgetSpan(child: Icon(Icons.local_offer_outlined, color: AppTheme.of(context).primaryBackground)),
                                        const WidgetSpan(child: SizedBox(width: 10)),
                                        TextSpan(text: 'Line Item', style: TextStyle(color: AppTheme.of(context).primaryBackground))
                                      ]),
                                      backgroundColor: const Color(0XFF6491F7),
                                      title: 'LINE ITEM',
                                      field: 'LINE_ITEM_Column',
                                      width: 225,
                                      titleTextAlign: PlutoColumnTextAlign.start,
                                      textAlign: PlutoColumnTextAlign.center,
                                      type: PlutoColumnType.text(),
                                      enableEditingMode: false,
                                      cellPadding: EdgeInsets.zero,
                                      renderer: (rendererContext) {
                                        return Container(
                                          height: rowHeight,
                                          width: rendererContext.cell.column.width,
                                          decoration: BoxDecoration(gradient: whiteGradient),
                                          child: Center(child: Text(rendererContext.cell.value ?? '-')),
                                        );
                                      },
                                    ),
                                    PlutoColumn(
                                      titleSpan: TextSpan(children: [
                                        WidgetSpan(child: Icon(Icons.attach_money_outlined, color: AppTheme.of(context).primaryBackground)),
                                        const WidgetSpan(child: SizedBox(width: 10)),
                                        TextSpan(text: 'Unit Price', style: TextStyle(color: AppTheme.of(context).primaryBackground))
                                      ]),
                                      backgroundColor: const Color(0XFF6491F7),
                                      title: 'UNIT PRICE',
                                      field: 'UNIT_PRICE_Column',
                                      width: 225,
                                      titleTextAlign: PlutoColumnTextAlign.start,
                                      textAlign: PlutoColumnTextAlign.center,
                                      type: PlutoColumnType.number(),
                                      enableEditingMode: false,
                                      cellPadding: EdgeInsets.zero,
                                      renderer: (rendererContext) {
                                        return Container(
                                          height: rowHeight,
                                          width: rendererContext.cell.column.width,
                                          decoration: BoxDecoration(gradient: whiteGradient),
                                          child: Center(child: Text('\$ ${moneyFormat(rendererContext.cell.value)} USD')),
                                        );
                                      },
                                    ),
                                    PlutoColumn(
                                      titleSpan: TextSpan(children: [
                                        WidgetSpan(child: Icon(Icons.price_check_outlined, color: AppTheme.of(context).primaryBackground)),
                                        const WidgetSpan(child: SizedBox(width: 10)),
                                        TextSpan(text: 'Unit Cost', style: TextStyle(color: AppTheme.of(context).primaryBackground))
                                      ]),
                                      backgroundColor: const Color(0XFF6491F7),
                                      title: 'UNIT COST',
                                      field: 'UNIT_COST_Column',
                                      width: 225,
                                      titleTextAlign: PlutoColumnTextAlign.start,
                                      textAlign: PlutoColumnTextAlign.center,
                                      type: PlutoColumnType.number(),
                                      enableEditingMode: false,
                                      cellPadding: EdgeInsets.zero,
                                      renderer: (rendererContext) {
                                        return Container(
                                          height: rowHeight,
                                          width: rendererContext.cell.column.width,
                                          decoration: BoxDecoration(gradient: whiteGradient),
                                          child: Center(child: Text('\$ ${moneyFormat(rendererContext.cell.value)} USD')),
                                        );
                                      },
                                    ),
                                    PlutoColumn(
                                      titleSpan: TextSpan(children: [
                                        WidgetSpan(child: Icon(Icons.shopping_cart_outlined, color: AppTheme.of(context).primaryBackground)),
                                        const WidgetSpan(child: SizedBox(width: 10)),
                                        TextSpan(text: 'Quantity', style: TextStyle(color: AppTheme.of(context).primaryBackground))
                                      ]),
                                      backgroundColor: const Color(0XFF6491F7),
                                      title: 'QUANTITY',
                                      field: 'QUANTITY_Column',
                                      width: 150,
                                      titleTextAlign: PlutoColumnTextAlign.start,
                                      textAlign: PlutoColumnTextAlign.center,
                                      type: PlutoColumnType.number(),
                                      enableEditingMode: false,
                                      cellPadding: EdgeInsets.zero,
                                      renderer: (rendererContext) {
                                        return Container(
                                          height: rowHeight,
                                          width: rendererContext.cell.column.width,
                                          decoration: BoxDecoration(gradient: whiteGradient),
                                          child: Center(child: Text(rendererContext.cell.value ?? '-'.toString())),
                                        );
                                      },
                                    ),
                                    PlutoColumn(
                                      titleSpan: TextSpan(children: [
                                        WidgetSpan(child: Icon(Icons.settings, color: AppTheme.of(context).primaryBackground)),
                                        const WidgetSpan(child: SizedBox(width: 10)),
                                        TextSpan(text: 'Actions', style: TextStyle(color: AppTheme.of(context).primaryBackground))
                                      ]),
                                      backgroundColor: const Color(0XFF6491F7),
                                      title: 'ACTIONS',
                                      field: 'ACTIONS_Column',
                                      width: 140,
                                      titleTextAlign: PlutoColumnTextAlign.start,
                                      textAlign: PlutoColumnTextAlign.center,
                                      type: PlutoColumnType.text(),
                                      enableEditingMode: false,
                                      cellPadding: EdgeInsets.zero,
                                      renderer: (rendererContext) {
                                        return Container(
                                          height: rowHeight,
                                          width: rendererContext.cell.column.width,
                                          decoration: BoxDecoration(gradient: whiteGradient),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: CustomTextIconButton(
                                                icon: Icon(Icons.shopping_basket_outlined, color: AppTheme.of(context).primaryBackground),
                                                text: 'Delete',
                                                color: secondaryColor,
                                                onTap: () {
                                                  setState(() {
                                                    provider.quotes[index].items.removeAt(rendererContext.rowIdx);
                                                    if (provider.quotes[index].items.isEmpty) {
                                                      provider.quotes.removeAt(index);
                                                    }
                                                  });
                                                  provider.countRows();
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                  rows: provider.quotes[index].items,
                                  onLoaded: (event) async {
                                    provider.listStateManager.add(event.stateManager);
                                    provider.quotes[index].stateManager = event.stateManager;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 65,
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
