import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:rta_crm_cv/theme/theme.dart';

//////// DEV ////////
const String supabaseUrl = 'https://aadohnxjagooqvqaufqb.supabase.co';
const String anonKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFhZG9obnhqYWdvb3F2cWF1ZnFiIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODM2NDg2MDIsImV4cCI6MTk5OTIyNDYwMn0.YYFVT0MzXW5J35XwhwqnZ0vqgmuZRfswODbfCHH0bfE';
const redirectUrl = 'https://supabase.cbluna-dev.com/arux-change-pass/#/change-password/token';
const themeId = String.fromEnvironment('themeId', defaultValue: '2');

PlutoGridScrollbarConfig plutoGridScrollbarConfig(BuildContext context) {
  return PlutoGridScrollbarConfig(
    isAlwaysShown: true,
    scrollbarThickness: 5,
    hoverWidth: 20,
    scrollBarColor: AppTheme.of(context).primaryColor,
  );
}

double rowHeight = 60;

PlutoGridStyleConfig plutoGridStyleConfig(BuildContext context) {
  return AppTheme.themeMode == ThemeMode.light
      ? PlutoGridStyleConfig(
          //columnContextIcon: Icons.more_horiz,
          rowHeight: rowHeight,
          iconColor: AppTheme.of(context).primaryColor,
          checkedColor: AppTheme.themeMode == ThemeMode.light ? const Color(0XFFC7EDDD) : const Color(0XFF4B4B4B),
          /////////////////////////////////////
          cellTextStyle: AppTheme.of(context).contenidoTablas,
          columnTextStyle: AppTheme.of(context).contenidoTablas,
          /////////////////////////////////////
          rowColor: AppTheme.of(context).primaryBackground,
          enableRowColorAnimation: true,
          /////////////////////////////////////
          gridBackgroundColor: Colors.transparent,
          menuBackgroundColor: AppTheme.of(context).primaryBackground,
          activatedColor: AppTheme.of(context).primaryBackground,
          /////////////////////////////////////
          enableCellBorderVertical: false,
          borderColor: AppTheme.of(context).primaryBackground,
          gridBorderColor: AppTheme.of(context).primaryColor,
          gridBorderRadius: BorderRadius.circular(15),
        )
      : PlutoGridStyleConfig.dark(
          rowHeight: rowHeight,
          iconColor: AppTheme.of(context).primaryColor,
          checkedColor: AppTheme.themeMode == ThemeMode.light ? const Color(0XFFC7EDDD) : const Color(0XFF4B4B4B),
          /////////////////////////////////////
          cellTextStyle: AppTheme.of(context).contenidoTablas,
          columnTextStyle: AppTheme.of(context).contenidoTablas,
          /////////////////////////////////////
          rowColor: AppTheme.of(context).primaryBackground,
          enableRowColorAnimation: true,
          /////////////////////////////////////
          menuBackgroundColor: AppTheme.of(context).primaryBackground,
          activatedColor: AppTheme.of(context).primaryBackground,
          /////////////////////////////////////
          enableCellBorderVertical: false,
          borderColor: AppTheme.of(context).primaryBackground,
          gridBorderColor: Colors.transparent,
          gridBackgroundColor: AppTheme.of(context).primaryBackground,
          gridBorderRadius: BorderRadius.circular(15),
        );
}

CustomTransitionPage<void> pageTransition(BuildContext context, GoRouterState state, Widget page) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(opacity: animation, child: child),
  );
}

const String routeProspects = '/prospects';
const String routeQuoteCreation = '/quote_creation';
const String routeQuoteDetail = '/quote_detail';
const String routeQuoteValidation = '/quote_validation';

const String routeQuotes = '/quotes';
const String routeCampaigns = '/campaigns';

const String routeInventory = '/inventory';
const String routeTickets = '/tickets';
