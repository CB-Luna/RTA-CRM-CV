// ignore_for_file: library_private_types_in_public_api

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/models/jsa/jsa_general_information.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';

import '../../../../providers/jsa/jsa_provider.dart';

class TeamMemberList extends StatefulWidget {
  const TeamMemberList({super.key});

  @override
  _TeamMemberListState createState() => _TeamMemberListState();
}

class _TeamMemberListState extends State<TeamMemberList> {
  @override
  Widget build(BuildContext context) {
    var membersSelection = [];

    TeamMembers teamMember =
        new TeamMembers(name: "", role: "", pic: "", id: "");

    JsaProvider provider = Provider.of<JsaProvider>(context);
    membersSelection = List.filled(provider.users.length, false);

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.3,
      child: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: CustomTextField(
              height: 35,
              width: 500,
              enabled: true,
              controller: provider.searchController,
              icon: Icons.search,
              label: 'Search',
              keyboardType: TextInputType.text,
              onChanged: (String query) async {
                // provider.filterDocuments(query);
                // provider.updateState();
              },
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
          SingleChildScrollView(
            child: Column(
              children: List.generate(provider.users.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.02,
                        child: Checkbox(
                          activeColor: const Color(0xFF335594),
                          value: membersSelection[index],
                          // Set the initial value as per your requirement
                          onChanged: (bool? value) {
                            print(provider.users[index].name);
                            setState(() {
                              membersSelection[index] =
                                  !membersSelection[index];
                              print(
                                  "memberSelection: ${membersSelection[index]}");
                            });
                            if (membersSelection[index] == true) {
                              teamMember = TeamMembers(
                                  name: provider.users[index].name,
                                  role: provider.users[index].currentAppRole,
                                  id: provider.users[index].id,
                                  // ignore: unnecessary_null_in_if_null_operators
                                  pic: provider.users[index].image ?? "");
                              provider.addTeamMembers(teamMember);
                            } else {
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
                        width: MediaQuery.of(context).size.width * 0.04,
                        child: Text(
                          provider.users[index].fullName,
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
                            provider.users[index].currentAppRole,
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
              }),
            ),
          ),
        ],
      )),
    );
  }
}
