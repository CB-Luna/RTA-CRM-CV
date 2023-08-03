import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/providers/crm/accounts/tabs/order_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/success_toast.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final OrdersProvider provider = Provider.of<OrdersProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  FToast fToast = FToast();
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    OrdersProvider provider = Provider.of<OrdersProvider>(context);
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: '${provider.typesSelectedValue} ${provider.circuitTypeSelectedValue} - Address',
        height: provider.typesSelectedValue == 'Migration' || provider.typesSelectedValue == 'New Circuit' || provider.typesSelectedValue == 'Circuit Upgrade'
            ? getHeight(680, context)
            : getHeight(500, context),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextField(
                          label: 'Circuit Address',
                          icon: Icons.location_on_outlined,
                          controller: provider.existingCircuitIDController,
                          enabled: true,
                          width: 350,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextField(
                          label: 'Circuit Detail',
                          icon: Icons.description_sharp,
                          controller: provider.existingCircuitIDController,
                          enabled: true,
                          width: 350,
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomDDownMenu(
                            hint: 'None',
                            label: 'Data Center Location',
                            icon: Icons.location_on_outlined,
                            width: 350,
                            list: provider.dataCentersList,
                            dropdownValue: provider.dataCenterSelectedValue,
                            onChanged: (p0) {
                              if (p0 != null) {
                                provider.selectDataCenter(p0);
                              }
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextField(
                          label: 'Port',
                          icon: Icons.wifi_find_rounded,
                          controller: provider.existingCircuitIDController,
                          enabled: true,
                          width: 350,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextField(
                          label: 'CIR',
                          icon: Icons.tag,
                          controller: provider.existingCircuitIDController,
                          enabled: true,
                          width: 350,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      provider.typesSelectedValue == 'Migration' || provider.typesSelectedValue == 'New Circuit' || provider.typesSelectedValue == 'Circuit Upgrade'
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomTextField(
                                label: 'Handoff',
                                icon: Icons.mark_chat_unread,
                                controller: provider.existingCircuitIDController,
                                enabled: true,
                                width: 350,
                                keyboardType: TextInputType.phone,
                              ),
                            )
                          : const SizedBox(),
                      provider.typesSelectedValue == 'Migration' || provider.typesSelectedValue == 'New Circuit' || provider.typesSelectedValue == 'Circuit Upgrade'
                          ? Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomTextField(
                                label: 'Demarkation Point',
                                icon: Icons.pin_drop,
                                controller: provider.existingCircuitIDController,
                                enabled: true,
                                width: 350,
                                keyboardType: TextInputType.phone,
                              ),
                            )
                          : const SizedBox(),
                      provider.typesSelectedValue == 'Migration' || provider.typesSelectedValue == 'New Circuit' || provider.typesSelectedValue == 'Circuit Upgrade'
                          ? Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: CustomTextIconButton(
                                      color: provider.docProveedor != null ? AppTheme.of(context).primaryColor : AppTheme.of(context).tertiaryColor,
                                      isLoading: false,
                                      icon: Icon(
                                        provider.docProveedor != null ? Icons.remove_red_eye_outlined : Icons.upload_outlined,
                                        color: AppTheme.of(context).primaryBackground,
                                      ),
                                      text: provider.docProveedor != null ? 'View Image of Demarkation Point' : 'Upload Image of Demarkation Point',
                                      onTap: (provider.imageBytes != null && provider.docProveedor != null && provider.popupVisorPdfVisible)
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
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            /*  Padding(
                                                          padding:
                                                              const EdgeInsets.only(bottom: 20),
                                                          child: IconButton(
                                                            onPressed: () => Navigator.pop(context),
                                                            icon: const Icon(Icons.close),
                                                            iconSize: 50,
                                                            color: Colors.red,
                                                          ),
                                                        ), */
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
                                                            Image.memory(provider.imageBytes!),
                                                          ],
                                                        )),
                                                  );
                                                },
                                              );
                                            }
                                          : () {
                                              if (provider.imageBytes != null && provider.docProveedor != null && provider.popupVisorPdfVisible == false) {
                                                provider.verPdf(true);
                                                setState(() {});
                                              } else {
                                                provider.pickProveedorDoc();
                                                provider.verPdf(true);
                                              }
                                            },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
            //Row Botones Crear
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  CustomTextIconButton(
                    isLoading: false,
                    icon: Icon(Icons.add, color: AppTheme.of(context).tertiaryColor),
                    text: 'Create',
                    style: TextStyle(color: AppTheme.of(context).tertiaryColor),
                    border: Border.all(color: AppTheme.of(context).tertiaryColor),
                    color: AppTheme.of(context).primaryBackground,
                    onTap: () async {
                      provider.createOrder();
                      fToast.showToast(
                        child: const SuccessToast(
                          message: 'Succes Lead Creat',
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
        child:
            Text('${value.round().toString()}%', style: TextStyle(color: AppTheme.of(context).primaryColor) /* const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold, */
                ),
      );
}
