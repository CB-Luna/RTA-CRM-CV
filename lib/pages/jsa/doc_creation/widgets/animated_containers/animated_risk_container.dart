import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/jsa/jsa_provider.dart';
import '../popups/risk_matrix_popup.dart';
import '../popups/risk_popups.dart';

class AnimatedRiskContainer extends StatefulWidget {
  const AnimatedRiskContainer({
    super.key,
  });

  @override
  State<AnimatedRiskContainer> createState() => _AnimatedRiskContainerState();
}

class _AnimatedRiskContainerState extends State<AnimatedRiskContainer> {
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
                    Icons.warning_amber_rounded,
                    color: Color(0xFF335594),
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  // Text "Steps"
                  const Expanded(
                    child: Text(
                      'Risks',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFF335594),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Outfit',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Menu Icon
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width * 0.07,
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
                        jsaProvider.jsa.jsaStepsJson![i].risks.isEmpty
                            ? 'No Risk(s)'
                            //corregir para que haga display el numero correcto
                            : '${jsaProvider.jsa.jsaStepsJson![i].risks.length} Risk(s)',
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
                          onTap: () => showRiskMatrixPopup(
                              context,
                              jsaProvider.jsa.jsaStepsJson![i].id.toString(),
                              jsaProvider),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: jsaProvider
                                        .jsa.jsaStepsJson![i].riskColor ??
                                    Colors.transparent,
                                width: 1.0,
                              ),
                              color: jsaProvider
                                          .jsa.jsaStepsJson![i].riskColor ==
                                      Colors.transparent
                                  ? Colors.transparent
                                  : jsaProvider.jsa.jsaStepsJson![i].riskColor,
                            ),
                            child: Text(
                              jsaProvider
                                      .jsa.jsaStepsJson![i].riskLevel!.isEmpty
                                  ? 'N/A'
                                  : jsaProvider.jsa.jsaStepsJson![i].riskLevel
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
                            showRiskPopup(
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
