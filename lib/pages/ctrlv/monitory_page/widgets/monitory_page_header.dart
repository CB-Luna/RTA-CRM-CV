import 'package:flutter/material.dart';

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/monitory_provider.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';

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
    final MonitoryProvider provider = Provider.of<MonitoryProvider>(context);

    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: CustomTextIconButton(
              isLoading: false,
              icon: Icon(Icons.download_outlined, color: AppTheme.of(context).primaryBackground),
              text: 'Export Data',
              onTap: () {
                provider.excelActivityReports();
              },
            ),
          )
        ],
      ),
    );
  }
}
