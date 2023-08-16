import 'dart:developer';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/failed_toast.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/success_toast.dart';
import 'package:rta_crm_cv/pages/ctrlv/download_apk/widgets/warning_toast.dart';
import 'package:rta_crm_cv/services/api_error_handler.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/custom_buttom.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sf;
import 'package:rive/rive.dart' as rive;

class ContentDownloadAPK extends StatefulWidget {
  const ContentDownloadAPK({Key? key}) : super(key: key);

  @override
  State<ContentDownloadAPK> createState() => _ContentDownloadAPKState();
}

class _ContentDownloadAPKState extends State<ContentDownloadAPK> {
  FToast fToast = FToast();
  bool passwordVisibility = false;
  double? _progress;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: AppTheme.of(context).primaryBackground,
        child: Stack(
          children: [
            Theme.of(context).brightness == Brightness.dark
                ? const rive.RiveAnimation.asset(
                    'rive_animations/squaresdark.riv',
                    fit: BoxFit.cover,
                  )
                : const rive.RiveAnimation.asset(
                    'rive_animations/squares.riv',
                    fit: BoxFit.cover,
                  ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Center(
                    child: SizedBox(
                      width: 800,
                      height: 800,
                      child: CustomPaint(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 50),
                              child: Text(
                                'Download the APK below',
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Bicyclette-Light',
                                      color: AppTheme.of(context)
                                          .primaryColor,
                                      fontSize: 60,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: false,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 50),
                              child: AppTheme.themeMode == ThemeMode.dark
                                  ? Image.asset(
                                      'assets/images/icon.png',
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/icon.png',
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      0, 40, 0, 0),
                              child: CustomButton(
                                onPressed: () async {
                                  //Download
                                  try {
                                    _progress == null ? showDialog(
                                      barrierDismissible: false,
                                      context: (context),
                                      builder: (builder) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          title: const Text('Allow Download FMT.'),
                                          content: const Text('Are you sure you want to download FMT APK?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                final html = window.navigator.userAgent.toLowerCase();
                                                if (html.contains("android")) {
                                                    await FileDownloader.downloadFile(
                                                    url: 'https://tinypng.com/images/social/website.jpg', // Reemplaza con la URL real del archivo APK
                                                    name: 'panda.jpg', // Nombre del archivo
                                                    onDownloadCompleted: (String path) {
                                                      setState(() => 
                                                          _progress = null
                                                        );
                                                      fToast.showToast(
                                                        child: const SuccessToast(
                                                          message: "Succesfull download",
                                                        ),
                                                        gravity: ToastGravity.BOTTOM,
                                                        toastDuration: const Duration(seconds: 3),
                                                      );
                                                      print('FILE DOWNLOADED TO PATH: $path');
                                                    },
                                                    onDownloadError: (String error) {
                                                      setState(() => 
                                                          _progress = null
                                                        );
                                                      fToast.showToast(
                                                        child: const FailedToast(
                                                          message: "Download failed",
                                                        ),
                                                        gravity: ToastGravity.BOTTOM,
                                                        toastDuration: const Duration(seconds: 3),
                                                      );
                                                      print('DOWNLOAD ERROR: $error');
                                                    },
                                                    onProgress: (String? fileName, double progress) {
                                                        setState(() => 
                                                          _progress = progress
                                                        );
                                                      },
                                                    );
                                                } else {
                                                  fToast.showToast(
                                                    child: const WarningToast(
                                                      message: "This device don't support the download file APK",
                                                    ),
                                                    gravity: ToastGravity.BOTTOM,
                                                    toastDuration: const Duration(seconds: 3),
                                                  );
                                                }
                                                // ignore: use_build_context_synchronously
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Yes',
                                                style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: AppTheme.of(context)
                                                      .primaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: Text(
                                                'No',
                                                style: AppTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily: 'Poppins',
                                                  color: AppTheme.of(context)
                                                      .primaryColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              )
                                            ),
                                          ],
                                        );
                                      }) 
                                      :
                                      const CircularProgressIndicator();
                                  } catch (e) {
                                    if (e is sf.AuthException) {
                                      await ApiErrorHandler.callToast(
                                          'Failed to download the APK');
                                      return;
                                    }
                                    log('Error al descargar el archivo apk - $e');
                                  }
                                },
                                text: 'Download',
                                options: ButtonOptions(
                                  width: 200,
                                  height: 50,
                                  color:
                                      AppTheme.of(context).primaryColor,
                                  textStyle: AppTheme.of(context)
                                      .subtitle2
                                      .override(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                      15, 40, 15, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 10, 0),
                                        child: FaIcon(
                                          FontAwesomeIcons.shieldHalved,
                                          color: AppTheme.of(context)
                                              .primaryColor,
                                          size: 40,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional
                                                .fromSTEB(0, 0, 10, 0),
                                        child: Text(
                                          'Data\nprotected',
                                          style: AppTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Poppins',
                                                color:
                                                    AppTheme.of(context)
                                                        .primaryColor,
                                                fontSize: 15,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 2,
                                    height: 70,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE7E7E7),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional
                                        .fromSTEB(10, 0, 0, 2),
                                    child: Text(
                                      "Security is our priority, that's why\nwe adhere to the highest standards.",
                                      style: AppTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily: 'Poppins',
                                            color: AppTheme.of(context)
                                                .primaryColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
    );
  }
}

class LoginPaint extends StatefulWidget {
  const LoginPaint({Key? key}) : super(key: key);

  @override
  State<LoginPaint> createState() => _LoginPaintState();
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
