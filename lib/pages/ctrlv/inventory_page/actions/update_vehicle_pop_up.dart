import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';
import 'package:rta_crm_cv/widgets/custom_ddown_menu/custom_dropdown_inventory.dart';
import 'package:rta_crm_cv/widgets/custom_text_fieldForm.dart';

import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

import '../../../../models/vehicle.dart';
import '../../../../services/api_error_handler.dart';
import '../../../../widgets/get_image_widget.dart';
import '../../../../widgets/success_toast.dart';

class UpdateVehiclePopUp extends StatefulWidget {
  final Vehicle vehicle;

  const UpdateVehiclePopUp({super.key, required this.vehicle});

  @override
  State<UpdateVehiclePopUp> createState() => _UpdateVehiclePopUpState();
}

class _UpdateVehiclePopUpState extends State<UpdateVehiclePopUp> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    InventoryProvider provider = Provider.of<InventoryProvider>(context);

    final formKey = GlobalKey<FormState>();
    var cardMask = MaskTextInputFormatter(
        mask: '###-%%%%',
        filter: {"#": RegExp(r'[a-zA-Z]'), "%": RegExp(r'[0-9]')});
    DateTime date = DateTime.now();
    DateTime selectedDate = DateTime.now();
    Color pickerColor = const Color(0xff2196f3);
    Color colors = Colors.white;
    final List<String> companyName =
        provider.company.map((companies) => companies.company).toList();
    final List<String> statusName =
        provider.status.map((statu) => statu.status).toList();
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Update Vehicle',
        height: 634,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomDropDownInventory(
                        hint: widget.vehicle.company.company,
                        label: '1. Company',
                        width: 350,
                        list: companyName,
                        dropdownValue: provider.companySelectedUpdate?.company,
                        onChanged: (vasl) {
                          if (vasl == null) return;
                          provider.selectCompanyUpdate(vasl);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                        label: '2. Make',
                        controller: provider.makeControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                        label: '3. Model',
                        controller: provider.modelControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: CustomTextFieldForm(
                            label: '4. year',
                            controller: provider.yearControllerUpdate,
                            enabled: true,
                            onTapCheck: true,
                            width: 350,
                            keyboardType: TextInputType.name,
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Select Year"),
                                    content: SizedBox(
                                      width: 300,
                                      height: 300,
                                      child: YearPicker(
                                        firstDate: DateTime(
                                            DateTime.now().year - 100, 1),
                                        lastDate: DateTime(
                                            DateTime.now().year + 100, 1),
                                        initialDate: DateTime.now(),
                                        onChanged: (DateTime dateTime) {
                                          selectedDate = dateTime;
                                          provider.yearControllerUpdate.text =
                                              DateFormat("yyyy")
                                                  .format(selectedDate);

                                          Navigator.pop(context);
                                        },
                                        selectedDate: selectedDate,
                                      ),
                                    ),
                                  );
                                },
                              );
                            })),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                        label: '5. VIN',
                        controller: provider.vinControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                        label: '6. License Plates',
                        controller: provider.plateNumberControllerUpdate,
                        inputFormatters: [cardMask],
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomDropDownInventory(
                        hint: widget.vehicle.status.status,
                        label: '7. status',
                        width: 350,
                        list: statusName,
                        dropdownValue: provider.statusSelectedUpdate?.status,
                        onChanged: (val) {
                          if (val == null) {
                            return provider.selectStatUpdate(val!);
                          }

                          provider.selectStatUpdate(val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                        label: '8. Motor',
                        controller: provider.motorControllerUpadte,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                        label: '9. Color',
                        enabled: true,
                        controller: TextEditingController(),
                        onTapCheck: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                        //designColor: int.parse(widget.vehicle.color!),
                        onTap: () async {
                          colors =
                              await showColorPickerDialog(context, pickerColor);
                          String colorString =
                              "0x${colors.hexAlpha.toLowerCase()}";
                          provider.updateColor(
                              int.parse(colorString), colorString);
                        },
                        designColor: provider.colorController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: '10. oil change due',
                          controller: provider.dateTimeControllerOilUpdate,
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
                              provider.dateTimeControllerOil.text =
                                  DateFormat("MMM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: '11. Last Radiator Fluid Change',
                          controller: provider.dateTimeControllerRFCUpadte,
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
                              provider.dateTimeControllerRFCUpadte.text =
                                  DateFormat("MMM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: '12. Last Transimission Fluid Change',
                          controller: provider.dateTimeControllerLTFCUpadte,
                          enabled: true,
                          onTapCheck: true,
                          width: 350,
                          keyboardType: TextInputType.name,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(1980),
                                lastDate: DateTime(2050));

                            if (newDate != null) {
                              provider.dateTimeControllerLTFCUpadte.text =
                                  DateFormat("MMM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                        label: '13. Initial Mileage',
                        controller: provider.mileageControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          "14. Update Vehicle Image",
                          style: TextStyle(
                            color: AppTheme.of(context).primaryColor,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await provider.selectImage();
                          },
                          child: Container(
                            width: 105,
                            height: 105,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: getImageUpdate(
                                provider.webImage!, widget.vehicle),
                          ),
                        ),
                      ],
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
                    text: 'Update Vehicle',
                    onTap: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      //Crear perfil de usuario
                      bool res = await provider.updateVehicle(widget.vehicle);

                      if (!res) {
                        await ApiErrorHandler.callToast(
                            'Error al actualizar el vehiculo');
                        return;
                      }

                      if (!mounted) return;
                      fToast.showToast(
                        child: const SuccessToast(
                          message: 'updated vehicle',
                        ),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: const Duration(seconds: 2),
                      );

                      if (context.canPop()) context.pop();
                      await provider.updateState();
                    }),
                CustomTextIconButton(
                  isLoading: false,
                  icon: Icon(Icons.exit_to_app_outlined,
                      color: AppTheme.of(context).primaryBackground),
                  text: 'Exit',
                  onTap: () {
                    context.pop();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
