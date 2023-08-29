// import 'package:flutter/material.dart';
// import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
// import 'package:provider/provider.dart';
// import 'package:responsive_builder/responsive_builder.dart';
// import 'package:rta_crm_cv/providers/ctrlv/inventory_provider.dart';

// import 'inventory_page_desktop.dart';

// class InventoryPage extends StatefulWidget {
//   const InventoryPage({Key? key}) : super(key: key);

//   @override
//   State<InventoryPage> createState() => _InventoryPageState();
// }

// class _InventoryPageState extends State<InventoryPage> {
//   final AdvancedDrawerController drawerController = AdvancedDrawerController();

//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
//       InventoryProvider provider = Provider.of<InventoryProvider>(
//         context,
//         listen: false,
//       );
//       await provider.updateState();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final InventoryProvider provider = Provider.of<InventoryProvider>(context);
//     final AdvancedDrawerController drawerController =
//         AdvancedDrawerController();

//     final scaffoldKey = GlobalKey<ScaffoldState>();

//     return ResponsiveApp(
//       builder: (context) {
//         return ScreenTypeLayout.builder(
//           mobile: (BuildContext context) => Container(color: Colors.blue),
//           tablet: (BuildContext context) => InventoryPageDesktop(
//               key: UniqueKey(),
//               drawerController: drawerController,
//               scaffoldKey: scaffoldKey,
//               provider: provider),
//           desktop: (BuildContext context) => InventoryPageDesktop(
//               key: UniqueKey(),
//               drawerController: drawerController,
//               scaffoldKey: scaffoldKey,
//               provider: provider),
//           watch: (BuildContext context) => Container(color: Colors.green),
//         );
//       },
//     );
//   }
// }
