// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/models/jsa/jsa_general_information.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';

import '../../../../models/user.dart';
import '../../../../providers/jsa/jsa_provider.dart';

class TeamMemberList extends StatefulWidget {
  const TeamMemberList({super.key});

  @override
  _TeamMemberListState createState() => _TeamMemberListState();
}

class _TeamMemberListState extends State<TeamMemberList> {
  List<User> membersSelection = [];

  @override
  void initState() {
    super.initState();
    membersSelection = [];
  }

  @override
  Widget build(BuildContext context) {
    TeamMembers teamMember = TeamMembers(name: "", role: "", pic: "", id: "");

    JsaProvider provider = Provider.of<JsaProvider>(context);
    // membersSelection = List.filled(provider.users.length, false);
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.3,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomTextField(
              height: 35,
              width: 500,
              enabled: true,
              controller: provider.searchUserController,
              icon: Icons.search,
              label: 'Search',
              keyboardType: TextInputType.text,
              onChanged: (String query) async {
                provider.filterUsers(query);
                // provider.filterDocuments(query);
                // provider.updateState();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  alignment: Alignment.centerRight),
              onPressed: () {
                setState(() {
                  // Toggle all checkboxes
                  // bool allSelected =
                  //     !membersSelection.every((element) => element);
                  if (membersSelection.isNotEmpty) {
                    membersSelection.clear();
                    provider.jsaGeneralInfo!.teamMembers!.clear();
                    print("Memberselection: ${membersSelection.length}");
                    print(
                        "JsaGeneralInforTeamMembers: ${provider.jsaGeneralInfo!.teamMembers!.length}");
                    // provider.deleteTeamMembers(provider.users.id.toString());
                  } else {
                    for (var user in provider.users) {
                      membersSelection.add(user);
                      // allselected = true;
                      teamMember = TeamMembers(
                        name: user.name,
                        role: user.currentAppRole,
                        id: user.id,
                        pic: user.image,
                      );
                      provider.addTeamMembers(teamMember);
                    }
                  }

                  // Se supone que al volver a seleccionarlo y la lista esta llena, entonces lo limpiara

                  for (int i = 0; i < membersSelection.length; i++) {
                    // membersSelection[i] = allSelected;

                    // // Add or remove team members based on checkbox state
                    // if (allSelected) {
                    //   teamMember = TeamMembers(
                    //       name: membersSelection[i].name,
                    //       role: membersSelection[i].currentAppRole,
                    //       id: membersSelection[i].id,
                    //       pic: membersSelection[i].image);
                    //   setState(() {
                    //     provider.addTeamMembers(teamMember);
                    //   });
                    // } else {
                    //   setState(() {
                    //     provider
                    //         .deleteTeamMembers(provider.users[i].id.toString());
                    //   });
                    // }
                  }
                });
              },
              child: const Text(
                'Select All',
                style: TextStyle(
                  color: Color(0xFF335594),
                  fontSize: 15,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.04,
                child: const Text(
                  "Team Members",
                  style: TextStyle(
                    color: Color(0xFF335594),
                    fontWeight: FontWeight.bold,
                  ),
                  // overflow: TextOverflow.ellipsis,
                ),
              ),
              // User Role Placeholder
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * 0.04,
                  child: const Text(
                    'Rol',
                    style: TextStyle(
                      color: Color(0xFF335594),
                      fontWeight: FontWeight.bold,
                    ),
                    // overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.7,
            child: Builder(builder: (context) {
              return ListView.builder(
                  itemCount: provider.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = provider.users[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.02,
                            child: Checkbox(
                              activeColor: const Color(0xFF335594),
                              value: membersSelection.contains(user),
                              // Set the initial value as per your requirement
                              onChanged: (bool? value) {
                                if (value == true) {
                                  membersSelection.add(user);
                                  teamMember = TeamMembers(
                                      name: user.name,
                                      role: user.currentAppRole,
                                      id: user.id,
                                      pic: user.image);
                                  provider.addTeamMembers(teamMember);
                                } else {
                                  membersSelection.remove(user);
                                  provider.deleteTeamMembers(
                                      provider.users[index].id.toString());
                                }
                                // Handle checkbox state changes here
                              },
                            ),
                          ),
                          // Profile Picture Placeholder
                          // Container(
                          //   width: MediaQuery.of(context).size.width * 0.02,
                          //   child: const CircleAvatar(
                          //     radius: 20, // Adjust the size as needed
                          //     backgroundColor: Colors.grey, // Placeholder color
                          //     backgroundImage:
                          //         AssetImage('assets/images/avatar2.png'),
                          //   ),
                          // ),
                          // User Name Placeholder
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.06,
                            child: Text(
                              user.fullName,
                              style: const TextStyle(
                                fontSize: 15,
                                fontFamily: "Outfit",
                                color: Color(0xFF335594),
                              ),
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // User Role Placeholder
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.04,
                              child: Text(
                                user.currentAppRole,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Outfit",
                                  color: Color(0xFF335594),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }),
          ),
        ],
      )),
    );
  }
}
