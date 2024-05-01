import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/models/jsa/team_members.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/doc_creation_card.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_safety_briefing_provider.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

import '../../../../models/user.dart';

class TeamMembersSafety extends StatefulWidget {
  const TeamMembersSafety({super.key});

  @override
  State<TeamMembersSafety> createState() => _TeamMembersSafetyState();
}

class _TeamMembersSafetyState extends State<TeamMembersSafety> {
  List<User> membersSelection = [];

  @override
  void initState() {
    super.initState();
    membersSelection = [];
  }

  @override
  Widget build(BuildContext context) {
    TeamMembersSafetyModel teamMember =
        TeamMembersSafetyModel(name: "", role: "", pic: "", id: "");
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);

    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: CustomCard(
        title: "List of Users",
        // height: 700,
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.2,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width * 0.3,
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CustomDropSafety(
                    title: "OpCo Name",
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
                            provider.teamMembers.clear();
                            print(
                                "Memberselection: ${membersSelection.length}");
                            print(
                                "TeamMembersSafety: ${provider.teamMembers.length}");
                            // provider.deleteTeamMembersSafety(provider.users.id.toString());
                          } else {
                            for (var user in provider.users) {
                              membersSelection.add(user);
                              // allselected = true;
                              teamMember = TeamMembersSafetyModel(
                                name: user.name,
                                role: user.currentAppRole,
                                id: user.id,
                                pic: user.image,
                              );
                              provider.addTeamMembers(teamMember);
                            }
                          }

                          // Se supone que al volver a seleccionarlo y la lista esta llena, entonces lo limpiara
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
                ],
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
                                      teamMember = TeamMembersSafetyModel(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.04,
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
        ),
      ),
    );
  }
}

String text = "CRY";

class CustomDropSafety extends StatefulWidget {
  final String title;
  const CustomDropSafety({Key? key, required this.title});

  @override
  _CustomDropSafetyState createState() => _CustomDropSafetyState();
}

class _CustomDropSafetyState extends State<CustomDropSafety> {
  @override
  Widget build(BuildContext context) {
    // JsaProvider provider = Provider.of<JsaProvider>(context);
    JsaSafetyProvider provider = Provider.of<JsaSafetyProvider>(context);

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: Color(0xFF737373),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xFF335594), width: 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton(
                value: text,
                items: const [
                  DropdownMenuItem(
                    value: "CRY",
                    child: Text("CRY"),
                  ),
                  DropdownMenuItem(
                    value: "ODE",
                    child: Text("ODE"),
                  ),
                  DropdownMenuItem(
                    value: "SMI",
                    child: Text("SMI"),
                  ),
                ],
                onChanged: (value) {
                  text = value.toString();
                  provider.companyController.text = text;
                  // print(provider.companyController.text);
                  provider.getListUsers(provider.companyController.text);

                  if (provider.companyController.text ==
                      provider.companyController.text) {
                    provider.teamMembers.clear();
                  }
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
