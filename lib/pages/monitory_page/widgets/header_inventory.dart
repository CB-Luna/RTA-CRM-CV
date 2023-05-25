import 'package:flutter/material.dart';

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';

import '../../../theme/theme.dart';
import '../../../widgets/animated_hover_buttom.dart';

class InventoryPageHeader extends StatefulWidget {
  InventoryPageHeader({
    Key? key,
  }) : super(key: key);
  final AdvancedDrawerController drawerController = AdvancedDrawerController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  State<InventoryPageHeader> createState() => _InventoryPageHeaderState();
}

class _InventoryPageHeaderState extends State<InventoryPageHeader> {
  @override
  Widget build(BuildContext context) {
    // final EmpleadosProvider empleadoProvider =
    //     Provider.of<EmpleadosProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          // child: Container(
          //   width: 50,
          //   height: 50,
          //   child: FittedBox(
          //     child: AnimatedHoverButton(
          //       tooltip: 'Agregar',
          //       primaryColor: AppTheme.of(context).primaryColor,
          //       secondaryColor: AppTheme.of(context).primaryBackground,
          //       icon: Icons.person_add,
          //       onTap: () {
          //         showDialog(
          //           context: context,
          //           builder: (BuildContext context) {
          //             return AlertDialog(
          //               backgroundColor: const Color(0xffd1d0d0),
          //               shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(20),
          //               ),
          //               content: AltaUsuarioPopup(
          //                   key: UniqueKey(),
          //                   drawerController: widget.drawerController,
          //                   scaffoldKey: widget.scaffoldKey,
          //                   idRegistro: 2,
          //                   listaDropdownAreas: empleadoProvider.areaNames,
          //                   topMenuTittle:
          //                       "Alta de Empleado de Area"), // Widget personalizado
          //             );
          //           },
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ),
      ],
    );
  }
}
