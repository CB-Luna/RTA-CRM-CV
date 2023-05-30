import 'package:flutter/material.dart';

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../../../theme/theme.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/custom_text_icon_button.dart';

class MonitoryPageHeader extends StatefulWidget {
  MonitoryPageHeader({
    Key? key,
  }) : super(key: key);
  final AdvancedDrawerController drawerController = AdvancedDrawerController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  State<MonitoryPageHeader> createState() => _MonitoryPageHeaderState();
}

class _MonitoryPageHeaderState extends State<MonitoryPageHeader> {
  @override
  Widget build(BuildContext context) {
    // final EmpleadosProvider empleadoProvider =
    //     Provider.of<EmpleadosProvider>(context);

    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(
            enabled: true,
            controller: TextEditingController(),
            icon: Icons.search,
            label: 'Search',
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(
            width: 20,
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: 200,
            child: CustomTextIconButton(
              color: Color(0xffE0EAFF),
              icon:
                  Icon(Icons.calendar_month_outlined, color: Color(0xffE0EAFF)),
              text: 'May 25 - 30 2023',
              onTap: () {
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return StatefulBuilder(builder: (context, setState) {
                //         return const AddUserPopUp();
                //       });
                //     });
              },
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: 200,
            child: CustomTextIconButton(
              icon: Icon(Icons.download_outlined,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Export Data',
              onTap: () {
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) {
                //       return StatefulBuilder(builder: (context, setState) {
                //         return const AddUserPopUp();
                //       });
                //     });
              },
            ),
          )
          //Buscar(empleadoProvider: empleadoProvider),
          /*
          // Add Vehicle
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40),
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 213,
              decoration: BoxDecoration(
                  color: const Color(0xff2E5596),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(10, 10),
                      color: Colors.black.withOpacity(0.25),
                    )
                  ],
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                children: const [
                  Text(
                    "Add Vehicle",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.inventory_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),
          // Edit Vehicle
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 213,
              decoration: BoxDecoration(
                  color: const Color(0xff2E5596),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(10, 10),
                      color: Colors.black.withOpacity(0.25),
                    )
                  ],
                  borderRadius: BorderRadius.circular(50)),
              child: const Text(
                "Edit Vehicle",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // Delete Vehicle
          Padding(
            padding: const EdgeInsets.only(right: 40),
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 213,
              decoration: BoxDecoration(
                  color: const Color(0xffBF2135),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(10, 10),
                      color: Colors.black.withOpacity(0.25),
                    )
                  ],
                  borderRadius: BorderRadius.circular(50)),
              child: const Text(
                "Delete Vehicle",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          // Export Data
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 213,
              decoration: BoxDecoration(
                  color: const Color(0xff2E5596),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      offset: Offset(10, 10),
                      color: Colors.black.withOpacity(0.25),
                    )
                  ],
                  borderRadius: BorderRadius.circular(50)),
              child: const Text(
                "Export Data",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          */
        ],
      ),
    );
  }
}

// class Buscar extends StatelessWidget {
//   const Buscar({
//     Key? key,
//     required this.empleadoProvider,
//   }) : super(key: key);

//   final EmpleadosProvider empleadoProvider;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
//       child: Container(
//         width: 250,
//         height: 51,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),
//           border: Border.all(
//             color: AppTheme.of(context).primaryColor,
//             width: 1.5,
//           ),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Padding(
//               padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
//               child: Icon(
//                 Icons.search,
//                 color: AppTheme.of(context).primaryColor,
//                 size: 24,
//               ),
//             ),
//             Center(
//               child: SizedBox(
//                 width: 200,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 5,
//                   ),
//                   child: TextFormField(
//                     controller: empleadoProvider.busquedaController,
//                     /* autofocus: true, */
//                     decoration: InputDecoration(
//                       labelText: 'Buscar',
//                       /*  hintText: 'Buscar', */
//                       hintStyle: AppTheme.of(context).subtitle1.override(
//                             fontSize: 14,
//                             fontFamily: 'Gotham-Light',
//                             fontWeight: FontWeight.normal,
//                             useGoogleFonts: false,
//                           ),
//                       enabledBorder: const UnderlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                       focusedBorder: const UnderlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                     style: AppTheme.of(context).bodyText1.override(
//                           fontFamily: 'Poppins',
//                           fontSize: 15,
//                           fontWeight: FontWeight.normal,
//                         ),
//                     onChanged: (value) async {
//                       //await provider.getUsuarios();
//                       await empleadoProvider.getEmpleado();
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
