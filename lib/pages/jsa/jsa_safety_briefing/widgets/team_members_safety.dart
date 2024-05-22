import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/models/jsa/team_members.dart';
import 'package:rta_crm_cv/providers/jsa/jsa_safety_briefing_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';

class TeamMembersSafety extends StatefulWidget {
  const TeamMembersSafety({super.key});

  @override
  State<TeamMembersSafety> createState() => _TeamMembersSafetyState();
}

class _TeamMembersSafetyState extends State<TeamMembersSafety> {
  @override
  void initState() {
    super.initState();
    // provider.membersSelection = [];
  }

  @override
  Widget build(BuildContext context) {
    TeamMembersSafetyModel teamMember;
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
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            if (provider.membersSelection.isNotEmpty) {
                              var membersCopy =
                                  List.from(provider.membersSelection);

                              for (var user in membersCopy) {
                                provider.membersSelection.remove(user);
                                provider.deleteTeamMembers(user.id.toString());
                              }
                            } else {
                              for (var user in provider.users) {
                                provider.membersSelection.add(user);
                                // allselected = true;
                                teamMember = TeamMembersSafetyModel(
                                    name: user.fullName,
                                    role:
                                        // provider.companyController.text == "RTA"
                                        //     ? user.roles.first.roleName
                                        //     : user.currentAppRole,
                                        user.roles.first.roleName,
                                    id: user.id,
                                    pic: user.image,
                                    email: user.email);
                                provider.addTeamMembers(teamMember);
                              }
                            }
                          });
                        },
                        child: provider.membersSelection.isNotEmpty
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: AppTheme.of(context).odePrimary,
                                      width: 1.0),
                                ),
                                child: Text(
                                  'Unselect All',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppTheme.of(context).odePrimary,
                                    fontSize: 15,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              )
                            : Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.06,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                      color: const Color(0xFF335594),
                                      width: 1.0),
                                ),
                                child: const Text(
                                  'Select All',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF335594),
                                    fontSize: 15,
                                    fontFamily: 'Outfit',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              )),
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
                height: MediaQuery.of(context).size.height * 0.4,
                // height: MediaQuery.of(context).size.height * 0.7,
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
                                  value:
                                      provider.membersSelection.contains(user),
                                  // Set the initial value as per your requirement
                                  onChanged: (bool? value) {
                                    if (value == true) {
                                      provider.membersSelection.add(user);
                                      teamMember = TeamMembersSafetyModel(
                                          name: user.fullName,
                                          // role: user.currentAppRole,
                                          role: user.roles.first.roleName,
                                          // provider.companyController.text ==
                                          //         "RTA"
                                          //     ? user.roles.first.roleName
                                          //     : user.currentAppRole,
                                          id: user.id,
                                          email: user.email,
                                          pic: user.image);
                                      provider.addTeamMembers(teamMember);
                                    } else {
                                      provider.membersSelection.remove(user);
                                      provider.deleteTeamMembers(
                                          provider.users[index].id.toString());
                                    }
                                  },
                                ),
                              ),

                              Container(
                                alignment: Alignment.centerLeft,
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
                                    user.roles.first.roleName,
                                    // provider.companyController.text == "RTA"
                                    //     ? user.roles.first.roleName
                                    //     : user.currentAppRole,
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
              // Container(
              //   height: 50,
              //   color: Colors.red,
              // )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      var membersCopy = List.from(provider.membersSelection);

                      for (var user in membersCopy) {
                        provider.membersSelection.remove(user);
                        provider.deleteTeamMembers(user.id.toString());
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      height: MediaQuery.of(context).size.height * 0.04,
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppTheme.of(context).odePrimary,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Cancel", style: AppTheme.of(context).subtitle2),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.pop();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      height: MediaQuery.of(context).size.height * 0.04,
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppTheme.of(context).cryPrimary,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Accept", style: AppTheme.of(context).subtitle2),
                        ],
                      ),
                    ),
                  ),
                ],
              )
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 13.0),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Color(0xFF737373),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
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
                  DropdownMenuItem(
                    value: "RTA",
                    child: Text("RTA"),
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
