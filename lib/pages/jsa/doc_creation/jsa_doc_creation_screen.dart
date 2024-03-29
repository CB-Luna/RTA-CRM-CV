import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/doc_creation_card.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../../providers/jsa/jsa_provider.dart';
import '../../../theme/theme.dart';

class JsaDocCreationScreen extends StatefulWidget {
  const JsaDocCreationScreen({super.key});

  @override
  State<JsaDocCreationScreen> createState() => _JsaDocCreationScreenState();
}

class _JsaDocCreationScreenState extends State<JsaDocCreationScreen> {
  // @override
  // void initState() {
  //   super.initState();

  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     final JsaProvider provider = Provider.of<JsaProvider>(
  //       context,
  //       listen: false,
  //     );
  //     await provider.updateState();
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    JsaProvider provider = Provider.of<JsaProvider>(context);

    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SideMenu(),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(gradient: whiteGradient),
                child: CustomScrollBar(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, top: 10, right: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: Icon(
                                      Icons.document_scanner_outlined,
                                      color: AppTheme.of(context).primaryColor,
                                      size: 35,
                                    ))),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                height: 40,
                                child: Text('JSA Document Creation',
                                    style: AppTheme.of(context).title1),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          // Select Members
                          IconButtonCustom(
                            icon: Icons.edit_document,
                            selected: provider.selectedList,
                            circle: provider.circleList,
                          ),
                          // Create Task, Risk, Control
                          IconButtonCustomDivisor(),
                          IconButtonCustom(
                            icon: Icons.person,
                            selected: provider.selectedTask,
                            circle: provider.circleListTask,
                          ),
                          // Resume
                          IconButtonCustomDivisor(),
                          IconButtonCustom(
                            icon: Icons.auto_awesome_motion_rounded,
                            selected: provider.selectedResume,
                            circle: provider.circleResume,
                          ),
                          // Final
                          IconButtonCustomDivisor(),
                          IconButtonCustom(
                            icon: Icons.lock,
                            selected: provider.selectedFinal,
                            circle: provider.circleFinal,
                          ),
                        ],
                      ),
                      // const CustomDocCreationCard(),
                      Builder(
                        builder: (context) {
                          final view =
                              provider.viewTaped[provider.buttonViewTaped];
                          return Container(
                            child: view,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
