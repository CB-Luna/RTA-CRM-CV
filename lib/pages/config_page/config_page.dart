import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/config_page/widgets/image_selection_panel.dart';
import 'package:rta_crm_cv/pages/config_page/widgets/theme_selection_panel.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/providers/side_menu_provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/pages/widgets/custom_text_icon_button.dart';
import 'package:rta_crm_cv/pages/widgets/side_menu/sidemenu.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final VisualStateProvider provider = Provider.of<VisualStateProvider>(
        context,
        listen: false,
      );
      await provider.updateState();
    });
  }

  int currentStep = 0;
  continueStep() {
    if (currentStep < 5) {
      setState(() {
        currentStep = currentStep + 1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  onStepTap(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlBuilder(context, details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (currentStep != 0)
          CustomTextIconButton(
              onTap: details.onStepCancel,
              icon: Icon(Icons.chevron_left,
                  color: AppTheme.of(context).primaryBackground),
              text: 'Previous'),
        CustomTextIconButton(
            onTap: details.onStepContinue,
            icon: Icon(Icons.chevron_right,
                color: AppTheme.of(context).primaryBackground),
            text: 'Next'),
      ],
    );
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isThemeSelectionOpen = true;
  bool isImageSelectionOpen = true;
  bool isLoginPictureSelectionOpen = true;
  bool isAnimationSelectionOpen = true;
  @override
  Widget build(BuildContext context) {
    SideMenuProvider sideM = Provider.of<SideMenuProvider>(context);
    sideM.setIndex(8);
    final bool isLight = AppTheme.themeMode == ThemeMode.light;
    final Color iconColor = isLight
        ? Color.alphaBlend(AppTheme.of(context).primaryColor.withAlpha(0x99),
            const Color(0xFF121313))
        : Color.alphaBlend(AppTheme.of(context).primaryColor.withAlpha(0x7F),
            const Color(0XFFB6B6B6));

    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SideMenu(),
                  Expanded(
                    child: Stepper(
                      type: StepperType.horizontal,
                      steps: [
                        Step(
                            isActive: currentStep >= 0,
                            state: currentStep > 0
                                ? StepState.complete
                                : StepState.indexed,
                            title: const Text('Theme and Logo'),
                            content: Column(
                              children: [
                                //Configuracion de temas
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    color:
                                        AppTheme.of(context).primaryBackground,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      side: BorderSide(
                                        color: Color(0x1E090909),
                                        width: 1,
                                      ),
                                    ),
                                    elevation: 0,
                                    clipBehavior: Clip.hardEdge,
                                    child: Column(
                                      children: <Widget>[
                                        Material(
                                          type: MaterialType.card,
                                          color: Color.alphaBlend(
                                            AppTheme.of(context)
                                                .primaryColor
                                                .withAlpha(20),
                                            isLight
                                                ? Colors.white
                                                : const Color(0XFF262626),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                            leading: Icon(
                                              Icons.palette_outlined,
                                              color: iconColor,
                                            ),
                                            title: Text(
                                              'Configuración de temas',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            trailing: ExpandIcon(
                                              size: 32,
                                              isExpanded: isThemeSelectionOpen,
                                              padding: EdgeInsets.zero,
                                              onPressed: (_) {
                                                setState(() =>
                                                    isThemeSelectionOpen =
                                                        !isThemeSelectionOpen);
                                              },
                                            ),
                                            onTap: () {
                                              setState(() =>
                                                  isThemeSelectionOpen =
                                                      !isThemeSelectionOpen);
                                            },
                                          ),
                                        ),
                                        AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          transitionBuilder: (Widget child,
                                              Animation<double> animation) {
                                            return SizeTransition(
                                              sizeFactor: animation,
                                              child: child,
                                            );
                                          },
                                          child: (isThemeSelectionOpen)
                                              ? const ThemeSelectionPanel() //Tema
                                              : const SizedBox.shrink(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Configuracion de imagenes
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    color:
                                        AppTheme.of(context).primaryBackground,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      side: BorderSide(
                                        color: Color(0x1E090909),
                                        width: 1,
                                      ),
                                    ),
                                    elevation: 0,
                                    clipBehavior: Clip.hardEdge,
                                    child: Column(
                                      children: <Widget>[
                                        Material(
                                          type: MaterialType.card,
                                          color: Color.alphaBlend(
                                            AppTheme.of(context)
                                                .primaryColor
                                                .withAlpha(20),
                                            isLight
                                                ? Colors.white
                                                : const Color(0XFF262626),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                            leading: Icon(
                                              Icons.image_outlined,
                                              color: iconColor,
                                            ),
                                            title: Text(
                                              'Configuración de imágenes',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            trailing: ExpandIcon(
                                              size: 32,
                                              isExpanded: isImageSelectionOpen,
                                              padding: EdgeInsets.zero,
                                              onPressed: (_) {
                                                setState(() =>
                                                    isImageSelectionOpen =
                                                        !isImageSelectionOpen);
                                              },
                                            ),
                                            onTap: () {
                                              setState(() =>
                                                  isImageSelectionOpen =
                                                      !isImageSelectionOpen);
                                            },
                                          ),
                                        ),
                                        AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          transitionBuilder: (Widget child,
                                              Animation<double> animation) {
                                            return SizeTransition(
                                              sizeFactor: animation,
                                              child: child,
                                            );
                                          },
                                          child: (isImageSelectionOpen)
                                              ? const ImageSelectionPanel()
                                              : const SizedBox.shrink(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Step(
                            isActive: currentStep >= 1,
                            state: currentStep > 1
                                ? StepState.complete
                                : StepState.indexed,
                            title: const Text('Login'),
                            content: Column(
                              children: [
                                //Configuracion de Imagenes Login
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    color:
                                        AppTheme.of(context).primaryBackground,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      side: BorderSide(
                                        color: Color(0x1E090909),
                                        width: 1,
                                      ),
                                    ),
                                    elevation: 0,
                                    clipBehavior: Clip.hardEdge,
                                    child: Column(
                                      children: <Widget>[
                                        Material(
                                          type: MaterialType.card,
                                          color: Color.alphaBlend(
                                            AppTheme.of(context)
                                                .primaryColor
                                                .withAlpha(20),
                                            isLight
                                                ? Colors.white
                                                : const Color(0XFF262626),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                            leading: Icon(
                                              Icons.image,
                                              color: iconColor,
                                            ),
                                            title: Text(
                                              'Login Pictures',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            trailing: ExpandIcon(
                                              size: 32,
                                              isExpanded:
                                                  isLoginPictureSelectionOpen,
                                              padding: EdgeInsets.zero,
                                              onPressed: (_) {
                                                setState(() =>
                                                    isLoginPictureSelectionOpen =
                                                        !isLoginPictureSelectionOpen);
                                              },
                                            ),
                                            onTap: () {
                                              setState(() =>
                                                  isLoginPictureSelectionOpen =
                                                      !isLoginPictureSelectionOpen);
                                            },
                                          ),
                                        ),
                                        AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          transitionBuilder: (Widget child,
                                              Animation<double> animation) {
                                            return SizeTransition(
                                              sizeFactor: animation,
                                              child: child,
                                            );
                                          },
                                          child: (isLoginPictureSelectionOpen)
                                              ? const ImageSelectionPanel()
                                              : const SizedBox.shrink(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //Configuracion de animaciones
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 20,
                                  ),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    color:
                                        AppTheme.of(context).primaryBackground,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                      side: BorderSide(
                                        color: Color(0x1E090909),
                                        width: 1,
                                      ),
                                    ),
                                    elevation: 0,
                                    clipBehavior: Clip.hardEdge,
                                    child: Column(
                                      children: <Widget>[
                                        Material(
                                          type: MaterialType.card,
                                          color: Color.alphaBlend(
                                            AppTheme.of(context)
                                                .primaryColor
                                                .withAlpha(20),
                                            isLight
                                                ? Colors.white
                                                : const Color(0XFF262626),
                                          ),
                                          child: ListTile(
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 16.0),
                                            leading: Icon(
                                              Icons.animation,
                                              color: iconColor,
                                            ),
                                            title: Text(
                                              'Animations',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            trailing: ExpandIcon(
                                              size: 32,
                                              isExpanded:
                                                  isAnimationSelectionOpen,
                                              padding: EdgeInsets.zero,
                                              onPressed: (_) {
                                                setState(() =>
                                                    isAnimationSelectionOpen =
                                                        !isAnimationSelectionOpen);
                                              },
                                            ),
                                            onTap: () {
                                              setState(() =>
                                                  isAnimationSelectionOpen =
                                                      !isAnimationSelectionOpen);
                                            },
                                          ),
                                        ),
                                        AnimatedSwitcher(
                                          duration:
                                              const Duration(milliseconds: 200),
                                          transitionBuilder: (Widget child,
                                              Animation<double> animation) {
                                            return SizeTransition(
                                              sizeFactor: animation,
                                              child: child,
                                            );
                                          },
                                          child: (isAnimationSelectionOpen)
                                              ? const ImageSelectionPanel()
                                              : const SizedBox.shrink(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Step(
                          isActive: currentStep >= 2,
                          state: currentStep > 2
                              ? StepState.complete
                              : StepState.indexed,
                          title: const Text('-'),
                          content: Container(),
                        ),
                        Step(
                          isActive: currentStep >= 3,
                          state: currentStep > 3
                              ? StepState.complete
                              : StepState.indexed,
                          title: const Text('-'),
                          content: Container(),
                        ),
                        Step(
                          isActive: currentStep >= 4,
                          state: currentStep > 4
                              ? StepState.complete
                              : StepState.indexed,
                          title: const Text('-'),
                          content: Container(),
                        ),
                        Step(
                          isActive: currentStep >= 5,
                          state: currentStep > 5
                              ? StepState.complete
                              : StepState.indexed,
                          title: const Text('-'),
                          content: Container(),
                        ),
                      ],
                      currentStep: currentStep,
                      onStepContinue: () {
                        continueStep();
                      },
                      onStepCancel: () {
                        cancelStep();
                      },
                      onStepTapped: onStepTap,
                      controlsBuilder: controlBuilder,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
