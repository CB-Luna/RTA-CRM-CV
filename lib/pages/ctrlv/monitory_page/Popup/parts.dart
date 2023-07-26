import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/monitory_provider.dart';
import '../../../../public/colors.dart';
import '../../../../widgets/card_header.dart';
import 'comments_images_issues.dart';

class BucketExtraPopUp extends StatelessWidget {
  final int popUp;
  const BucketExtraPopUp({
    super.key, required this.popUp,
  });
  //pedir ID de control form para conectar con als demas

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: Container(
        width: 700,
        height: 670,
        decoration: BoxDecoration(
            gradient: whiteGradient, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            CardHeader(text: "Bucket Inspection"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20),
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                        onPressed: () {
                          provider.updateViewPopup(0);
                        },
                        child: Icon(
                                Icons.arrow_back
                              ),),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 550,
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: provider.actualIssuesComments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 250,
                            // color: Colors.red,
                            child: Text(
                              provider.actualIssuesComments[index].nameIssue.capitalize.replaceAll("_", ' '),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 100,
                            //color: Colors.yellow,
                            //alignment: Alignment.center,
                            child: Text(
                              provider.actualIssuesComments[index].status ? "Yes" : "No",
                              style:  TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: provider.actualIssuesComments[index].status ? Color.fromARGB(200, 65, 155, 23) : Color.fromARGB(200, 210, 0, 48), 
                              ),
                            ),
                          ),
                          InkWell(
                          child: provider.actualIssuesComments[index].status
                            ? Icon(Icons.remove_red_eye,
                                size: 30,
                                color: Color.fromARGB(200, 65, 155, 23))
                            : Icon(Icons.remove_red_eye,
                              size: 30,
                                color: Color.fromARGB(200, 210, 0, 48)),
                          onTap: () {
                            provider.getActualDetailField(provider.actualIssuesComments[index]);
                            provider.updateViewPopup(10);
                          },
                          
                        ),
                        ],
                      ),
                    );
                  }),
            ),
            
          ],
        ),
      ),
    );
  }
}
