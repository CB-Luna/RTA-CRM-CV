import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../../../providers/ctrlv/monitory_provider.dart';

class MonitoryFiltersWidget extends StatefulWidget {
  const MonitoryFiltersWidget({Key? key}) : super(key: key);

  @override
  State<MonitoryFiltersWidget> createState() =>
      _MonitoryFiltersWidgetState();
}

class _MonitoryFiltersWidgetState extends State<MonitoryFiltersWidget> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   SeguimientoFacturasProvider provider =
    //       Provider.of<SeguimientoFacturasProvider>(
    //     context,
    //     listen: false,
    //   );
    //   await provider.getNumRegisters();
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final SeguimientoFacturasProvider provider =
    //     Provider.of<SeguimientoFacturasProvider>(context);

    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    return Column(
      children: [
        //Información de colores
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //CRY selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppTheme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    Text(
                      "CRY",
                      style: TextStyle(
                        fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                        fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                        fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                        fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                        color: AppTheme.of(context).primaryText),
                    )
                  ],
                ),
              ),
              //ODE selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: AppTheme.of(context).secondaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    Text(
                      "ODE",
                      style: TextStyle(
                        fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                        fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                        fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                        fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                        color: AppTheme.of(context).primaryText),
                    )
                  ],
                ),
              ),
              //SMI selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 138, 0, 1),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    Text(
                      "SMI",
                      style: TextStyle(
                        fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                        fontSize: AppTheme.of(context).encabezadoTablas.fontSize,
                        fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                        fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                        color: AppTheme.of(context).primaryText),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: EstatusWidget(
                numRegisters: provider.numCheckOutCRY,
                text: 'Check Out CRY',
                isTaped: false,
                color: AppTheme.of(context).primaryColor,
                onTap: () async {
                  // provider.seleccionado(14);
                  // provider.estatusFiltrado = 'Confirmación de Selección';
                  // await provider.getFacturas();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: EstatusWidget(
                numRegisters: provider.numCheckOutODE,
                text: 'Check Out ODE',
                isTaped: false,
                color: AppTheme.of(context).secondaryColor,
                onTap: () async {
                  // provider.seleccionado(1);
                  // provider.estatusFiltrado = 'NC Pendiente';
                  // await provider.getFacturas();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: EstatusWidget(
                numRegisters: provider.numCheckOutSMI,
                text: 'Check Out SMI',
                isTaped: false,
                color: Color.fromRGBO(255, 138, 0, 1),
                onTap: () async {
                  // provider.seleccionado(2);
                  // provider.estatusFiltrado = 'NC Recibida';
                  // await provider.getFacturas();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 40,
                height: 6,
                color: AppTheme.of(context).tertiaryColor,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 2,
            color: AppTheme.of(context).primaryColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: EstatusWidget(
                numRegisters: provider.numCheckInCRY,
                text: 'Check In CRY',
                isTaped: false,
                color: AppTheme.of(context).primaryColor,
                onTap: () async {
                  
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: EstatusWidget(
                numRegisters: provider.numCheckInODE,
                text: 'Check In ODE',
                isTaped: false,
                color: AppTheme.of(context).secondaryColor,
                onTap: () async {
                  
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: EstatusWidget(
                numRegisters: provider.numCheckInSMI,
                text: 'Check In SMI',
                isTaped: false,
                color: Color.fromRGBO(255, 138, 0, 1),
                onTap: () async {
                  
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: 40,
                height: 6,
                color: AppTheme.of(context).alternate,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class EstatusWidget extends StatefulWidget {
  const EstatusWidget({
    Key? key,
    required this.numRegisters,
    required this.text,
    required this.isTaped,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  final int numRegisters;
  final String text;
  final bool isTaped;
  final Color color;
  final void Function() onTap;

  @override
  State<EstatusWidget> createState() => _EstatusWidgetState();
}

class _EstatusWidgetState extends State<EstatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedButton.strip(
          width: 165,
          text: '  ${widget.text}',
          textMaxLine: 2,
          textOverflow: TextOverflow.ellipsis,
          textStyle: AppTheme.of(context).bodyText1,
          textAlignment: Alignment.centerLeft,
          stripTransitionType: StripTransitionType.RIGHT_TO_LEFT,
          // isReverse: true,
          isSelected: widget.isTaped,
          backgroundColor: AppTheme.of(context).gris,
          stripColor: widget.color,
          selectedTextColor: AppTheme.of(context).primaryBackground,
          selectedBackgroundColor: widget.color,
          onPress: widget.onTap,
        ),
        Positioned(
          right: 10,
          top: 10,
          child: IgnorePointer(
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.isTaped
                    ? AppTheme.of(context).gris
                    : AppTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.numRegisters.toString(),
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Gotham-Regular',
                      color: AppTheme.of(context).primaryText,
                      useGoogleFonts: false,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
