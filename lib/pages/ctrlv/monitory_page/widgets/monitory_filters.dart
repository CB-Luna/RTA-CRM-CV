import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';

import '../../../../providers/ctrlv/monitory_provider.dart';

class MonitoryFiltersWidget extends StatefulWidget {
  const MonitoryFiltersWidget({Key? key}) : super(key: key);

  @override
  State<MonitoryFiltersWidget> createState() => _MonitoryFiltersWidgetState();
}

class _MonitoryFiltersWidgetState extends State<MonitoryFiltersWidget> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   SeguimientoFacturasProvider provider =
    //       Provider.of<SeguimientoFacturasProvider>(
    //     context,
    //     listen: false,
    //   );
    //   await provider.getNumRegisters();
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final SeguimientoFacturasProvider provider =
    //     Provider.of<SeguimientoFacturasProvider>(context);

    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromRGBO(171, 235, 198, 1),
                  border: Border.all(
                      color: AppTheme.lightTheme.tertiaryColor, width: 3),
                ),
                margin: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.download_rounded,
                      color: AppTheme.lightTheme.tertiaryColor,
                    ),
                    Text(
                      "Check Out",
                      style: TextStyle(
                          color: AppTheme.lightTheme.tertiaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.03,
                width: MediaQuery.of(context).size.width * 0.07,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color.fromRGBO(195, 155, 211, 1),
                  border: Border.all(
                      color: const Color.fromRGBO(245, 6, 213, 1), width: 2),
                  // color:  Color.fromRGBO(245, 6, 213, 1),
                ),
                margin: const EdgeInsets.only(left: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.upload_rounded,
                      color: Color.fromRGBO(245, 6, 213, 1),
                    ),
                    Text(
                      "Check In",
                      style: TextStyle(
                          color: Color.fromRGBO(245, 6, 213, 1),
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //CRY
              Container(
                width: MediaQuery.of(context).size.width * 0.08,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration:  BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.1,0.6],
                              colors: [
                                AppTheme.of(context)
                                    .primaryColor
                                    .withOpacity(1),
                                Colors.white,
                              ],
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        
                        Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.03,
                                height: MediaQuery.of(context).size.height * 0.05,
                                decoration: BoxDecoration(
                                    color: AppTheme.lightTheme.primaryColor,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Colors.white, width: 2)),
                                child: const Center(
                                    child: Text("CRY",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ))),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.03,
                          height: MediaQuery.of(context).size.height * 0.025,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromRGBO(171, 235, 198, 1),
                            
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Icon(Icons.logout_rounded,
                                color:AppTheme.lightTheme.tertiaryColor,),
                              ),
                              Text(
                                provider.numCheckOutCRY.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.03,
                          height: MediaQuery.of(context).size.height * 0.025,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(195, 155, 211, 1),
                            borderRadius: BorderRadius.circular(8),
                            
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Icon(Icons.login_rounded,
                                color:Color.fromRGBO(245, 6, 213, 1),),
                              ),
                              Text(
                                provider.numCheckInCRY.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          
                        )
                      ],
                    ),
                  ],
                ),
              ),
              
              //ODE
              Padding(
                padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.1, right: MediaQuery.of(context).size.width * 0.1),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.08,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration:  BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: const [0.1,0.6],
                              colors: [
                                AppTheme.of(context).secondaryColor,
                                Colors.white,
                              ],
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                  
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          
                          Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02,
                              ),
                              Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.03,
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                      color: AppTheme.of(context).secondaryColor,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.white, width: 2)),
                                  child: const Center(
                                      child: Text("ODE",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ))),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                          width: MediaQuery.of(context).size.width * 0.03,
                          height: MediaQuery.of(context).size.height * 0.025,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromRGBO(171, 235, 198, 1),
                            
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Icon(Icons.logout_rounded,
                                color:AppTheme.lightTheme.tertiaryColor,),
                              ),
                              Text(
                                provider.numCheckOutODE.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.03,
                          height: MediaQuery.of(context).size.height * 0.025,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(195, 155, 211, 1),
                            borderRadius: BorderRadius.circular(8),
                            
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Icon(Icons.login_rounded,
                                color:Color.fromRGBO(245, 6, 213, 1),),
                              ),
                              Text(
                                provider.numCheckInODE.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //SMI
              Container(
                  width: MediaQuery.of(context).size.width * 0.08,
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration:  const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.1,0.6],
                              colors: [
                                Color.fromRGBO(255, 138, 0, 1),
                                Colors.white,
                              ],
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                          ),
                  
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          
                          Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02,
                              ),
                              Center(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.03,
                                  height: MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(255, 138, 0, 1),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.white, width: 2)),
                                  child: const Center(
                                      child: Text("SMI",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ))),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                          width: MediaQuery.of(context).size.width * 0.03,
                          height: MediaQuery.of(context).size.height * 0.025,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromRGBO(171, 235, 198, 1),
                            
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Icon(Icons.logout_rounded,
                                color:AppTheme.lightTheme.tertiaryColor,),
                              ),
                              Text(
                                provider.numCheckOutSMI.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                         Container(
                          width: MediaQuery.of(context).size.width * 0.03,
                          height: MediaQuery.of(context).size.height * 0.025,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(195, 155, 211, 1),
                            borderRadius: BorderRadius.circular(8),
                            
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Icon(Icons.login_rounded,
                                color:Color.fromRGBO(245, 6, 213, 1),),
                              ),
                              Text(
                                provider.numCheckInSMI.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
       
      ],
    );
  }
}

class EstatusWidget extends StatefulWidget {
  const EstatusWidget({
    Key? key,
    required this.numRegisters,
    required this.text,
    required this.isTaped,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  final int numRegisters;
  final String text;
  final bool isTaped;
  final Color color;
  final void Function() onTap;

  @override
  State<EstatusWidget> createState() => _EstatusWidgetState();
}

class _EstatusWidgetState extends State<EstatusWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedButton.strip(
          width: 165,
          text: '  ${widget.text}',
          textMaxLine: 2,
          textOverflow: TextOverflow.ellipsis,
          textStyle: AppTheme.of(context).bodyText1,
          textAlignment: Alignment.centerLeft,
          stripTransitionType: StripTransitionType.RIGHT_TO_LEFT,
          // isReverse: true,
          isSelected: widget.isTaped,
          backgroundColor: AppTheme.of(context).gris,
          stripColor: widget.color,
          selectedTextColor: AppTheme.of(context).primaryBackground,
          selectedBackgroundColor: widget.color,
          onPress: widget.onTap,
        ),
        Positioned(
          right: 10,
          top: 10,
          child: IgnorePointer(
            child: Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.isTaped
                    ? AppTheme.of(context).gris
                    : AppTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.numRegisters.toString(),
                style: AppTheme.of(context).bodyText1.override(
                      fontFamily: 'Gotham-Regular',
                      color: AppTheme.of(context).primaryText,
                      useGoogleFonts: false,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
