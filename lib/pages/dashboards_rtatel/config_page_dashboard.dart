import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:flutter/material.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../widgets/captura/custom_text_field.dart';

const showSnackBar = false;
const expandChildrenOnReady = true;

class ConfigPageDashboard extends StatefulWidget {
  const ConfigPageDashboard({super.key});

  @override
  State<ConfigPageDashboard> createState() => _ConfigPageDashboardState();
}

class _ConfigPageDashboardState extends State<ConfigPageDashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TreeViewController? _controller;
    TextEditingController nameController = TextEditingController();
    final GlobalKey<_ConfigPageDashboardState> treeViewKey = GlobalKey();

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(children: [
        const SideMenu(),
        Expanded(
          child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black)),
                    child: Scaffold(
                      floatingActionButton: ValueListenableBuilder<bool>(
                        valueListenable: sampleTree.expansionNotifier,
                        builder: (context, isExpanded, _) {
                          return FloatingActionButton.extended(
                            onPressed: () {
                              if (sampleTree.isExpanded) {
                                _controller?.collapseNode(sampleTree);
                              } else {
                                _controller?.expandAllChildren(sampleTree);
                              }
                            },
                            label: isExpanded
                                ? const Text("Collapse all")
                                : const Text("Expand all"),
                          );
                        },
                      ),
                      body: TreeView.simpleTyped(
                        expansionBehavior: ExpansionBehavior.scrollToLastChild,
                        tree: sampleTree,
                        showRootNode: true,
                        expansionIndicatorBuilder: (context, node) =>
                            ChevronIndicator.rightDown(
                          tree: node,
                          // color: Colors.blue[700],
                          color: Colors.black,
                          padding: const EdgeInsets.all(8),
                        ),
                        indentation:
                            const Indentation(style: IndentStyle.squareJoint),
                        onItemTap: (item) {
                          // if (kDebugMode) print("Item tapped: ${item.key}");

                          if (showSnackBar) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Item tapped: ${item.key}"),
                                duration: const Duration(milliseconds: 750),
                              ),
                            );
                          }
                        },
                        onTreeReady: (controller) {
                          _controller = controller;
                          if (expandChildrenOnReady) {
                            controller.expandAllChildren(sampleTree);
                          }
                        },
                        builder: (context, node) => Card(
                          // color: Colors.green,
                          color: Colors.blue[100],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CustomTextField(
                                label: "",
                                icon: Icons.workspace_premium_outlined,
                                controller: nameController,
                                enabled: true,
                                width: 100,
                                keyboardType: TextInputType.text,
                                maxLength: 5,
                              ),
                              // Text("${node.key}"),
                              InkWell(
                                child: Icon(Icons.add),
                                onTap: () {
                                  node.add(TreeNode(key: "${node.key}"));
                                },
                              ),
                              InkWell(
                                child: Icon(Icons.remove),
                                onTap: () {
                                  node.delete();
                                },
                              )
                            ],
                          ),
                        ),
                        // builder: (context, node) => Card(
                        //   color: Colors.green,
                        //   child: ListTile(
                        //     title: Text("Item ${node.level}-${node.key}"),
                        //     subtitle: Text('Level ${node.level}'),
                        //     onTap: () {
                        //       node.delete();

                        //       // node.remove(
                        //       //     TreeNode(key: "${node.level} - ${node.key}"));
                        //     },
                        //     onLongPress: () {
                        //       node.add(
                        //           TreeNode(key: "${node.level} - ${node.key}"));
                        //       // node.remove(
                        //       //     TreeNode(key: "${node.level} - ${node.key}"));
                        //     },
                        //   ),
                        // ),
                      ),
                    ),
                  ),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Agrega un nuevo contenedor a la lista al presionar el botón
                  //     setState(() {
                  //       containers.add(
                  //         Container(
                  //           width: 100,
                  //           height: 100,
                  //           color: Colors.blue,
                  //           margin: EdgeInsets.all(8.0),
                  //         ),
                  //       );
                  //     });
                  //   },
                  //   child: Text('Agregar Contenedor'),
                  // ),
                  // ListView(
                  //   children: containers,
                  // )
                ]),
          ),
        )
      ]),
    );
  }
}

final sampleTree = TreeNode.root()
  ..addAll([
    // Menu
    TreeNode(key: "Surveys")
      ..add(
        // Option
        TreeNode(key: "Opco Subscriber Target"),
      ),
    TreeNode(key: "Sales")
      ..addAll([
        // Option/Submenu
        TreeNode(key: "Configurator")
          // TreeNode(key: "0C1B"),
          // TreeNode(key: "0C1C")
          ..addAll([
            // Option
            TreeNode(key: "Configurator Stats"),
            TreeNode(key: "No coverage Leads"),
            TreeNode(key: "New Configurator Stats"),
            TreeNode(key: "Referrals Tracking"),
          ]),
      ]),
    // Menu
    TreeNode(key: "Manager"),
    TreeNode(key: "GigFast Network"),
    TreeNode(key: "Call Center"),
    TreeNode(key: "FMT"),
    TreeNode(key: "WOP"),
  ]);
