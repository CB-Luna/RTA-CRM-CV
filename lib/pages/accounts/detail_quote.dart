import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/date_format.dart';
import 'package:rta_crm_cv/functions/money_format.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/pages/accounts/tabs/table_top_text.dart';
import 'package:rta_crm_cv/providers/accounts/detail_quote_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown.dart';
import 'package:rta_crm_cv/widgets/captura/custom_tab_button.dart';
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

    double cardHeight = 2.5;

    DetailQuoteProvider provider = Provider.of<DetailQuoteProvider>(context);
    if (provider.globalRows.isEmpty || provider.id == null) {
      context.pushReplacement(routeProspects);
    }

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
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomCard(
                    title: 'Quote Edit',
                    height: MediaQuery.of(context).size.height - 20,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / cardHeight + 20,
                          width: MediaQuery.of(context).size.width - 30,
                          child: SingleChildScrollView(
                            clipBehavior: Clip.antiAlias,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                CustomCard(
                                  height: MediaQuery.of(context).size.height / cardHeight,
                                  width: MediaQuery.of(context).size.width / 5,
                                  title: 'Order Info',
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: CustomDDownMenu(
                                          list: provider.orderTypesList,
                                          label: 'Order Type',
                                          onChanged: (p0) {
                                            // if (p0 != null) provider.selectOT(p0);
                                          },
                                          dropdownValue: provider.orderTypesSelectedValue,
                                          icon: Icons.file_copy_outlined,
                                          width: txfFieldWidth,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: CustomDDownMenu(
                                          list: provider.typesList,
                                          dropdownValue: provider.typesSelectedValue,
                                          onChanged: (p0) {
                                            // if (p0 != null) provider.selectType(p0);
                                          },
                                          icon: Icons.file_copy_outlined,
                                          label: 'Type',
                                          width: txfFieldWidth,
                                        ),
                                      ),
                                      if (provider.typesSelectedValue == 'Disconnect' || provider.typesSelectedValue == 'Upgrade')
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomTextField(
                                            enabled: false,
                                            width: txfFieldWidth,
                                            controller: provider.existingCircuitIDController,
                                            label: 'Existing Circuit ID',
                                            icon: Icons.cable_outlined,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      if (provider.typesSelectedValue == 'Upgrade')
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomTextField(
                                            enabled: false,
                                            width: txfFieldWidth,
                                            controller: provider.newCircuitIDController,
                                            label: 'New Circuit ID',
                                            icon: Icons.cable_outlined,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: CustomDDownMenu(
                                          list: provider.dataCentersList,
                                          dropdownValue: provider.dataCenterSelectedValue,
                                          onChanged: (p0) {
                                            // if (p0 != null) provider.selectDataCenter(p0);
                                          },
                                          icon: Icons.location_on_outlined,
                                          label: 'Data Center Location',
                                          width: txfFieldWidth,
                                        ),
                                      ),
                                      if (provider.dataCenterSelectedValue == 'New')
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomTextField(
                                            enabled: false,
                                            width: txfFieldWidth,
                                            controller: provider.newDataCenterController,
                                            label: 'New Data Center',
                                            icon: Icons.location_on_outlined,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: CustomCard(
                                    height: MediaQuery.of(context).size.height / cardHeight,
                                    width: MediaQuery.of(context).size.width / 5,
                                    title: 'Circuit Info',
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomDDownMenu(
                                            list: provider.circuitInfosList,
                                            dropdownValue: provider.circuitTypeSelectedValue,
                                            onChanged: (p0) {
                                              // if (p0 != null) provider.selectCircuitInfo(p0);
                                            },
                                            icon: Icons.info_outline,
                                            label: 'Circuit Type',
                                            width: txfFieldWidth,
                                          ),
                                        ),
                                        if (provider.circuitTypeSelectedValue == 'EVCoD')
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: CustomDDownMenu(
                                              list: provider.evcodList,
                                              dropdownValue: provider.evcodSelectedValue,
                                              onChanged: (p0) {
                                                // if (p0 != null) provider.selectEVCOD(p0);
                                              },
                                              icon: Icons.electrical_services,
                                              label: 'EVCoD',
                                              width: txfFieldWidth,
                                            ),
                                          ),
                                        if (provider.evcodSelectedValue == 'Existing EVC')
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: CustomTextField(
                                              enabled: false,
                                              width: txfFieldWidth,
                                              controller: provider.existingEVCController,
                                              label: 'Circuit ID',
                                              icon: Icons.electrical_services,
                                              keyboardType: TextInputType.text,
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              CustomTabButton(
                                                on: provider.ddosSelectedValue == 'Yes',
                                                //icon: Icons.security_outlined,
                                                label: 'DDoS Migration',
                                                option1: 'Yes',
                                                option2: 'No',
                                                width: txfFieldWidth / 1.7,
                                                // onTap: () => provider.selectDDOS(),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: CustomDDownMenu(
                                                  list: provider.bgpList,
                                                  dropdownValue: provider.bgpSelectedValue,
                                                  onChanged: (p0) {
                                                    // if (p0 != null) provider.selectBGP(p0);
                                                  },
                                                  icon: Icons.bug_report_outlined,
                                                  label: 'BGP Peering',
                                                  width: txfFieldWidth / 1.6,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            children: [
                                              CustomTabButton(
                                                on: provider.ipAdressSelectedValue == 'Interface',
                                                label: 'IP Adresses',
                                                option1: 'Interface',
                                                option2: 'IP Subnet',
                                                width: txfFieldWidth / 1.7,
                                                // onTap: () => provider.selectIPAdress(),
                                              ),
                                              if (provider.ipAdressSelectedValue == 'Interface')
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: CustomTabButton(
                                                    on: provider.ipInterfaceSelectedValue == 'IPv4',
                                                    label: 'IP Interface',
                                                    option1: 'IPv4',
                                                    option2: 'IPv6',
                                                    width: txfFieldWidth / 2,
                                                    // onTap: () => provider.selectIPInterface(),
                                                  ),
                                                ),
                                              if (provider.ipAdressSelectedValue == 'IP Subnet')
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: CustomDDownMenu(
                                                    list: provider.subnetList,
                                                    dropdownValue: provider.subnetSelectedValue,
                                                    onChanged: (p0) {
                                                      // if (p0 != null) provider.selectSubnet(p0);
                                                    },
                                                    icon: Icons.signal_cellular_alt,
                                                    label: 'IP Subnet',
                                                    width: txfFieldWidth / 1.6,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: CustomCard(
                                    height: MediaQuery.of(context).size.height / cardHeight,
                                    width: MediaQuery.of(context).size.width / 5,
                                    title: 'Customer Info',
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomTextField(
                                            enabled: false,
                                            width: txfFieldWidth,
                                            controller: provider.companyController,
                                            label: 'Company',
                                            icon: Icons.location_city_outlined,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomTextField(
                                            enabled: false,
                                            width: txfFieldWidth,
                                            controller: provider.nameController,
                                            label: 'Name',
                                            icon: Icons.person_outline,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomTextField(
                                            enabled: false,
                                            width: txfFieldWidth,
                                            controller: provider.lastNameController,
                                            label: 'Last Name',
                                            icon: Icons.person_outline,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomTextField(
                                            enabled: false,
                                            width: txfFieldWidth,
                                            controller: provider.emailController,
                                            label: 'Email',
                                            icon: Icons.alternate_email_outlined,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: CustomTextField(
                                            enabled: false,
                                            width: txfFieldWidth,
                                            controller: provider.phoneController,
                                            label: 'Mobile Phone Number',
                                            icon: Icons.phone_outlined,
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: CustomCard(
                                    height: MediaQuery.of(context).size.height / cardHeight,
                                    width: MediaQuery.of(context).size.width / 5,
                                    title: 'Totals',
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          //width: 300,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 130,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10),
                                                        child: Icon(Icons.format_list_numbered, color: AppTheme.of(context).encabezadoTablas.color, size: 25),
                                                      ),
                                                      Text(
                                                        'Items',
                                                        style: AppTheme.of(context).encabezadoTablas,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                  child: Text(
                                                    ':',
                                                    style: AppTheme.of(context).encabezadoTablas,
                                                  ),
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                    moneyFormat(provider.globalRows.length.toDouble()).substring(0, moneyFormat(provider.globalRows.length.toDouble()).length - 3),
                                                    style: AppTheme.of(context).encabezadoTablas,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          //width: MediaQuery.of(context).size.width / 5 - 150,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 130,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10),
                                                        child: Icon(Icons.attach_money, color: AppTheme.of(context).encabezadoTablas.color, size: 25),
                                                      ),
                                                      Text(
                                                        'Subtotal',
                                                        style: AppTheme.of(context).encabezadoTablas,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                  child: Text(
                                                    ':',
                                                    style: AppTheme.of(context).encabezadoTablas,
                                                  ),
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                    '\$ ${moneyFormat(provider.subtotal)} USD',
                                                    style: AppTheme.of(context).encabezadoTablas,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          //width: MediaQuery.of(context).size.width / 5 - 150,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 130,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10),
                                                        child: Icon(Icons.money_off, color: AppTheme.of(context).encabezadoTablas.color, size: 25),
                                                      ),
                                                      Text(
                                                        'Cost',
                                                        style: AppTheme.of(context).encabezadoTablas,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                  child: Text(
                                                    ':',
                                                    style: AppTheme.of(context).encabezadoTablas,
                                                  ),
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                    '\$ ${moneyFormat(provider.cost)} USD',
                                                    style: AppTheme.of(context).encabezadoTablas,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          //width: MediaQuery.of(context).size.width / 5 - 150,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 130,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10),
                                                        child: Icon(Icons.monetization_on_outlined, color: AppTheme.of(context).encabezadoTablas.color, size: 25),
                                                      ),
                                                      Text(
                                                        'Total',
                                                        style: AppTheme.of(context).encabezadoTablas,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                  child: Text(
                                                    ':',
                                                    style: AppTheme.of(context).encabezadoTablas,
                                                  ),
                                                ),
                                                SizedBox(
                                                  child: Text(
                                                    '\$ ${moneyFormat(provider.total)} USD',
                                                    style: AppTheme.of(context).encabezadoTablas,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          //width: MediaQuery.of(context).size.width / 5 - 150,
                                          decoration: BoxDecoration(
                                            color: provider.margin < 20 ? secondaryColor : AppTheme.of(context).primaryColor,
                                            borderRadius: const BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  width: 130,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 10),
                                                        child: Icon(Icons.percent, color: AppTheme.of(context).primaryBackground, size: 25),
                                                      ),
                                                      Text(
                                                        'Margin',
                                                        style: TextStyle(
                                                            fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                                                            fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                                                            fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                                                            fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                                                            color: AppTheme.of(context).primaryBackground),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
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
                                                SizedBox(
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
                          ),
                        ),
                        /*  Padding(
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
                                    enabled: false,
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
                                    enabled: false,
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
                                    enabled: false,
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
                                    enabled: false,
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
                                  child: CustomTextIconButton(isLoading: false,
                                      icon: Icon(Icons.add, color: AppTheme.of(context).primaryBackground),
                                      text: 'Add',
                                      onTap: () {
                                        if (provider.isValidated()) {
                                          provider.addRowPlutoGrid();
                                        }
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: CustomTextIconButton(isLoading: false,
                                    icon: Icon(Icons.refresh, color: AppTheme.of(context).primaryBackground),
                                    text: 'Reset',
                                    onTap: () async => provider.resetFormPlutoGrid(),
                                  ),
                                ),
                                CustomTextIconButton(isLoading: false,
                                  icon: Icon(Icons.check, color: AppTheme.of(context).primaryBackground),
                                  text: 'Create',
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  onTap: () async {
                                    if (provider.createValidation() && provider.globalRows.isNotEmpty) {
                                      await provider.createQuote();
                                      context.pushReplacement(routeQuoteCreation);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        */
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 2.25,
                                width: MediaQuery.of(context).size.width / 1.6 - 10,
                                child: const PlutoGridCotizador(),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: DetailQuoteComments(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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

class DetailQuoteComments extends StatefulWidget {
  const DetailQuoteComments({super.key});

  @override
  State<DetailQuoteComments> createState() => _DetailQuoteCommentsState();
}

class _DetailQuoteCommentsState extends State<DetailQuoteComments> {
  @override
  Widget build(BuildContext context) {
    DetailQuoteProvider provider = Provider.of<DetailQuoteProvider>(context);
    return CustomCard(
      height: MediaQuery.of(context).size.height / 2.25,
      width: MediaQuery.of(context).size.width / 5,
      title: 'Comments',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2.25 - 150,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppTheme.of(context).primaryBackground, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.1,
                blurRadius: 3,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ]),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: provider.comments.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    mainAxisAlignment:
                        provider.comments[index].name == currentUser!.name && provider.comments[index].role == currentUser!.role.roleName ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 5 - 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: provider.comments[index].name == currentUser!.name && provider.comments[index].role == currentUser!.role.roleName
                                      ? AppTheme.of(context).secondaryColor
                                      : AppTheme.of(context).primaryColor),
                              color: AppTheme.of(context).primaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.1,
                                  blurRadius: 3,
                                  offset: const Offset(0, 0), // changes position of shadow
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
                                    color: provider.comments[index].name == currentUser!.name && provider.comments[index].role == currentUser!.role.roleName
                                        ? AppTheme.of(context).secondaryColor
                                        : AppTheme.of(context).primaryColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30, top: 5, bottom: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${provider.comments[index].role} - ${provider.comments[index].name}',
                                          style: TextStyle(color: AppTheme.of(context).primaryBackground),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Text(provider.comments[index].comment),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            dateFormat(provider.comments[index].sended, true),
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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 5 - 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomTextField(
                    height: 48,
                    enabled: true,
                    controller: provider.commentController,
                    icon: Icons.comment_outlined,
                    label: 'Comment',
                    keyboardType: TextInputType.text,
                    width: (MediaQuery.of(context).size.width / 5 - 20) - 100,
                    // onDone: provider.addComment(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: CustomTextIconButton(
                      isLoading: false,
                      height: 48,
                      icon: Icon(
                        Icons.send,
                        color: AppTheme.of(context).primaryBackground,
                      ),
                      text: 'Send',
                      onTap: () async => await provider.addComment(),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
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
                                    /* PlutoColumn(
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
                                              child: CustomTextIconButton(isLoading: false,
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
                                    ), */
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

class PlutoGridCotizador extends StatefulWidget {
  const PlutoGridCotizador({super.key});

  @override
  State<PlutoGridCotizador> createState() => _PlutoGridCotizadorState();
}

class _PlutoGridCotizadorState extends State<PlutoGridCotizador> {
  @override
  Widget build(BuildContext context) {
    // double txfFieldPadding = 10;

    DetailQuoteProvider provider = Provider.of<DetailQuoteProvider>(context);
    return PlutoGrid(
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
              child: Center(child: Text(rendererContext.cell.value != null ? rendererContext.cell.value.toString() : '-')),
            );
          },
        ),
        /*  PlutoColumn(
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
                  child: CustomTextIconButton(isLoading: false,
                    icon: Icon(Icons.shopping_basket_outlined, color: AppTheme.of(context).primaryBackground),
                    text: 'Delete',
                    color: secondaryColor,
                    onTap: () {
                      setState(() {
                        provider.globalRows.removeAt(rendererContext.rowIdx);
                      });
                      provider.countRowsPlutoGrid();
                    },
                  ),
                ),
              ),
            );
          },
        ), */
      ],
      rows: provider.globalRows,
      onLoaded: (event) async {
        provider.listStateManager.add(event.stateManager);
      },
    );
  }
}
