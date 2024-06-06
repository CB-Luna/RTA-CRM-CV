import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/date_format.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/providers/dashboard_rta/circuits_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field_circuit.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_fieldForm.dart';

import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/widgets/success_toast.dart';

class AddCircuitPopUp extends StatefulWidget {
  const AddCircuitPopUp({super.key});

  @override
  State<AddCircuitPopUp> createState() => _AddCircuitPopUpState();
}

class _AddCircuitPopUpState extends State<AddCircuitPopUp> {
  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    CircuitsProvider provider = Provider.of<CircuitsProvider>(context);
    double txfFieldWidth = (MediaQuery.of(context).size.width / 10);

    final formKey = GlobalKey<FormState>();

    double width = MediaQuery.of(context).size.width / 1440;
    double height = MediaQuery.of(context).size.height / 1024;

    Future<void> selectDateDue(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2040),
      );
      if (picked != null && picked != DateTime.now()) {
        setState(() {
          String formattedDate = DateFormat('MMM/dd/yyyy').format(picked);
          provider.contexpController.text = formattedDate;
          // provider.dateController.text = picked
          //     .toString(); // Aquí puedes formatear la fecha según tus necesidades
        });
      }
    }

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: 'Add Circuit',
        height: height * 640, //634
        width: width * 475, //400
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
            DefaultTabController(
              length: 4,
              initialIndex: 0,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: whiteGradient,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(15),
                      ),
                      border: Border.all(
                          color: AppTheme.of(context).primaryColor, width: 2),
                    ),
                    child: TabBar(
                      onTap: (value) {
                        switch (value) {
                          case 0:
                            provider.setIndex(0, notify: true);

                            break;
                          case 1:
                            provider.setIndex(1, notify: true);
                            break;
                          case 2:
                            provider.setIndex(2, notify: true);
                            break;
                          case 3:
                            provider.setIndex(3, notify: true);
                            break;
                          // default:
                        }
                      },
                      indicator: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(15),
                        ),
                        color: AppTheme.of(context).primaryColor,
                      ),
                      splashBorderRadius: BorderRadius.circular(40),
                      labelStyle: const TextStyle(
                        fontFamily: 'UniNeue',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                      unselectedLabelColor: AppTheme.of(context).primaryColor,
                      unselectedLabelStyle: const TextStyle(
                        fontFamily: 'UniNeue',
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      tabs: const [
                        Tab(text: 'Order Info'),
                        Tab(text: 'Order Info v2'),
                        Tab(text: 'Apops'),
                        Tab(text: 'Bpops'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      height: getHeight(0, context),
                      child: const TabBarView(
                        children: [
                          SizedBox.shrink(),
                          SizedBox.shrink(),
                          SizedBox.shrink(),
                          SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (provider.indexSelected[0])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '1. PCCID*',
                            controller: provider.pccidController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '2. RTA Customer*',
                            controller: provider.rtaCustomerController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[0])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '3. Circuit Status*',
                            controller: provider.cktStatusController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '4. Gemap*',
                            controller: provider.geMapController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[0])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '5. Carrier *',
                            controller: provider.carrierController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '6. Circuit Type*',
                            controller: provider.cktTypeController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[0])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '7. Circuit Use *',
                            controller: provider.cktUseController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '8. Circuit ID*',
                            controller: provider.cktIDController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[0])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '9. EVC*',
                            controller: provider.evcController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '10. Caracctnum*',
                            controller: provider.caracctnumController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[1])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '11. CarcontID*',
                            controller: provider.carcontIDController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '12. ContLength*',
                            controller: provider.contLengthController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  // -------------------------- Order Info 2 ----------------------

                  if (provider.indexSelected[1])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '13. Street*',
                            controller: provider.streetController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '14. State*',
                            controller: provider.stateController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[1])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '15. City*',
                            controller: provider.cityController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '16. Zip*',
                            controller: provider.zipController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[1])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '17 Longitude*',
                            controller: provider.longitudeController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '18. Latitude*',
                            controller: provider.latitudeController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[1])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '19. CIR*',
                            controller: provider.cirController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '20. Port*',
                            controller: provider.portController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[1])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '21. HandOff*',
                            controller: provider.handoffController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                              label: '22. ContExp*',
                              controller: provider.contexpController,
                              enabled: true,
                              width: txfFieldWidth,
                              keyboardType: TextInputType.datetime,
                              onTap: () async {
                                selectDateDue(context);
                              }),
                        ),
                      ],
                    ),
                  // -------------------------- APOPS ----------------------
                  if (provider.indexSelected[2])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '23. ApopStreet*',
                            controller: provider.apopStreetController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '24. ApopCity*',
                            controller: provider.apopCityController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[2])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '25. ApopState*',
                            controller: provider.apopStateController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '26. ApopZip*',
                            controller: provider.apopZipController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[2])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '27. ApopLatitude*',
                            controller: provider.apopLatitudeController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '28. ApopLongitude*',
                            controller: provider.apopLongitudeController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),

                  // -------------------------- BPOPS ----------------------

                  if (provider.indexSelected[3])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '29.BpopStreet*',
                            controller: provider.bpopStreetController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '30. BpopCity*',
                            controller: provider.bpopCityController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),

                  if (provider.indexSelected[3])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '31. BpopState*',
                            controller: provider.bpopStateController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '32. BpopZip*',
                            controller: provider.bpopZipController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[3])
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '33. BpopLatitude*',
                            controller: provider.bpopLatitudeController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: CustomTextFieldForm(
                            label: '34. BpopLongitude*',
                            controller: provider.bpopLongitudeController,
                            enabled: true,
                            width: txfFieldWidth,
                            keyboardType: TextInputType.name,
                          ),
                        ),
                      ],
                    ),
                  if (provider.indexSelected[3]) const DetailCircuitComments(),
                ],
              ),
            ),
            if (provider.indexSelected[3])
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextIconButton(
                    mainAxisAlignment: MainAxisAlignment.center,
                    width: MediaQuery.of(context).size.width * 0.1,
                    isLoading: false,
                    icon: Icon(Icons.save_outlined,
                        color: AppTheme.of(context).primaryBackground),
                    text: 'Save Circuit',
                    onTap: () async {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      // await provider.uploadImage();
                      // //Crear perfil de usuario
                      bool res = await provider.createCircuit();

                      if (!res) {
                        await ApiErrorHandler.callToast(
                            'Error at create Circuit');
                        return;
                      }

                      if (!mounted) return;
                      fToast.showToast(
                        child: const SuccessToast(
                          message: 'Circuit Added Succesfuly',
                        ),
                        gravity: ToastGravity.BOTTOM,
                        toastDuration: const Duration(seconds: 2),
                      );

                      if (context.canPop()) context.pop();
                    }),
              )
          ],
        ),
      ),
    );
  }
}

class DetailCircuitComments extends StatefulWidget {
  const DetailCircuitComments({super.key});

  @override
  State<DetailCircuitComments> createState() => _DetailCircuitCommentsState();
}

class _DetailCircuitCommentsState extends State<DetailCircuitComments> {
  // MapBoxStaticImage staticImage = MapBoxStaticImage(
  //   apiKey:
  //       'API Key', // dont pass if you have set it in MapBoxSearch.init('API KEY')
  // );

  // Uri getStaticImageWithMarker() => staticImage.getStaticUrlWithMarker(
  //       center: Location(lat: 37.77343, lng: -122.46589),
  //       marker: MapBoxMarker(
  //           markerColor: RgbColor(40, 20, 10),
  //           markerLetter: 'p',
  //           markerSize: MarkerSize.LARGE),
  //       height: 300,
  //       width: 600,
  //       zoomLevel: 16,
  //       style: MapBoxStyle.Satellite_Street_V11,
  //       render2x: true,
  //     );

  @override
  Widget build(BuildContext context) {
    CircuitsProvider provider = Provider.of<CircuitsProvider>(context);

    return CustomCard(
      // height: MediaQuery.of(context).size.height / 2.25,
      // width: MediaQuery.of(context).size.width / 5,
      height: MediaQuery.of(context).size.height / 3.3,
      width: MediaQuery.of(context).size.width / 4.5,
      title: 'Comments',
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2.25 - 150,
                // width: MediaQuery.of(context).size.width / 3.2,
                width: MediaQuery.of(context).size.width / 4.9,
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppTheme.of(context).primaryBackground,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.1,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ]),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: provider.comments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width:
                                    // MediaQuery.of(context).size.width / 5 - 60,
                                    MediaQuery.of(context).size.width / 8 - 60,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color:
                                          AppTheme.of(context).secondaryColor),
                                  color: AppTheme.of(context).primaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0.1,
                                      blurRadius: 3,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
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
                                        color:
                                            AppTheme.of(context).secondaryColor,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, top: 5, bottom: 5),
                                        child: Row(
                                          children: [
                                            // Nombre del usuario que creo el comentario
                                            Icon(Icons.person_2_outlined,
                                                color: AppTheme.of(context)
                                                    .primaryBackground),
                                            Text(
                                              currentUser!.fullName,
                                              // "${provider.comments[index].usercomment!.name} ${provider.comments[index].usercomment!.lastName}",
                                              // '${provider.comments[index].role} - ${provider.comments[index].name}',
                                              style: TextStyle(
                                                  color: AppTheme.of(context)
                                                      .primaryBackground),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      //height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: CustomScrollBar(
                                          scrollDirection: Axis.vertical,
                                          child: SelectableText(provider
                                              .comments[index].comment!),
                                          // "Prueba prueba 2"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SelectableText(
                                // dateFormat(sended, true),
                                dateFormat(
                                    provider.comments[index].sended, true),
                                style: AppTheme.of(context).hintText,
                              ),
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: CustomTextFieldCircuit(
                          height: 48,
                          enabled: true,
                          controller: provider.commentsController,
                          icon: Icons.comment_outlined,
                          label: 'Comment',
                          keyboardType: TextInputType.text,
                          width: (MediaQuery.of(context).size.width / 5 - 20) -
                              100,
                        ),
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
                            text: 'Add',
                            onTap: () async {
                              await provider.addCommentWait();
                              setState(() {});
                            }),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
