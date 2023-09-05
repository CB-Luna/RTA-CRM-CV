import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/crm/accounts/tabs/leads_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';

class DetailsLead extends StatefulWidget {
  const DetailsLead({super.key});

  @override
  State<DetailsLead> createState() => _DetailsLeadState();
}

class _DetailsLeadState extends State<DetailsLead> {
  FToast fToast = FToast();
  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    LeadsProvider provider = Provider.of<LeadsProvider>(context);
    final formKey = GlobalKey<FormState>();
    final formKey2 = GlobalKey<FormState>();
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Details Lead: ${provider.firstNameController.text} ${provider.lastNameController.text}',
        height: 920,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Tarjeta Basic Information
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomCard(
                    title: 'Basic Information',
                    height: 590,
                    width: 380,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Form(
                          key: formKey,
                          child: CustomScrollBar(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'First Name',
                                    icon: Icons.person_outline,
                                    controller: provider.firstNameController,
                                    enabled: provider.editmode,
                                    width: 350,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'Last Name',
                                    icon: Icons.person_outline,
                                    controller: provider.lastNameController,
                                    enabled: provider.editmode,
                                    width: 350,
                                    keyboardType: TextInputType.name,
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: CustomDDownMenu(
                                      hint: 'None',
                                      label: 'Sales Stage',
                                      icon: Icons.attach_money,
                                      width: 350,
                                      list: provider.saleStoreList,
                                      dropdownValue: provider.selectSaleStoreValue,
                                      onChanged: provider.editmode == false
                                          ? (p0) {
                                              if (p0 != null) {}
                                            }
                                          : (p0) {
                                              if (p0 != null) {
                                                provider.selectSaleStore(p0);
                                              }
                                            },
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'Account',
                                    icon: Icons.business_outlined,
                                    controller: provider.accountController,
                                    enabled: provider.editmode,
                                    width: 350,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'Email',
                                    icon: Icons.email,
                                    controller: provider.emailController,
                                    enabled: provider.editmode,
                                    width: 350,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomDDownMenu(
                                    hint: 'None',
                                    label: 'Lead Source',
                                    icon: Icons.menu,
                                    width: 350,
                                    list: provider.leadSourceList,
                                    dropdownValue: provider.selectLeadSourceValue,
                                    onChanged: provider.editmode == false
                                        ? (p0) {}
                                        : (p0) {
                                            if (p0 != null) {
                                              provider.selectLeadSource(p0);
                                            }
                                          },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'Phone',
                                    icon: Icons.phone,
                                    controller: provider.phoneController,
                                    enabled: provider.editmode,
                                    width: 350,
                                    keyboardType: TextInputType.phone,
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
                //Tarjeta Other Information
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomCard(
                    title: 'Other Information',
                    height: 590,
                    width: 380,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Form(
                          key: formKey2,
                          child: CustomScrollBar(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    child: CustomTextIconButton(
                                      isLoading: false,
                                      icon: Icon(
                                        Icons.calendar_month,
                                        color: AppTheme.of(context).hintText.color,
                                      ),
                                      text: 'Expected Close Date: ${DateFormat('MMMM, MM-dd-yyyy').format(provider.close)}',
                                      style: TextStyle(color: AppTheme.of(context).primaryColor),
                                      onTap: () {
                                        if (provider.editmode == false) {
                                        } else {
                                          provider.selectdate(context);
                                        }
                                      },
                                      color: AppTheme.of(context).primaryBackground,
                                    )),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomTextField(
                                    label: 'Quote Amount',
                                    icon: Icons.attach_money,
                                    controller: provider.quoteamountController,
                                    enabled: provider.editmode,
                                    width: 350,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 100),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: AppTheme.of(context).primaryBackground, boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0.1,
                                        blurRadius: 3,
                                        offset: const Offset(0, 0), // changes position of shadow
                                      ),
                                    ]),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SliderTheme(
                                        data: SliderThemeData(
                                          inactiveTrackColor: AppTheme.of(context).primaryColor.withOpacity(.5),
                                          activeTrackColor: AppTheme.of(context).primaryColor,
                                          thumbColor: AppTheme.of(context).primaryColor,
                                          overlayColor: AppTheme.of(context).primaryColor.withOpacity(.5),
                                          valueIndicatorColor: AppTheme.of(context).primaryColor,
                                          activeTickMarkColor: Colors.transparent,
                                          inactiveTickMarkColor: Colors.transparent,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.percent, color: AppTheme.of(context).hintText.color),
                                                Text(
                                                  'Probability: ${provider.slydervalue}%',
                                                  style: TextStyle(
                                                    color: AppTheme.of(context).primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                buildSideLabel(provider.min),
                                                Expanded(
                                                  child: Slider(
                                                    value: provider.slydervalue,
                                                    min: provider.min,
                                                    max: provider.max,
                                                    divisions: 10,
                                                    label: provider.slydervalue.round().toString(),
                                                    onChanged: provider.editmode == false
                                                        ? (value) => setState(
                                                              () {},
                                                            )
                                                        : (value) => setState(
                                                              () => provider.slydervalue = value,
                                                            ),
                                                  ),
                                                ),
                                                buildSideLabel(provider.max)
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: CustomDDownMenu(
                                    hint: 'None',
                                    label: 'Assigned To',
                                    icon: Icons.assignment_ind,
                                    width: 350,
                                    list: provider.assignedList,
                                    dropdownValue: provider.selectAssignedTValue,
                                    onChanged: provider.editmode == false
                                        ? (p0) {
                                            if (p0 != null) {}
                                          }
                                        : (p0) {
                                            if (p0 != null) {
                                              provider.selectAssigned(p0);
                                            }
                                          },
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
            //Tarjeta Descripcion
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomCard(
                title: 'Description',
                height: 160,
                width: 760,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CustomTextField(
                    label: 'Description',
                    icon: Icons.person_outline,
                    controller: provider.descriptionController,
                    enabled: provider.editmode,
                    width: 740,
                    height: 51,
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
            ),
            //Row Botones Crear
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  provider.editmode == false
                      ? CustomTextIconButton(
                          icon: Icon(Icons.edit, color: AppTheme.of(context).primaryBackground),
                          isLoading: false,
                          text: 'Edit',
                          onTap: () {
                            setState(
                              () {
                                provider.editmode = true;
                              },
                            );
                          },
                        )
                      : CustomTextIconButton(
                          icon: Icon(Icons.save, color: AppTheme.of(context).primaryBackground),
                          isLoading: false,
                          text: 'Guardar',
                          onTap: () async {
                            await provider.updateLead();
                            provider.editmode = false;
                          },
                        )
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
