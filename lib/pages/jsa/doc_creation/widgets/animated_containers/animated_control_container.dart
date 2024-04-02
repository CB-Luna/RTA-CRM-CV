import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/jsa/jsa_provider.dart';
import '../../risks_hazards_widget.dart';
import '../popups/control_matrix_popup.dart';
import '../popups/control_popups.dart';

class AnimatedControlContainer extends StatefulWidget {
  const AnimatedControlContainer({
    super.key,
  });

  @override
  State<AnimatedControlContainer> createState() =>
      _AnimatedControlContainerState();
}

class _AnimatedControlContainerState extends State<AnimatedControlContainer> {
  @override
  Widget build(BuildContext context) {
    JsaProvider jsaProvider = Provider.of<JsaProvider>(context, listen: true);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: MediaQuery.of(context).size.height * 0.21,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF335594)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // First Row
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Menu Icon
                  const Icon(
                    Icons.security_rounded,
                    color: Color(0xFF335594),
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  // Text "Steps"
                  Expanded(
                    child: Text(
                      'Control',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFF335594),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  // Open/Close Button
                  const Spacer(),
                ],
              ),
            ),

            // Second Row (Additional content when the container is open)
            // if (isContainerOpen)
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: jsaProvider.jsa.jsaStepsJson!.length,
                itemBuilder: (context, i) => Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Menu Icon

                    Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      alignment: Alignment.center,
                      child: Text(
                        jsaProvider.jsa.jsaStepsJson![i].title.toString(),
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Color(0xFF335594),
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Outfit',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    // Text "Steps"
                    Container(
                      width: MediaQuery.of(context).size.width * 0.07,
                      alignment: Alignment.center,
                      child: Text(
                        jsaProvider.jsa.jsaStepsJson![i].controls.isEmpty
                            ? 'No Control(s)'
                            //corregir para que haga display el numero correcto
                            : '${jsaProvider.jsa.jsaStepsJson![i].controls.length} Control(s)',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Outfit',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => showControlMatrixPopup(
                              context,
                              jsaProvider.jsa.jsaStepsJson![i].id.toString(),
                              jsaProvider),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: jsaProvider
                                        .jsa.jsaStepsJson![i].controlColor ??
                                    Colors.transparent,
                                width: 1.0,
                              ),
                              color: jsaProvider
                                          .jsa.jsaStepsJson![i].controlColor ==
                                      Colors.transparent
                                  ? Colors.transparent
                                  : jsaProvider
                                      .jsa.jsaStepsJson![i].controlColor,
                            ),
                            child: Text(
                              jsaProvider.jsa.jsaStepsJson![i].controlLevel!
                                      .isEmpty
                                  ? 'N/A'
                                  : jsaProvider
                                      .jsa.jsaStepsJson![i].controlLevel
                                      .toString(),
                              style: const TextStyle(
                                fontSize: 15.0,
                                color: Color(0xFF335594),
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Outfit',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.remove_red_eye,
                            color: Color(0xFF335594),
                          ),
                          onPressed: () {
                            showControlPopup(
                                context,
                                jsaProvider.jsa.jsaStepsJson![i].title,
                                jsaProvider.jsa.jsaStepsJson![i].id.toString());
                          },
                        ),
                      ],
                    ),

                    // Open/Close Button
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
