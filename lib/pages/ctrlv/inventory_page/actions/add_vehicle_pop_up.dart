import 'package:flex_color_picker/flex_color_picker.dart';
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

import '../../../../widgets/get_image_widget.dart';

class AddVehiclePopUp extends StatefulWidget {
  const AddVehiclePopUp({super.key});

  @override
  State<AddVehiclePopUp> createState() => _AddVehiclePopUpState();
}

class _AddVehiclePopUpState extends State<AddVehiclePopUp> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    InventoryProvider provider = Provider.of<InventoryProvider>(context);
    final formKey = GlobalKey<FormState>();
    DateTime date = DateTime.now();
    DateTime selectedDate = DateTime.now();

    Color pickerColor = const Color(0xff2196f3);
    Color colors = Colors.white;
    final List<String> companyName = provider.company.map((companies) => companies.company).toList();
    final List<String> statusName = provider.status.map((statu) => statu.status).toList();

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Add Vehicle',
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
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomDropDownInventory(
                        hint: 'Choose a Company',
                        label: '1. Company',
                        width: 350,
                        list: companyName,
                        dropdownValue: provider.companySelected?.company,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.selectCompany(val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldForm(
                        label: '2. Brand',
                        controller: provider.brandController,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldForm(
                        label: '3. Model',
                        controller: provider.modelController,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomTextFieldForm(
                            label: '4. year',
                            controller: provider.yearController,
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
                                        firstDate: DateTime(DateTime.now().year - 100, 1),
                                        lastDate: DateTime(DateTime.now().year + 100, 1),
                                        initialDate: DateTime.now(),
                                        onChanged: (DateTime dateTime) {
                                          selectedDate = dateTime;
                                          provider.yearController.text = DateFormat("yyyy").format(selectedDate);

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
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldForm(
                        label: '5. VIN',
                        controller: provider.vinController,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldForm(
                        label: '6. Plate Number',
                        controller: provider.plateNumberController,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomDropDownInventory(
                        hint: 'Choose the status',
                        label: '7. status',
                        width: 350,
                        list: statusName,
                        dropdownValue: provider.statusSelected?.status,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.selectStatu(val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldForm(
                        label: '8. Motor',
                        controller: provider.motorController,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldForm(
                        label: '9. Color',
                        enabled: true,
                        controller: TextEditingController(),
                        onTapCheck: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                        onTap: () async {
                          colors = await showColorPickerDialog(context, pickerColor);
                          String colorString = "0x${colors.hexAlpha.toLowerCase()}";
                          provider.updateColor(int.parse(colorString), colorString);
                        },
                        designColor: provider.colorController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldForm(
                          label: '10. oil change due',
                          controller: provider.dateTimeControllerOil,
                          enabled: true,
                          onTapCheck: true,
                          width: 350,
                          keyboardType: TextInputType.name,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(1980), lastDate: DateTime(2050));

                            if (newDate != null) {
                              provider.dateTimeControllerOil.text = DateFormat("MM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldForm(
                          label: '11. Registration Due',
                          controller: provider.dateTimeControllerReg,
                          enabled: true,
                          onTapCheck: true,
                          width: 350,
                          keyboardType: TextInputType.name,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(1980), lastDate: DateTime(2050));

                            if (newDate != null) {
                              provider.dateTimeControllerReg.text = DateFormat("MM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CustomTextFieldForm(
                          label: '12. Insurance Renewal Due',
                          controller: provider.dateTimeControllerIRD,
                          enabled: true,
                          onTapCheck: true,
                          width: 350,
                          keyboardType: TextInputType.name,
                          onTap: () async {
                            DateTime? newDate = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(1980), lastDate: DateTime(2050));

                            if (newDate != null) {
                              provider.dateTimeControllerIRD.text = DateFormat("MM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                    Column(
                      children: [
                        Text(
                          "13. Add Vehicle Image",
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
                            child: getAddImageV(
                              provider.webImage,
                            ),
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
                    icon: Icon(Icons.save_outlined, color: AppTheme.of(context).primaryBackground),
                    text: 'Save Vehicle',
                    onTap: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      //Crear perfil de usuario
                      bool res = await provider.createVehicleInventory();

                      if (!res) {
                        await ApiErrorHandler.callToast('Error al agregar el vehiculo');
                        return;
                      }

                      if (!mounted) return;
                      fToast.showToast(
                        child: const SuccessToast(
                          message: 'Usuario creado',
                        ),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: const Duration(seconds: 2),
                      );

                      if (context.canPop()) context.pop();
                    }),
                CustomTextIconButton(
                  isLoading: false,
                  icon: Icon(Icons.refresh_outlined, color: AppTheme.of(context).primaryBackground),
                  text: 'Refresh',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
