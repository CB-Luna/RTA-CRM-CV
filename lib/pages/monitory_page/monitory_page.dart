import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../providers/monitory_provider.dart';
import 'monitory_page_desktop.dart';

class MonitoryPage extends StatefulWidget {
  MonitoryPage({Key? key}) : super(key: key);

  @override
  State<MonitoryPage> createState() => _MonitoryPageState();
}

class _MonitoryPageState extends State<MonitoryPage> {
  final AdvancedDrawerController drawerController = AdvancedDrawerController();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      MonitoryProvider provider = Provider.of<MonitoryProvider>(
        context,
        listen: false,
      );
      await provider.getMonitory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    final AdvancedDrawerController drawerController =
        AdvancedDrawerController();

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return ResponsiveApp(
      builder: (context) {
        return ScreenTypeLayout.builder(
          mobile: (BuildContext context) => Container(color: Colors.blue),
          tablet: (BuildContext context) => MonitoryPageDesktop(
              key: UniqueKey(),
              drawerController: drawerController,
              scaffoldKey: scaffoldKey,
              provider: provider),
          desktop: (BuildContext context) => MonitoryPageDesktop(
              key: UniqueKey(),
              drawerController: drawerController,
              scaffoldKey: scaffoldKey,
              provider: provider),
          watch: (BuildContext context) => Container(color: Colors.green),
        );
      },
    );
  }
}
