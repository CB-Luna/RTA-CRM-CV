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
                            width: MediaQuery.of(context).size.width * 0.04,
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
