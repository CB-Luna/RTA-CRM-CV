import 'package:flutter/material.dart';

import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/providers/ctrlv/monitory_provider.dart';

import '../../../../theme/theme.dart';
import '../../../../widgets/custom_text_icon_button.dart';
import '../Popup/export_monitory_data.dart';

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
            width: MediaQuery.of(context).size.width * 0.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomTextIconButton(
                  isLoading: false,
                  icon: Icon(Icons.download_outlined,
                      color: AppTheme.of(context).primaryBackground),
                  text: 'Export Data',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const ExportMonitoryDataFilter();
                      },
                    );
                  },
                ),
                CustomTextIconButton(
                  isLoading: false,
                  icon: Icon(Icons.filter_alt_outlined,
                      color: AppTheme.of(context).primaryBackground),
                  text: 'Filter',
                  onTap: () => provider.stateManager!.setShowColumnFilter(
                      !provider.stateManager!.showColumnFilter),
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Worker Role',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).managerPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Manager',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).techSupPrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Tech Supervisor',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Container(
                            height: 35,
                            width: 150,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context).employeePrimary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Employee',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
