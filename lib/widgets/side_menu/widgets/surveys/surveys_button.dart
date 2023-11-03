import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/side_menu/widgets/surveys/widgets/job_complete_button.dart';

class SurveysButton extends StatefulWidget {
  const SurveysButton({
    Key? key,
    this.borderRadius = 15,
    this.buttonSize = 70,
    this.fillColor = const Color(0XFF09A963),
    required this.icon,
    this.iconColor = const Color(0XFFB6B6B6),
    this.isTaped = false,
    required this.tooltip,
  }) : super(key: key);

  final double borderRadius;
  final double buttonSize;
  final Color fillColor;
  final IconData icon;
  final Color iconColor;
  final bool isTaped;
  final String tooltip;

  @override
  State<SurveysButton> createState() => _SurveysButtonState();
}

class _SurveysButtonState extends State<SurveysButton> {
  bool hover = false;
  bool hover2 = false;
  bool hover3 = false;

  final userPermissions = currentUser!;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: PortalTarget(
        visible: hover,
        anchor: const Aligned(
          follower: Alignment.topLeft,
          target: Alignment.topRight,
        ),
        portalFollower: MouseRegion(
          child: Material(
            color: AppTheme.of(context).primaryColor.withOpacity(0.3),
            borderRadius: const BorderRadiusDirectional.only(
              topEnd: Radius.circular(8),
              bottomEnd: Radius.circular(8),
            ),
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'Wizpapalooza 2021 Survey',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(wispapalooza2021Survey);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                  // Leer la documentacion de MouseRegion
                  // Probablemente implemente mouseRegion
                  userPermissions.isEmployee
                      ? MouseRegion(
                          child: PortalTarget(
                              visible: hover,
                              anchor: const Aligned(
                                follower: Alignment.topLeft,
                                target: Alignment.topRight,
                              ),
                              portalFollower: MouseRegion(
                                child: Visibility(
                                  visible: hover2,
                                  child: Material(
                                    color: AppTheme.of(context)
                                        .primaryColor
                                        .withOpacity(0.3),
                                    borderRadius:
                                        const BorderRadiusDirectional.only(
                                      topEnd: Radius.circular(8),
                                      bottomEnd: Radius.circular(8),
                                    ),
                                    child: IntrinsicWidth(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text(
                                              'Job Complete Incentives',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteIncentives);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Service Overall',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompletedServiceOverall);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete CRY',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteCRY);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete EAS',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteEAS);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete ODE',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteODE);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete SMI',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteSMI);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onHover: (_) {
                                  hover = true;
                                  hover2 = true;
                                  setState(() {});
                                },
                                onExit: (_) {
                                  hover = false;
                                  hover2 = false;
                                  setState(() {});
                                },
                              ),
                              child: ListTile(
                                title: Text(
                                  'Job Complete',
                                  style: AppTheme.of(context).bodyText1,
                                ),
                                trailing:
                                    const Icon(Icons.chevron_right_outlined),
                                onTap: () async {
                                  context.pushReplacement(monthlyChurn);
                                },
                                hoverColor: AppTheme.of(context)
                                    .primaryColor
                                    .withOpacity(0.4),
                              )),
                          onHover: (_) {
                            hover2 = true;
                            setState(() {});
                          },
                          onExit: (_) {
                            hover2 = false;
                            setState(() {});
                          },
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? MouseRegion(
                          child: PortalTarget(
                              visible: hover,
                              anchor: const Aligned(
                                follower: Alignment.topLeft,
                                target: Alignment.topRight,
                              ),
                              portalFollower: MouseRegion(
                                child: Visibility(
                                  visible: hover3,
                                  child: Material(
                                    color: AppTheme.of(context)
                                        .primaryColor
                                        .withOpacity(0.3),
                                    borderRadius:
                                        const BorderRadiusDirectional.only(
                                      topEnd: Radius.circular(8),
                                      bottomEnd: Radius.circular(8),
                                    ),
                                    child: IntrinsicWidth(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text(
                                              'Job Complete Joseph Aycock',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteJosephAycock);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Adam Billiot',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteAdamBilliot);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Terry Isreal',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteTerryIsreal);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Charile Milich',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteCharlieMilich);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Kamrin Lilley',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteKamrinLilley);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Alexander Ogle',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteAlexanderOgle);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Timothy McClaine ',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteTimothyMcClaine);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Dylan Nowell',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteDylanNowell);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Joseph Thomson',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteJosephThomson);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Scott Nowell',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteScottNowell);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Larry Philips',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteLarryPhilips);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Zachary Lawson',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteZacharyLawson);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Brandon Murdock',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteBrandonMurdock);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Lynn McDaniel',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteLynnMcDaniel);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Stephen McKinney',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteStephenMcKinney);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Thomas Henry',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteThomasHenry);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Joseph Bartek',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteJosephBartek);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Johnnie Thomas',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteJohnnieThomas);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Brandon Sims',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteBrandonSims);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Eric Branton',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteEricBranton);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Tristan Bilbo',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteTristanBilbo);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Garrett Stephens',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteGarrettstephens);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Mason Coon',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteMasonCoon);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete BriceDrisdale',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteBriceDrisdale);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Adam Kosel',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteAdamKosel);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Ross Henry',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteRossHenry);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Eric Harmon',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteEricHarmon);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Paul Hill',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompletePaulHill);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                          ListTile(
                                            title: Text(
                                              'Job Complete Brynson Smith',
                                              style: AppTheme.of(context)
                                                  .bodyText1,
                                            ),
                                            onTap: () async {
                                              context.pushReplacement(
                                                  jobCompleteBrysonSmith);
                                            },
                                            hoverColor: AppTheme.of(context)
                                                .primaryColor
                                                .withOpacity(0.4),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                onHover: (_) {
                                  hover = true;
                                  hover3 = true;
                                  setState(() {});
                                },
                                onExit: (_) {
                                  hover = false;
                                  hover3 = false;
                                  setState(() {});
                                },
                              ),
                              child: ListTile(
                                title: Text(
                                  'Job Complete Technicians',
                                  style: AppTheme.of(context).bodyText1,
                                ),
                                trailing:
                                    const Icon(Icons.chevron_right_outlined),
                                onTap: () async {
                                  context.pushReplacement(monthlyChurn);
                                },
                                hoverColor: AppTheme.of(context)
                                    .primaryColor
                                    .withOpacity(0.4),
                              )),
                          onHover: (_) {
                            hover3 = true;
                            setState(() {});
                          },
                          onExit: (_) {
                            hover3 = false;
                            setState(() {});
                          },
                        )
                      : const SizedBox.shrink(),
                  userPermissions.isEmployee
                      ? ListTile(
                          title: Text(
                            'IT Survey October 2021',
                            style: AppTheme.of(context).bodyText1,
                          ),
                          onTap: () async {
                            context.pushReplacement(itSurveyOctober2021);
                          },
                          hoverColor: AppTheme.of(context)
                              .primaryColor
                              .withOpacity(0.4),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          onHover: (_) {
            hover = true;
            setState(() {});
          },
          onExit: (_) {
            hover = false;
            setState(() {});
          },
        ),
        child: Material(
          borderRadius:
              hover ? BorderRadius.circular(widget.borderRadius) : null,
          elevation: hover ? 5 : 0,
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 65 / 1920,
            height: MediaQuery.of(context).size.width * 65 / 1920,
            child: Container(
              decoration: BoxDecoration(
                border: hover || widget.isTaped
                    ? Border.all(color: const Color(0XFFFFFFFF), width: 2)
                    : null,
                borderRadius: BorderRadius.circular(15),
                color: hover || widget.isTaped ? widget.fillColor : null,
              ),
              child: Tooltip(
                message: widget.tooltip,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    widget.icon,
                    size: MediaQuery.of(context).size.width * 45 / 1920,
                    color: hover || widget.isTaped
                        ? const Color(0XFFFFFFFF)
                        : widget.iconColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      onHover: (_) {
        hover = true;
        setState(() {});
      },
      onExit: (_) {
        hover = false;
        setState(() {});
      },
    );
  }
}
