import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/failed_toast.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/failed_toastJA.dart';
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
        mask: '####-######', filter: {"#": RegExp(r'[A-Za-z0-9]')});
    var cardMaskVIN = MaskTextInputFormatter(
        mask: '##################', filter: {"#": RegExp(r'[A-Za-z0-9]')});
    var cardMaskModel = MaskTextInputFormatter(
        mask: '###############', filter: {"#": RegExp(r'[A-Za-z0-9]')});
    var cardMaskMotor =
        MaskTextInputFormatter(mask: '#.#', filter: {"#": RegExp(r'[0-9]')});
    var cardMaskMileage =
        CurrencyTextInputFormatter(symbol: '', name: '', decimalDigits: 0);
    DateTime date = DateTime.now();
    DateTime selectedDate = DateTime.now();
    Color pickerColor = Colors.white;
    Color colors = Colors.white;
    final List<String> companyName =
        provider.company.map((companies) => companies.company).toList();
    final List<String> statusName =
        provider.status.map((statu) => statu.status).toList();
    List<String> motors = ["Gas", "Diesel"];

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Update Vehicle',
        height: MediaQuery.of(context).size.height * 0.7, //634
        width: 380, // 380
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
                        inputFormatters: [cardMaskModel],
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
                        inputFormatters: [cardMaskModel],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: CustomTextFieldForm(
                            label: '4. Year',
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
                        inputFormatters: [cardMaskVIN],
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
                        label: '7. Status',
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
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: CustomDropDownInventory(
                            label: '8. Motor*',
                            hint: provider.motorControllerUpadte.text,
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
                                controller: provider.versionControllerUpdate,
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
                            label: '9. Color',
                            enabled: true,
                            controller: TextEditingController(),
                            onTapCheck: true,
                            width: 150,
                            keyboardType: TextInputType.name,
                            //designColor: int.parse(widget.vehicle.color!),
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
                          label: '10. Last Oil Change',
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
                              provider.dateTimeControllerOilUpdate.text =
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
                          label: '12. Last Transmission Fluid Change',
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
                        inputFormatters: [cardMaskMileage],
                        controller: provider.mileageControllerUpdate,
                        enabled: true,
                        width: 350,
                        keyboardType: TextInputType.name,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        children: [
                          Text(
                            "14. Update Vehicle Image",
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
                              child: getImageUpdate(
                                  widget.vehicle, provider.webImage),
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
                text: 'Update Vehicle',
                onTap: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  await provider.deleteImage();
                  await provider.uploadImage();
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
                })
          ],
        ),
      ),
    );
  }
}
