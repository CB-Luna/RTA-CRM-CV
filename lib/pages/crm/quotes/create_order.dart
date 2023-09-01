import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/providers/crm/accounts/tabs/order_provider.dart';
import 'package:rta_crm_cv/providers/crm/quote/quotes_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_details.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/success_toast.dart';

class CreateOrder extends StatefulWidget {
  CreateOrder({super.key, required this.id});
  int id;

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  FToast fToast = FToast();
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    OrdersProvider provider = Provider.of<OrdersProvider>(context);
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title:
            '${provider.typesSelectedValue.text} - ${provider.circuitAddressController.text} - ${provider.circuitTypeSelectedValue.text}', //${provider.circuitAddressController.text} 1400 Broadfield Blvd #200, Houston
        height: provider.circuitTypeSelectedValue.text == 'DIA' || provider.circuitTypeSelectedValue.text == 'NNI'
            ? getHeight(280, context)
            : provider.circuitTypeSelectedValue.text == 'X-Connect'
                ? getHeight(495, context)
                : getHeight(800, context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: CustomScrollBar(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if ((provider.typesSelectedValue.text == 'Migration' || provider.typesSelectedValue.text == 'New Circuit' || provider.typesSelectedValue.text == 'Upgrade') &&
                          (provider.circuitTypeSelectedValue.text == 'ASEoD' || provider.circuitTypeSelectedValue.text == 'PTP'))
                        //circuit address
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextField(
                            label: 'Circuit Address',
                            icon: Icons.location_on_outlined,
                            controller: provider.circuitAddressController,
                            enabled: false,
                            width: 350,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      //circuit detail
                      if ((provider.typesSelectedValue.text == 'Migration' || provider.typesSelectedValue.text == 'New Circuit' || provider.typesSelectedValue.text == 'Upgrade') &&
                          (provider.circuitTypeSelectedValue.text == 'ASEoD' || provider.circuitTypeSelectedValue.text == 'PTP'))
                        CustomDetails(
                          title: 'Circuit Detail',
                          icon: Icons.description_sharp,
                          description: provider.circuitDetailController.text,
                        ),
                      //Data center location
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextField(
                          label: 'Data Center Location',
                          icon: Icons.location_on_outlined,
                          controller: provider.dataCenterSelectedValue,
                          enabled: false,
                          width: 350,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      //port size
                      if ((provider.typesSelectedValue.text == 'Migration' || provider.typesSelectedValue.text == 'New Circuit' || provider.typesSelectedValue.text == 'Upgrade') &&
                          (provider.circuitTypeSelectedValue.text == 'ASEoD' || provider.circuitTypeSelectedValue.text == 'PTP'))
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextField(
                            label: 'Port Size',
                            icon: Icons.lan_outlined,
                            controller: provider.portSizeSelectedValue,
                            enabled: false,
                            width: 350,
                            keyboardType: TextInputType.name,
                          ),
                        ),

                      //CIR
                      if ((provider.typesSelectedValue.text == 'Migration' || provider.typesSelectedValue.text == 'New Circuit' || provider.typesSelectedValue.text == 'Upgrade') &&
                          (provider.circuitTypeSelectedValue.text == 'ASEoD' || provider.circuitTypeSelectedValue.text == 'PTP'))
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextField(
                            label: 'CIR',
                            icon: Icons.send_outlined,
                            controller: provider.cirSelectedValue,
                            enabled: false,
                            width: 350,
                            keyboardType: TextInputType.name,
                          ),
                        ),

                      if (provider.typesSelectedValue.text != 'Circuit Removal' && (provider.circuitTypeSelectedValue.text == 'ASEoD' || provider.circuitTypeSelectedValue.text == 'PTP'))
                        //Handoff
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextField(
                            label: 'Handoff',
                            icon: Icons.waving_hand_outlined,
                            controller: provider.handoffSelectedValue,
                            enabled: false,
                            width: 350,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      if (provider.typesSelectedValue.text != 'Circuit Removal' && (provider.circuitTypeSelectedValue.text == 'ASEoD' || provider.circuitTypeSelectedValue.text == 'PTP'))
                        //demarkation point
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomTextField(
                            label: 'Demarkation Point',
                            icon: Icons.pin_drop,
                            controller: provider.demarcationPointController,
                            enabled: false,
                            width: 350,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      if (provider.typesSelectedValue.text != 'Circuit Removal' && (provider.circuitTypeSelectedValue.text == 'ASEoD' || provider.circuitTypeSelectedValue.text == 'PTP'))
                        //demarkation image
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: CustomTextIconButton(
                                  color: provider.titulo != '' ? AppTheme.of(context).primaryColor : AppTheme.of(context).secondaryColor,
                                  isLoading: false,
                                  icon: Icon(
                                    provider.titulo != '' ? Icons.remove_red_eye_outlined : Icons.image_not_supported_outlined,
                                    color: AppTheme.of(context).primaryBackground,
                                  ),
                                  text: provider.titulo != '' ? 'View Image of Demarkation Point' : 'No Image',
                                  onTap: (provider.titulo != '')
                                      ? () async {
                                          await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                content: SizedBox(
                                                  width: getWidth(1000, context),
                                                  height: getHeight(1000, context),
                                                  child: CustomScrollBar(
                                                    scrollDirection: Axis.vertical,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.only(bottom: 20),
                                                          child: CustomTextIconButton(
                                                            isLoading: false,
                                                            icon: Icon(Icons.close, color: AppTheme.of(context).secondaryColor),
                                                            border: Border.all(color: AppTheme.of(context).secondaryColor),
                                                            color: AppTheme.of(context).primaryBackground,
                                                            style: TextStyle(color: AppTheme.of(context).secondaryColor),
                                                            text: 'Exit',
                                                            width: getWidth(60, context),
                                                            onTap: () {
                                                              Navigator.pop(context);
                                                            },
                                                          ),
                                                        ),
                                                        Image.network(provider.titulo)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      : () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      //rack location
                      if (provider.circuitTypeSelectedValue.text == 'NNI' || provider.circuitTypeSelectedValue.text == 'X-Connect')
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CustomTextField(
                            enabled: false,
                            width: 350,
                            controller: provider.rackLocationController,
                            label: 'Rack Location',
                            icon: Icons.not_listed_location_outlined,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      if (provider.circuitTypeSelectedValue.text == 'X-Connect')
                        CustomDetails(
                          title: 'Detail',
                          icon: Icons.details_outlined,
                          description: provider.detailController.text,
                        ),
                      if (provider.circuitTypeSelectedValue.text == 'DIA')
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: CustomTextField(
                            enabled: false,
                            width: 350,
                            controller: provider.bandwidthController,
                            label: 'Bandwidth',
                            icon: Icons.wifi_tethering_outlined,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            //Row Botones Crear
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextIconButton(
                    isLoading: false,
                    icon: Icon(Icons.close, color: AppTheme.of(context).secondaryColor),
                    border: Border.all(color: AppTheme.of(context).secondaryColor),
                    color: AppTheme.of(context).primaryBackground,
                    style: TextStyle(color: AppTheme.of(context).secondaryColor),
                    text: 'Exit',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(width: getWidth(56, context)),
                  CustomTextIconButton(
                    isLoading: false,
                    icon: Icon(Icons.add, color: AppTheme.of(context).tertiaryColor),
                    text: 'Create',
                    style: TextStyle(color: AppTheme.of(context).tertiaryColor),
                    border: Border.all(color: AppTheme.of(context).tertiaryColor),
                    color: AppTheme.of(context).primaryBackground,
                    onTap: () async {
                      await (QuotesProvider()).insertPowerCode(widget.id);
                      await (QuotesProvider()).getX2Quotes(null);
                      fToast.showToast(
                        child: const SuccessToast(
                          message: 'Order Created Successfully',
                        ),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: const Duration(seconds: 2),
                      );
                      if (context.canPop()) context.pop();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSideLabel(double value) => SizedBox(
        width: 40,
        child: Text('${value.round().toString()}%', style: TextStyle(color: AppTheme.of(context).primaryColor) /* const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold, */
            ),
      );
}
