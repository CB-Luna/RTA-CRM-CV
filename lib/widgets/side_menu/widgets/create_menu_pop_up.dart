// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:rta_crm_cv/services/api_error_handler.dart';
// import 'package:rta_crm_cv/theme/theme.dart';

// import '../../../pages/ctrlv/download_apk/widgets/success_toast.dart';
// import '../../../providers/menu_provider.dart';
// import '../../custom_ddown_menu/custom_dropdown_inventory.dart';
// import '../../custom_text_fieldForm.dart';
// import '../../custom_text_icon_button.dart';

// class CreateMenuPopUP extends StatefulWidget {
//   const CreateMenuPopUP({super.key});

//   @override
//   State<CreateMenuPopUP> createState() => _CreateMenuPopUPState();
// }

// class _CreateMenuPopUPState extends State<CreateMenuPopUP> {
//   FToast fToast = FToast();

//   @override
//   Widget build(BuildContext context) {
//     fToast.init(context);
//     final formKey = GlobalKey<FormState>();

//     MenuProvider provider = Provider.of<MenuProvider>(context);
//     provider.getMenu(notify: false);

//     return AlertDialog(
//         content: Container(
//       padding: const EdgeInsets.all(10.0),
//       height: 300,
//       width: 400,
//       child: Form(
//         key: formKey,
//         child: Column(children: [
//           Text(
//             "Create new Menu",
//             style: AppTheme.of(context).subtitle1,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 14),
//             child: CustomTextFieldForm(
//               label: '',
//               controller: provider.menuController!,
//               enabled: true,
//               width: 350,
//               keyboardType: TextInputType.name,
//               // inputFormatters: [cardMaskModel],
//             ),
//           ),
//           CheckboxAndVisibilityWidget(),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               CustomTextIconButton(
//                   isLoading: false,
//                   icon: Icon(Icons.save_outlined,
//                       color: AppTheme.of(context).primaryBackground),
//                   text: 'Add Menu',
//                   onTap: () async {
//                     if (!formKey.currentState!.validate()) {
//                       return;
//                     }
//                     //Crear Servicio del vehiculo
//                     bool res = await provider.createMenu();

//                     if (!res) {
//                       await ApiErrorHandler.callToast('Error creating Menu');
//                       return;
//                     }

//                     if (!mounted) return;
//                     fToast.showToast(
//                       child: const SuccessToast(
//                         message: 'Menu Added Succesfuly',
//                       ),
//                       gravity: ToastGravity.BOTTOM,
//                       toastDuration: const Duration(seconds: 2),
//                     );

//                     if (context.canPop()) context.pop();
//                   }),
//             ],
//           )
//         ]),
//       ),
//     ));
//   }
// }

// class CheckboxAndVisibilityWidget extends StatefulWidget {
//   const CheckboxAndVisibilityWidget({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _CheckboxAndVisibilityWidgetState createState() =>
//       _CheckboxAndVisibilityWidgetState();
// }

// class _CheckboxAndVisibilityWidgetState
//     extends State<CheckboxAndVisibilityWidget> {
//   bool isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     MenuProvider provider = Provider.of<MenuProvider>(context);

//     final List<String> menuname =
//         provider.menuDashboards.map((menudash) => menudash.menuName).toList();
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Row(
//           children: [
//             Checkbox(
//               value: provider.isChecked,
//               onChanged: (value) {
//                 setState(() {
//                   provider.isChecked = value!;
//                 });
//               },
//             ),
//             const Text('Quieres agregar un submenu?'),
//           ],
//         ),
//         // Visibility(
//         //   visible: isChecked,
//         //   child: Padding(
//         //     padding: const EdgeInsets.symmetric(vertical: 14),
//         //     child: CustomTextFieldForm(
//         //       label: '',
//         //       controller: provider.submenuController!,
//         //       enabled: true,
//         //       width: 350,
//         //       keyboardType: TextInputType.name,
//         //       // inputFormatters: [cardMaskModel],
//         //     ),
//         //   ),
//         // ),
//         Visibility(
//             visible: provider.isChecked,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 7),
//               child: CustomDropDownInventory(
//                 hint: 'Choose a menu',
//                 label: '',
//                 width: 350,
//                 list: menuname,
//                 dropdownValue: provider.menuDashboardSelected?.menuName,
//                 onChanged: (val) {
//                   if (val == null) return;
//                   provider.selectMenu(val);
//                 },
//               ),
//             )),
//       ],
//     );
//   }
// }
