import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:go_router/go_router.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class JobCompleteTechnicians extends StatefulWidget {
  const JobCompleteTechnicians(
      {required this.hover, required this.onHoverChange, super.key});
  final bool hover;
  final Function(bool) onHoverChange;
  @override
  State<JobCompleteTechnicians> createState() => _JobCompleteTechniciansState();
}

class _JobCompleteTechniciansState extends State<JobCompleteTechnicians> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    final userPermissions = currentUser!;
    return MouseRegion(
      child: PortalTarget(
        visible: widget.hover,
        anchor: const Aligned(
          follower: Alignment.topLeft,
          target: Alignment.topRight,
        ),
        portalFollower: MouseRegion(
          child: Visibility(
            visible: hover,
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
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Joseph Aycock',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteJosephAycock);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Adam Billiot',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteAdamBilliot);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Terry Isreal',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteTerryIsreal);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Charile Milich',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteCharlieMilich);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Kamrin Lilley',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteKamrinLilley);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Alexander Ogle',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteAlexanderOgle);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Timothy McClaine ',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteTimothyMcClaine);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Dylan Nowell',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteDylanNowell);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Joseph Thomson',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteJosephThomson);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Scott Nowell',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteScottNowell);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Larry Philips',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteLarryPhilips);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Zachary Lawson',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteZacharyLawson);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Brandon Murdock',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteBrandonMurdock);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Lynn McDaniel',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteLynnMcDaniel);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Stephen McKinney',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteStephenMcKinney);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Thomas Henry',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteThomasHenry);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Joseph Bartek',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteJosephBartek);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Johnnie Thomas',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteJohnnieThomas);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Brandon Sims',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteBrandonSims);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Eric Branton',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteEricBranton);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Tristan Bilbo',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteTristanBilbo);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Garrett Stephens',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteGarrettstephens);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Mason Coon',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteMasonCoon);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete BriceDrisdale',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteBriceDrisdale);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Adam Kosel',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteAdamKosel);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Ross Henry',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteRossHenry);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Eric Harmon',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteEricHarmon);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Paul Hill',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompletePaulHill);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                    userPermissions.isAdminDashboards
                      ? ListTile(
                      title: Text(
                        'Job Complete Brynson Smith',
                        style: AppTheme.of(context).bodyText1,
                      ),
                      onTap: () async {
                        context.pushReplacement(jobCompleteBrysonSmith);
                      },
                      hoverColor:
                          AppTheme.of(context).primaryColor.withOpacity(0.4),
                    )
                    : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
          onHover: (_) {
            widget.onHoverChange(true);
            hover = true;
            setState(() {});
          },
          onExit: (_) {
            widget.onHoverChange(false);
            hover = false;
            setState(() {});
          },
        ),
        child: ListTile(
          title: Text(
            'Job Complete Technicians',
            style: AppTheme.of(context).bodyText1,
          ),
          trailing: const Icon(Icons.chevron_right_outlined),
          onTap: () async {
            
          },
          hoverColor: AppTheme.of(context).primaryColor.withOpacity(0.4),
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
