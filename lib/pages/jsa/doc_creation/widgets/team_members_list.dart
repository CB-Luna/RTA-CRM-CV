import 'package:flutter/material.dart';

class TeamMemberList extends StatefulWidget {
  @override
  _TeamMemberListState createState() => _TeamMemberListState();
}

class _TeamMemberListState extends State<TeamMemberList> {
  bool _isExpanded = false;
  int _numTeamMembers = 5; // Number of team members to display

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Container(
      color: Colors.transparent,
        padding: const  EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 0.3,
        child: Container(
            decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: Colors.transparent
       
        ),
          height: _isExpanded ? MediaQuery.of(context).size.height * 0.38 : MediaQuery.of(context).size.height * 0.1,
          child: SingleChildScrollView(
            child: ExpansionPanelList(
              expandedHeaderPadding: EdgeInsets.zero,
              elevation: 0,
              dividerColor: Colors.transparent,
              expansionCallback: (panelIndex, isExpanded) {
                setState(() {
                  _isExpanded = !isExpanded;
                });
              },
              children: [
                ExpansionPanel(
                  backgroundColor: Color.fromARGB(255, 219, 229, 248),
                  isExpanded: _isExpanded,
                  headerBuilder: (context, isExpanded) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              'Team Members',
                              style: TextStyle(
                                color: Color(0xFF335594),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  body: SingleChildScrollView(
                    child: Column(
                      children: List.generate(_numTeamMembers, (index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    0.05,
                                child: Checkbox(
                                  activeColor: const Color(0xFF335594),
                                  value: false,
                                  // Set the initial value as per your requirement
                                  onChanged: (bool? value) {
                                    // Handle checkbox state changes here
                                  },
                                ),
                              ),
                              // Profile Picture Placeholder
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    0.02,
                                child: const CircleAvatar(
                                  radius: 20, // Adjust the size as needed
                                  backgroundColor:
                                      Colors.grey, // Placeholder color
                                  backgroundImage: AssetImage(
                                      'assets/images/avatar2.png'),
                                ),
                              ),
                              // User Name Placeholder
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width *
                                      0.04,
                                  child: const Text(
                                    "User Name",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Outfit",
                                      color: Color(0xFF335594),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              // User Role Placeholder
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width *
                                      0.04,
                                  child: const Text(
                                    "User Role Placeholder",
                                    style: TextStyle(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
