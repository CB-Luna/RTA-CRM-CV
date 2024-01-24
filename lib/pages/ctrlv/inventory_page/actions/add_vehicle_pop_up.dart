import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/failed_toastJA.dart';
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
    var cardMask = MaskTextInputFormatter(
        mask: '####-######', filter: {"#": RegExp(r'[A-Za-z0-9]')});
    var cardMaskVIN = MaskTextInputFormatter(
        mask: '##################', filter: {"#": RegExp(r'[A-Za-z0-9]')});
    var cardMaskModel = MaskTextInputFormatter(
        mask: '###############', filter: {"#": RegExp(r'[A-Za-z0-9]')});
    var cardMaskMotor =
        MaskTextInputFormatter(mask: '#.#', filter: {"#": RegExp(r'[0-9]')});
    var cardMaskMileage =
        CurrencyTextInputFormatter(symbol: '', name: '', decimalDigits: 0);

    List<String> motors = ["Gas", "Diesel"];

    Color pickerColor = const Color(0xff2196f3);
    Color colors = Colors.white;
    final List<String> companyName =
        provider.company.map((companies) => companies.company).toList();
    final List<String> statusName =
        provider.status.map((statu) => statu.status).toList();
    final List<String> ownsershipName =
        provider.ownerships.map((owner) => owner.ownership).toList();

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Add Vehicle',
        height: 634,
        width: 380,
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
            Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomDropDownInventory(
                        hint: 'Choose a Company',
                        label: '1. Company*',
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
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                        label: '2. Make*',
                        controller: provider.brandController,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                        inputFormatters: [cardMaskModel],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                        label: '3. Model*',
                        controller: provider.modelController,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                        inputFormatters: [cardMaskModel],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: CustomTextFieldForm(
                            label: '4. Year*',
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
                                        firstDate: DateTime(
                                            DateTime.now().year - 100, 1),
                                        lastDate: DateTime(
                                            DateTime.now().year + 100, 1),
                                        initialDate: DateTime.now(),
                                        onChanged: (DateTime dateTime) {
                                          selectedDate = dateTime;
                                          provider.yearController.text =
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
                        label: '5. VIN*',
                        controller: provider.vinController,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                        inputFormatters: [cardMaskVIN],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                        label: '6. License Plates*',
                        controller: provider.plateNumberController,
                        inputFormatters: [cardMask],
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomDropDownInventory(
                        hint: 'Choose the Ownership',
                        label: '7. Ownership',
                        width: 350,
                        list: ownsershipName,
                        dropdownValue: provider.ownershipSelected?.ownership,
                        onChanged: (vasl) {
                          if (vasl == null) return;
                          provider.selectOwner(vasl);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomDropDownInventory(
                        hint: 'Choose the status',
                        label: '8. Status*',
                        width: 350,
                        list: statusName,
                        dropdownValue: provider.statusSelected?.status,
                        onChanged: (val) {
                          if (val == null) return;
                          provider.selectStatu(val);
                          if (provider.statusSelected?.statusId == 2 ||
                              provider.statusSelected?.statusId == 4) {
                            provider.visibilty = true;
                          } else {
                            provider.visibilty = false;
                          }
                        },
                      ),
                    ),
                    Visibility(
                      visible: provider.visibilty,
                      child: CustomTextFieldForm(
                        label: 'What is the problem of the vehicle',
                        controller: provider.problemControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomDropDownInventory(
                            label: '9. Motor*',
                            hint: 'Choose the Motor',
                            width: 187,
                            list: motors,
                            dropdownValue: provider.motorSel,
                            onChanged: (val) {
                              if (val == null) return;
                              provider.selectMotor(val);
                            },
                          ),
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: CustomTextFieldForm(
                                label: 'Version',
                                controller: provider.versionMotorController,
                                enabled: true,
                                width: 100,
                                keyboardType: TextInputType.number,
                                inputFormatters: [cardMaskMotor],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '10. Color*',
                            enabled: true,
                            controller: TextEditingController(),
                            onTapCheck: true,
                            width: 150,
                            keyboardType: TextInputType.name,
                            onTap: () async {
                              colors = await showColorPickerDialog(
                                  context, pickerColor);
                              String colorString =
                                  "0x${colors.hexAlpha.toLowerCase()}";
                              provider.updateColor(
                                  int.parse(colorString), colorString);
                            },
                            //designColor: provider.colorController,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 70, right: 10),
                          width: 50,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Color(provider.colorController),
                            shape: BoxShape.circle,
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: '11. Last Oil Change',
                          controller: provider.dateTimeControllerOil,
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
                              provider.dateTimeControllerOil.text =
                                  DateFormat("MM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: '12. Last Radiator Fluid Change',
                          controller: provider.dateTimeControllerRFC,
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
                              provider.dateTimeControllerRFC.text =
                                  DateFormat("MM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: '13. Last Transmission Fluid Change',
                          controller: provider.dateTimeControllerLTFC,
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
                              provider.dateTimeControllerLTFC.text =
                                  DateFormat("MM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: '14. Last Tire Change',
                          controller: provider.dateTimeControllerLTireChange,
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
                              provider.dateTimeControllerLTireChange.text =
                                  DateFormat("MM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                          label: '15. Last Brake Change',
                          controller: provider.dateTimeControllerLBrakeChange,
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
                              provider.dateTimeControllerLBrakeChange.text =
                                  DateFormat("MM/dd/yyyy").format(newDate);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: CustomTextFieldForm(
                        label: '16. Mileage*',
                        controller: provider.mileageController,
                        inputFormatters: [cardMaskMileage],
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      child: Column(
                        children: [
                          Text(
                            "17. Add Vehicle Image",
                            style: TextStyle(
                              color: AppTheme.of(context).primaryColor,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              bool valorImage = await provider.selectImage();
                              if (!valorImage) {
                                if (!mounted) return;
                                fToast.showToast(
                                  child: const FailedToastJA(
                                      message:
                                          'The Vehicle image is larger than 1 MB'),
                                  gravity: ToastGravity.BOTTOM,
                                  toastDuration: const Duration(seconds: 2),
                                );
                              }
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
                    ),
                  ],
                ),
              ),
            ),
            CustomTextIconButton(
                mainAxisAlignment: MainAxisAlignment.center,
                width: MediaQuery.of(context).size.width * 0.1,
                isLoading: false,
                icon: Icon(Icons.save_outlined,
                    color: AppTheme.of(context).primaryBackground),
                text: 'Save Vehicle',
                onTap: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  await provider.uploadImage();
                  //Crear perfil de usuario
                  bool res = await provider.createVehicleInventory();

                  if (!res) {
                    await ApiErrorHandler.callToast(
                        'Error al agregar el vehiculo');
                    return;
                  }

                  if (!mounted) return;
                  fToast.showToast(
                    child: const SuccessToast(
                      message: 'Vehicle Added Succesfuly',
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(seconds: 2),
                  );

                  if (context.canPop()) context.pop();
                })
          ],
        ),
      ),
    );
  }
}
