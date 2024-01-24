import 'dart:js_interop';

import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:animated_tree_view/tree_view/tree_node.dart';
import 'package:animated_tree_view/tree_view/tree_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';

import '../../providers/config_page_provider.dart';
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
    // final GlobalKey<_ConfigPageDashboardState> treeViewKey = GlobalKey();
    // final Map<String, TextEditingController> controllers = {};
    // final Map<String, TextEditingController> controllersRoute = {};
    ConfigPageProvider provider = Provider.of<ConfigPageProvider>(context);

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
                    width: MediaQuery.of(context).size.width * 0.5,
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
                      body: TreeView.simple(
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
                        // Declara una lista de controladores

                        builder: (context, node) {
                          // Convierte la clave del nodo a un número
                          // int nodeKey = int.tryParse(node.key) ?? 0;
                          // // Verifica si el controlador ya ha sido creado para este nodo
                          // if (controllers.length <= nodeKey) {
                          //   // Si no existe, crea un nuevo controlador para este nodo
                          //   controllers.add(TextEditingController());
                          // }
                          TextEditingController controllerName =
                              provider.controllers[node.key] ??
                                  TextEditingController();

                          TextEditingController controllerRoute =
                              provider.controllersRoute[node.key] ??
                                  TextEditingController();

                          provider.controllerName = controllerName;
                          // controllersRoute == null
                          //     ? node.data = "Route"
                          //     : node.data = controllersRoute;
                          return Card(
                            color: Colors.blue[100],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: CustomTextField(
                                        height: 10,
                                        label: node.key,
                                        // label: node.data.toString(),
                                        icon: Icons.workspace_premium_outlined,
                                        controller: provider.controllerName ??
                                            controllerName,
                                        // controller: controllers[nodeKey],
                                        enabled: true,
                                        width: 250,
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: CustomTextField(
                                        height: 10,
                                        label: node.data.toString() == "null"
                                            ? "Route"
                                            : node.data.toString(),
                                        icon: Icons.workspace_premium_outlined,
                                        controller: controllerRoute,
                                        enabled: true,
                                        width: 250,
                                        keyboardType: TextInputType.text,
                                      ),
                                    ),
                                  ],
                                ),
                                InkWell(
                                  child: Icon(Icons.add),
                                  onTap: () {
                                    provider.controllerName.text =
                                        controllerName.text;
                                    node.add(TreeNode(
                                        key: controllerName.text,
                                        data: controllerRoute.text));

                                    provider.controllers["${node.key}"] =
                                        TextEditingController(
                                            text: controllerName.text);

                                    provider.controllersRoute["${node.key}"] =
                                        TextEditingController(
                                            text: controllerRoute.text);

                                    print(
                                        "ControlerName: ${controllerName.text}");
                                    print(
                                        "Provider de controllerName: ${provider.controllerName.text} del node: ${node.key}");

                                    if (provider.controllerName.text !=
                                        "null") {
                                      print("Entro en createMenuPage");
                                      provider.createMenuPage(node.key);

                                      int idMenu = 0;
                                      print(
                                          "Cuantos valores hay en listaMenu: ${provider.listaMenu.length}");
                                      // Bucle para buscar en la lista
                                      // for (var lista in provider.listaMenu) {
                                      //   lista.forEach((elemento) {
                                      //     if (elemento["menu_name"] ==
                                      //         node.key) {
                                      //       idMenu = elemento["id"];
                                      //     }
                                      //   });
                                      // }
                                      print("------------------");
                                      print("El id de ${node.key} + $idMenu");
                                    }
                                    controllerName.clear();
                                    controllerRoute.clear();
                                    provider.controllerName.clear();
                                    provider.controllerRoute.clear();
                                    setState(() {});
                                    // final newNodeKey = nodeKey + 1;
                                    // controllers["${node.key}-$newNodeKey"] =
                                    //     TextEditingController();
                                    // node.add(TreeNode(
                                    //     key: "${node.key}-$newNodeKey"));
                                    // print(
                                    //     "${node.key} +$newNodeKey +${controllers[nodeKey]}");
                                    // setState(() {});
                                    // node.add(TreeNode(key: "${node.key}+1"));
                                  },
                                ),
                                InkWell(
                                  child: const Icon(Icons.remove),
                                  onTap: () {
                                    node.delete();
                                    provider.controllers.remove(node.key);
                                    setState(() {});
                                    // node.delete();
                                  },
                                )
                              ],
                            ),
                          );
                        },

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
