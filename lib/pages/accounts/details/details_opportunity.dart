import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/accounts/tabs/opportunity_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/success_toast.dart';

class DetailsOpportunity extends StatefulWidget {
  const DetailsOpportunity({super.key});

  @override
  State<DetailsOpportunity> createState() => _DetailsOpportunityState();
}

class _DetailsOpportunityState extends State<DetailsOpportunity> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    OpportunityProvider provider = Provider.of<OpportunityProvider>(context);
    final formKey = GlobalKey<FormState>();
    final formKey2 = GlobalKey<FormState>();

    final List<String> statesNames =
        provider.states.map((state) => state.name).toList();

    final List<String> rolesNames =
        provider.roles.map((role) => role.roleName).toList();

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Details Opportunity: ${provider.nameController.text}',
        height: 910,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Tarjeta Basic Information
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CustomCard(
                      title: 'Basic Information',
                      height: 570,
                      width: 380,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTextField(
                                      label: 'Name',
                                      icon: Icons.person_outline,
                                      controller: provider.nameController,
                                      enabled: false,
                                      width: 350,
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTextField(
                                      label: 'Account',
                                      icon: Icons.business_outlined,
                                      controller: provider.accountController,
                                      enabled: false,
                                      width: 350,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomDDownMenu(
                                      hint: 'None',
                                      label: 'Sales Stage',
                                      icon: Icons.attach_money,
                                      width: 350,
                                      list: provider.saleStoreList,
                                      dropdownValue:
                                          provider.selectSaleStoreValue,
                                      onChanged: (val) {
                                        /* if (val == null) return;
                                       // provider.selectStage(val); */
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTextField(
                                      label: 'Contact',
                                      icon: Icons.group,
                                      controller: provider.contactController,
                                      enabled: false,
                                      width: 350,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomDDownMenu(
                                      hint: 'None',
                                      label: 'Assigned To',
                                      icon: Icons.assignment_ind,
                                      width: 350,
                                      list: provider.assignedList,
                                      dropdownValue:
                                          provider.selectAssignedTValue,
                                      onChanged: (val) {
                                        /*  if (val == null) return;
                                       // provider.selectAssigned(val); */
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomDDownMenu(
                                      hint: 'None',
                                      label: 'Lead Source',
                                      icon: Icons.menu,
                                      width: 350,
                                      list: provider.leadSourceList,
                                      dropdownValue:
                                          provider.selectLeadSourceValue,
                                      onChanged: (val) {
                                        /* if (val == null) return;
                                       // provider.selectLead(val); */
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
                  //Tarjeta Other Information
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CustomCard(
                      title: 'Other Information',
                      height: 570,
                      width: 380,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Form(
                            key: formKey2,
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTextField(
                                      label: 'Expected Close Date',
                                      icon: Icons.calendar_month,
                                      controller: provider.closedateController,
                                      enabled: false,
                                      width: 350,
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTextField(
                                      label: 'Quote Amount',
                                      icon: Icons.attach_money,
                                      controller:
                                          provider.quoteamountController,
                                      enabled: false,
                                      width: 350,
                                      keyboardType: TextInputType.name,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CheckboxListTile(
                                      title: Text(
                                        'Time Line',
                                        style: TextStyle(
                                            color: AppTheme.of(context)
                                                .primaryColor),
                                      ),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      value: provider.timeline,
                                      onChanged: (value) {
                                        /*  setState(
                                          () {
                                            provider.timeline = value!;
                                          },
                                        ); */
                                      },
                                      activeColor:
                                          AppTheme.of(context).primaryColor,
                                      checkColor: AppTheme.of(context)
                                          .primaryBackground,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CheckboxListTile(
                                      title: Text(
                                        'Decision Maker',
                                        style: TextStyle(
                                            color: AppTheme.of(context)
                                                .primaryColor),
                                      ),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      value: provider.decisionmaker,
                                      onChanged: (value) {
                                        /* setState(
                                          () => provider.decisionmaker = value!,
                                        ); */
                                      },
                                      activeColor:
                                          AppTheme.of(context).primaryColor,
                                      checkColor: AppTheme.of(context)
                                          .primaryBackground,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CheckboxListTile(
                                      title: Text(
                                        'Tech Spec',
                                        style: TextStyle(
                                            color: AppTheme.of(context)
                                                .primaryColor),
                                      ),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      value: provider.techspec,
                                      onChanged: (value) {
                                        /*  setState(
                                          () => provider.techspec = value!,
                                        ); */
                                      },
                                      activeColor:
                                          AppTheme.of(context).primaryColor,
                                      checkColor: AppTheme.of(context)
                                          .primaryBackground,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CheckboxListTile(
                                      title: Text(
                                        'Budget',
                                        style: TextStyle(
                                            color: AppTheme.of(context)
                                                .primaryColor),
                                      ),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      value: provider.budget,
                                      onChanged: (value) {
                                        /*  setState(
                                          () => provider.budget = value!,
                                        ); */
                                      },
                                      activeColor:
                                          AppTheme.of(context).primaryColor,
                                      checkColor: AppTheme.of(context)
                                          .primaryBackground,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: CustomTextField(
                                      label: 'Probability',
                                      icon: Icons.percent,
                                      controller:
                                          provider.probabilityController,
                                      enabled: false,
                                      width: 350,
                                      keyboardType: TextInputType.name,
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
                    enabled: false,
                    width: 740,
                    height: 51,
                    keyboardType: TextInputType.name,
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
                    icon: Icon(Icons.add,
                        color: AppTheme.of(context).primaryBackground),
                    isLoading: false,
                    text: 'Create',
                    onTap: () async {
                      fToast.showToast(
                        child: const SuccessToast(
                          message: 'Usuario creado',
                        ),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: const Duration(seconds: 2),
                      );

                      if (context.canPop()) context.pop();
                    },
                  ),
                  CustomTextIconButton(
                    icon: Icon(Icons.refresh_outlined,
                        color: AppTheme.of(context).primaryBackground),
                    isLoading: false,
                    text: 'Refresh',
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
