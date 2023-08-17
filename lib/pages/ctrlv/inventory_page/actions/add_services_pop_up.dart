import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/widgets/custom_ddown_menu/custom_dropdown_inventory.dart';
import 'package:rta_crm_cv/widgets/custom_text_fieldForm.dart';

import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/success_toast.dart';

class AddServicePopUp extends StatefulWidget {
  const AddServicePopUp({super.key});

  @override
  State<AddServicePopUp> createState() => _AddServicePopUpState();
}

class _AddServicePopUpState extends State<AddServicePopUp> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    final formKey = GlobalKey<FormState>();
    DateTime date = DateTime.now();

    final List<String> serviceName =
        provider.service.map((services) => services.service).toList();

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Add Service',
        height: 375,
        width: 380,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomTextIconButton(
                          isLoading: false,
                          icon: Icon(Icons.arrow_back_outlined,
                              color: AppTheme.of(context).primaryBackground),
                          text: '',
                          onTap: () {
                            context.pop();
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.03,
                        decoration: BoxDecoration(
                          color: statusColor(
                              provider.actualVehicle!.company.company),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            provider.actualVehicle!.licesensePlates,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomDropDownInventory(
                        hint: 'Choose a service',
                        label: '1. Services*',
                        width: 350,
                        list: serviceName,
                        dropdownValue: provider.serviceSelected?.service,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.selectService(val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: '2. Service Date*',
                          controller: provider.serviceDateController,
                          enabled: true,
                          onTapCheck: true,
                          width: 350,
                          keyboardType: TextInputType.datetime,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2050));

                            if (newDate != null) {
                              provider.serviceDateController.text =
                                  DateFormat("MM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextIconButton(
                    isLoading: false,
                    icon: Icon(Icons.save_outlined,
                        color: AppTheme.of(context).primaryBackground),
                    text: 'Add Service',
                    onTap: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      //Crear Servicio del vehiculo
                      bool res = await provider.createVehicleService();

                      if (!res) {
                        await ApiErrorHandler.callToast(
                            'Error creating service');
                        return;
                      }

                      if (!mounted) return;
                      fToast.showToast(
                        child: const SuccessToast(
                          message: 'Service Added Succesfuly',
                        ),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: const Duration(seconds: 2),
                      );

                      if (context.canPop()) context.pop();
                      provider.getServicesPage();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Color statusColor(String status) {
  late Color color;

  switch (status) {
    case "ODE": //Sales Form
      color = const Color(0XFFB2333A);
      break;
    case "SMI": //Sen. Exec. Validate
      color = const Color.fromRGBO(255, 138, 0, 1);
      break;
    case "CRY": //Finance Validate
      color = const Color(0XFF345694);
      break;

    default:
      return Colors.black;
  }
  return color;
}
