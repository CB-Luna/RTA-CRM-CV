import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/side_menu/sidemenu.dart';
import 'package:rta_crm_cv/widgets/vista_por_url/i_frame.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../providers/dashboard_RTA.dart';
import '../../../widgets/custom_ddown_menu/custom_dropdown_inventory.dart';

class DashboardRtatelPageDesktop extends StatefulWidget {
  final String title;
  late String source;
  final bool? searchVisibility;
  late String? pathTechnicians;
  DashboardRtatelPageDesktop({
    super.key,
    required this.title,
    required this.source,
    this.pathTechnicians,
    this.searchVisibility,
  });

  @override
  State<DashboardRtatelPageDesktop> createState() =>
      _DashboardRtatelPageDesktopState();
}

class _DashboardRtatelPageDesktopState
    extends State<DashboardRtatelPageDesktop> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final UsersProvider provider = Provider.of<UsersProvider>(
        context,
        listen: false,
      );
      // provider.pagesearch = false;

      // provider.clearListInstallers(notify: true);
      await provider.updateState();
    });
  }

  FToast fToast = FToast();

  @override
  Widget build(BuildContext context) {
    // SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    // sideM.setIndex(13);
    fToast.init(context);
    if (widget.title != "Map Coverage") {
      fToast.init(context);

      DashboardRTA provider = Provider.of<DashboardRTA>(context);
      provider.userSelected = null;

      final List<String> installersName =
          provider.usersRoleInstallers.map((roles) => roles.email).toList();

      // if (provider.pagesearch == true) {
      // } else {
      //   provider.pagesearch = false;
      // }

      if (currentUser!.isAdminDashboards) {
        if (installersName.isEmpty) {
          provider.usersRoleInstallers = [];
          provider.userRoleInstaller = null;
          provider.idsinstallers = [];
          provider.getInstallers(notify: true);
        }
      }
      return Material(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SideMenu(),
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(gradient: whiteGradient),
                  child: Column(
                    children: [
                      Visibility(
                        visible: currentUser!.isAdminDashboards,
                        child: Visibility(
                          visible: widget.searchVisibility == true,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    "Search Job Technician: ",
                                    style: AppTheme.of(context).bodyText1,
                                  ),
                                ),
                                CustomDropDownInventory(
                                  label: "",
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
                                  list: installersName,
                                  dropdownValue: provider.userSelected?.email,
                                  onChanged: (val) {
                                    if (val == null) return;

                                    provider.selectInstaller(val);

                                    print("${provider.userSelected!.name}");
                                    print(provider.userSelected!.email);
                                    print(widget.source);
                                    widget.source =
                                        "https://survey.rtatel.com/survey/dash/jobcomplete/tec?tec=${provider.userSelected!.email}";

                                    print(widget.source);

                                    // context.pushReplacement(
                                    //     "/job_complete/job_complete_${provider.userSelected!.name.toLowerCase()}_${provider.userSelected!.lastName.toLowerCase()}");
                                    // context.pushReplacement(jobCompleteTech);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Contenido
                      Expanded(
                        child: IgnorePointer(
                          ignoring: true,
                          child: IFrame(
                            src: widget.source,
                            width: MediaQuery.of(context).size.width * .95,
                            height: MediaQuery.of(context).size.height,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Material(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SideMenu(),
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(gradient: whiteGradient),
                  child: CustomScrollBar(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        //Titulo
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 10, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  height: 40,
                                  child: Text("Map coverage (Smithville)",
                                      style: AppTheme.of(context).title1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Contenido
                        IFrame(
                          src:
                              "https://sites.towercoverage.com/default.aspx?mcid=36023&Acct=28805",
                          width: MediaQuery.of(context).size.width * .7,
                          height: MediaQuery.of(context).size.height * .7,
                        ),
                        //Titulo
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 10, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  height: 40,
                                  child: Text("Map coverage (Odessa)",
                                      style: AppTheme.of(context).title1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Contenido
                        IFrame(
                          src:
                              "https://sites.towercoverage.com/default.aspx?mcid=36038&Acct=28805",
                          width: MediaQuery.of(context).size.width * .7,
                          height: MediaQuery.of(context).size.height * .7,
                        ),
                        //Titulo
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 10, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  height: 40,
                                  child: Text("Map coverage (Crystal Beach)",
                                      style: AppTheme.of(context).title1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Contenido
                        IFrame(
                          src:
                              "https://sites.towercoverage.com/default.aspx?mcid=36163&Acct=28805",
                          width: MediaQuery.of(context).size.width * .7,
                          height: MediaQuery.of(context).size.height * .7,
                        ),
                        //Titulo
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, top: 10, right: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: SizedBox(
                                  height: 40,
                                  child: Text("Map coverage (Eastland)",
                                      style: AppTheme.of(context).title1),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //Contenido
                        IFrame(
                          src:
                              "https://sites.towercoverage.com/default.aspx?mcid=36185&Acct=28805",
                          width: MediaQuery.of(context).size.width * .7,
                          height: MediaQuery.of(context).size.height * .7,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

class LoginPaint extends StatefulWidget {
  const LoginPaint({Key? key}) : super(key: key);

  @override
  State<LoginPaint> createState() => _LoginPaintState();
}

Future<void> launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Could not launch $url');
  }
}

class _LoginPaintState extends State<LoginPaint> {
  @override
  Widget build(BuildContext context) {
    //Make the particles be inside

    return CustomPaint(
      painter: ContainerLogin(),
      foregroundPainter: ContainerLogin(),
    );
  }
}

class ContainerLogin extends CustomPainter {
  final Gradient gradient = const LinearGradient(
    stops: [0, 1],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 240, 240, 240)
    ],
  );
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;
//Number 0
/*     Path path0 = Path();
    path0.moveTo(size.width * 1, size.height * 1);
    path0.lineTo(size.width * 0, size.height * 1);
    path0.lineTo(size.width * 0, size.height * 0);
    path0.lineTo(size.width * 1, size.height * 0);
    path0.lineTo(size.width * 1, size.height * 1);
    Paint linea0 = Paint();
    linea0.color = Color.fromRGBO(242, 105, 37, 1);
    canvas.drawPath(path0, linea0); */

//Number 1
    Path path1 = Path();
    path1.moveTo(size.width * 0.9681, size.height * 0.8159);
    path1.lineTo(size.width * 0.8243, size.height * 0.8159);
    path1.quadraticBezierTo(size.width * 0.7561, size.height * 0.8846,
        size.width * 0.6789, size.height * 0.9346);
    path1.quadraticBezierTo(size.width * 0.58, size.height * 0.9988,
        size.width * 0.5492, size.height * 0.9988);
    path1.quadraticBezierTo(size.width * 0.6, size.height * 0.9525,
        size.width * 0.598, size.height * 0.8913);
    path1.cubicTo(
        size.width * 0.5975,
        size.height * 0.8746,
        size.width * 0.6145,
        size.height * 0.786,
        size.width * 0.495,
        size.height * 0.7838);
    path1.cubicTo(size.width * 0.3755, size.height * 0.7815, size.width * 0.392,
        size.height * 0.8675, size.width * 0.393, size.height * 0.8975);
    path1.cubicTo(size.width * 0.395, size.height * 0.9588, size.width * 0.445,
        size.height * 1, size.width * 0.443, size.height * 0.9988);
    path1.cubicTo(size.width * 0.441, size.height * 0.9975, size.width * 0.4298,
        size.height * 1.0108, size.width * 0.3376, size.height * 0.9587);
    path1.quadraticBezierTo(size.width * 0.2455, size.height * 0.9065,
        size.width * 0.2065, size.height * 0.8159);
    path1.lineTo(size.width * 0.0319, size.height * 0.8159);
    path1.cubicTo(size.width * 0.0143, size.height * 0.8159, size.width * 0,
        size.height * 0.7981, size.width * 0, size.height * 0.7761);
    path1.lineTo(size.width * 0, size.height * 0.0398);
    path1.cubicTo(size.width * 0, size.height * 0.0178, size.width * 0.0143,
        size.height * 0, size.width * 0.0319, size.height * 0);
    path1.lineTo(size.width * 0.9681, size.height * 0);
    path1.cubicTo(size.width * 0.9857, size.height * 0, size.width * 1,
        size.height * 0.0178, size.width * 1, size.height * 0.0398);
    path1.lineTo(size.width * 1, size.height * 0.7761);
    path1.cubicTo(size.width * 1, size.height * 0.7981, size.width * 0.9857,
        size.height * 0.8159, size.width * 0.9681, size.height * 0.8159);
    Paint linea1 = Paint();
    //use graident
    linea1.shader = gradient.createShader(rect);
    linea1.color = const Color.fromRGBO(245, 245, 245, 1);
    canvas.drawShadow(path1.shift(const Offset(5, 5).scale(0.1, 0.1)),
        const Color.fromARGB(255, 0, 0, 0).withAlpha(80), 7, false); //shadow
    canvas.drawShadow(path1.shift(const Offset(-15, -15).scale(0, 0)),
        const Color.fromARGB(255, 255, 255, 255), 7, false); //shadow
    canvas.drawPath(path1, linea1);
//Number 2
    Path path2 = Path();
    path2.moveTo(size.width * 0.43, size.height * 0.9938);
    path2.quadraticBezierTo(size.width * 0.391, size.height * 0.9725,
        size.width * 0.332, size.height * 0.8975);
    path2.quadraticBezierTo(size.width * 0.2797, size.height * 0.831,
        size.width * 0.266, size.height * 0.7663);
    path2.lineTo(size.width * 0.089, size.height * 0.7675);
    path2.lineTo(size.width * 0.33, size.height * 0.6108);
    path2.lineTo(size.width * 0.1582, size.height * 0.3759);
    path2.lineTo(size.width * 0.3896, size.height * 0.4771);
    path2.lineTo(size.width * 0.3133, size.height * 0.1807);
    path2.lineTo(size.width * 0.4564, size.height * 0.3903);
    path2.lineTo(size.width * 0.52, size.height * 0.0613);
    path2.lineTo(size.width * 0.5662, size.height * 0.3903);
    path2.lineTo(size.width * 0.6879, size.height * 0.1698);
    path2.lineTo(size.width * 0.633, size.height * 0.4771);
    path2.lineTo(size.width * 0.8406, size.height * 0.3723);
    path2.lineTo(size.width * 0.6999, size.height * 0.6108);
    path2.lineTo(size.width * 0.931, size.height * 0.7663);
    path2.lineTo(size.width * 0.775, size.height * 0.7663);
    path2.quadraticBezierTo(size.width * 0.723, size.height * 0.8525,
        size.width * 0.677, size.height * 0.8975);
    path2.quadraticBezierTo(size.width * 0.6114, size.height * 0.9616,
        size.width * 0.549, size.height * 0.9988);
    path2.quadraticBezierTo(size.width * 0.584, size.height * 0.9738,
        size.width * 0.585, size.height * 0.9113);
    path2.cubicTo(size.width * 0.5861, size.height * 0.8426, size.width * 0.543,
        size.height * 0.8088, size.width * 0.505, size.height * 0.81);
    path2.cubicTo(
        size.width * 0.4196,
        size.height * 0.8128,
        size.width * 0.4153,
        size.height * 0.8824,
        size.width * 0.414,
        size.height * 0.9038);
    path2.cubicTo(
        size.width * 0.4092,
        size.height * 0.9824,
        size.width * 0.4685,
        size.height * 1.0135,
        size.width * 0.43,
        size.height * 0.9938);
    Paint linea2 = Paint();
    linea2.color = const Color.fromRGBO(255, 255, 255, 1);
    canvas.drawPath(path2, linea2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
