import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/functions/date_format.dart';
import 'package:rta_crm_cv/functions/money_format.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/helpers/constants.dart';
import 'package:rta_crm_cv/providers/crm/dashboard_provider.dart';
import 'package:rta_crm_cv/public/colors.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_text_field.dart';
import 'package:rta_crm_cv/widgets/custom_calendar_buttom.dart';
import 'package:rta_crm_cv/widgets/custom_card.dart';
import 'package:rta_crm_cv/widgets/custom_icon_button.dart';
import 'package:rta_crm_cv/widgets/custom_scrollbar.dart';
import 'package:rta_crm_cv/widgets/custom_text_icon_button.dart';
import 'package:flutter_date_range_picker/flutter_date_range_picker.dart';

class TablaMeses extends StatefulWidget {
  const TablaMeses({Key? key}) : super(key: key);

  @override
  State<TablaMeses> createState() => _TablaMesesState();
}

class _TablaMesesState extends State<TablaMeses> {
  DateRange? selectedDateRange;
  @override
  Widget build(BuildContext context) {
    DashboardCRMProvider provider = Provider.of<DashboardCRMProvider>(context);
    return CustomCard(
      width: getWidth(1030, context),
      //height: getHeight(432.91, context),
      title: 'Overview History',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CustomScrollBar(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 250,
                    child: Row(
                      children: [
                        CustomTextIconButton(
                          isLoading: false,
                          icon: Icon(Icons.filter_alt_outlined,
                              color: AppTheme.of(context).primaryBackground),
                          text: 'Filter',
                          onTap: () => provider.stateManager!
                              .setShowColumnFilter(!provider.stateManager!.showColumnFilter),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: CustomTextIconButton(
                            isLoading: false,
                            icon: Icon(Icons.view_column_outlined,
                                color: AppTheme.of(context).primaryBackground),
                            text: 'Set Columns',
                            onTap: () => provider.stateManager!.showSetColumnsPopup(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CustomTextField(
                      width: 200,
                      enabled: true,
                      controller: provider.searchController,
                      icon: Icons.search,
                      label: 'Search',
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CustomTextIconButton(
                      isLoading: false,
                      icon:
                          Icon(Icons.calendar_month, color: AppTheme.of(context).primaryBackground),
                      text:
                          '${dateFormat(provider.range.start)} - ${dateFormat(provider.range.end)}',
                      onTap: () {
                        showDialog(
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            alignment: Alignment.centerRight,
                            content: Container(
                                color: AppTheme.of(context).primaryBackground,
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: MediaQuery.of(context).size.height * 0.32,
                                child: provider.datePickerBuilder(
                                  context,
                                  (p0) {},
                                )),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: CustomCalendarButtom(
                        isLoading: false,
                        icon: Icon(Icons.calendar_month,
                            color: AppTheme.of(context).primaryBackground),
                        text:
                            '${dateFormat(provider.range.start)} - ${dateFormat(provider.range.end)}',
                        onTapWidget: provider.datePickerBuilder(
                          context,
                          (p0) {},
                        ),
                      )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: getHeight(700, context),
            //width: getWidth(2450, context),
            child: PlutoGrid(
              key: UniqueKey(),
              configuration: PlutoGridConfiguration(
                scrollbar: plutoGridScrollbarConfig(context),
                style: plutoGridStyleConfig(context),
                columnFilter: PlutoGridColumnFilterConfig(
                  filters: const [
                    ...FilterHelper.defaultFilters,
                  ],
                  resolveDefaultColumnFilter: (column, resolver) {
                    if (column.field == 'ID') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'NAME_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'TOTAL_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'MARGIN_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'VENDOR_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    } else if (column.field == 'DESCRIPTION_Column') {
                      return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                    }
                    return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
                  },
                ),
              ),
              columns: [
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.vpn_key_outlined,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'ID', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'ID',
                  field: 'ID_Column',
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableRowDrag: false,
                  enableDropToResize: false,
                  enableEditingMode: false,
                  width: 120,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          rendererContext.cell.value.toString(),
                          style: AppTheme.of(context).contenidoTablas.override(
                              fontFamily: 'Gotham-Regular',
                              useGoogleFonts: false,
                              color: AppTheme.of(context).primaryColor),
                        ),
                      ),
                    );
                  },
                  footerRenderer: (context) {
                    return SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconButton(
                            icon: Icons.keyboard_arrow_down_outlined,
                            toolTip: 'less',
                            onTap: () {
                              provider.setPageSize('less');
                            },
                          ),
                          const SizedBox(width: 10),
                          Text(
                            provider.pageRowCount.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(width: 10),
                          CustomIconButton(
                            icon: Icons.keyboard_arrow_up_outlined,
                            toolTip: 'more',
                            onTap: () {
                              provider.setPageSize('more');
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.person_outline,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Name', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'NAME',
                  field: 'NAME_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          rendererContext.cell.value ?? '-',
                          style: AppTheme.of(context)
                              .contenidoTablas
                              .override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                        ),
                      ),
                    );
                  },
                  footerRenderer: (context) {
                    return SizedBox(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconButton(
                            icon: Icons.keyboard_double_arrow_left,
                            toolTip: 'start',
                            onTap: () {
                              provider.setPage('start');
                            },
                          ),
                          const SizedBox(width: 2),
                          CustomIconButton(
                            icon: Icons.keyboard_arrow_left_outlined,
                            toolTip: 'previous',
                            onTap: () {
                              provider.setPage('previous');
                            },
                          ),
                          const SizedBox(width: 5),
                          SizedBox(
                              width: 30,
                              child: Center(
                                  child: Text(provider.page.toString(),
                                      style: const TextStyle(color: Colors.white)))),
                          const SizedBox(width: 5),
                          CustomIconButton(
                            icon: Icons.keyboard_arrow_right_outlined,
                            toolTip: 'next',
                            onTap: () {
                              provider.setPage('next');
                            },
                          ),
                          const SizedBox(width: 2),
                          CustomIconButton(
                            icon: Icons.keyboard_double_arrow_right,
                            toolTip: 'end',
                            onTap: () {
                              provider.setPage('end');
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.attach_money,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Total', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'TOTAL',
                  field: 'TOTAL_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                          child: Text(
                        '\$ ${moneyFormat(rendererContext.cell.value)} USD',
                        style: AppTheme.of(context)
                            .contenidoTablas
                            .override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                      )),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.percent_outlined,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Margin', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'MARGIN',
                  field: 'MARGIN_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          '${moneyFormat(rendererContext.cell.value)}%',
                          style: AppTheme.of(context)
                              .contenidoTablas
                              .override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                        ),
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.person_outline,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Vendor', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'VENDOR',
                  field: 'VENDOR_Column',
                  width: 225,
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          rendererContext.cell.value ?? '-',
                          style: AppTheme.of(context)
                              .contenidoTablas
                              .override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                        ),
                      ),
                    );
                  },
                ),
               /*  PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.person_outline,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Create Date', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'CREATE DATE',
                  field: 'CREATEDATE_Column',
                  width: 225,//225
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.date(format: 'MMMM, MM-dd-yyyy', headerFormat: 'MM-dd-yyyy'),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          rendererContext.cell.value ?? '-',
                          style: AppTheme.of(context)
                              .contenidoTablas
                              .override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                        ),
                      ),
                    );
                  },
                ),
                 */PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.person_outline,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Description', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'DESCRIPTION',
                  field: 'DESCRIPTION_Column',
                  width: 225,//225
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          rendererContext.cell.value ?? '-',
                          style: AppTheme.of(context)
                              .contenidoTablas
                              .override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                        ),
                      ),
                    );
                  },
                ),
                PlutoColumn(
                  titleSpan: TextSpan(children: [
                    WidgetSpan(
                        child: Icon(Icons.person_outline,
                            color: AppTheme.of(context).primaryBackground)),
                    const WidgetSpan(child: SizedBox(width: 10)),
                    TextSpan(text: 'Status', style: AppTheme.of(context).encabezadoTablas)
                  ]),
                  backgroundColor: const Color(0XFF6491F7),
                  title: 'STATUS',
                  field: 'STATUS_Column',
                  width: 225,//225
                  titleTextAlign: PlutoColumnTextAlign.start,
                  textAlign: PlutoColumnTextAlign.center,
                  type: PlutoColumnType.text(),
                  enableEditingMode: false,
                  cellPadding: EdgeInsets.zero,
                  renderer: (rendererContext) {
                    return Container(
                      height: rowHeight,
                      // width: rendererContext.cell.column.width,
                      decoration: BoxDecoration(gradient: whiteGradient),
                      child: Center(
                        child: Text(
                          rendererContext.cell.value ?? '-',
                          style: AppTheme.of(context)
                              .contenidoTablas
                              .override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
                        ),
                      ),
                    );
                  },
                ),
              ],
              rows: provider.rows2,
              onLoaded: (event) async {
                provider.stateManager = event.stateManager;
              },
              createFooter: (stateManager) {
                stateManager.setPageSize(provider.pageRowCount);
                stateManager.setPage(provider.page);
                return const SizedBox(height: 0, width: 0);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget datePickerBuilder(BuildContext context, dynamic Function(DateRange?) onDateRangeChanged,
          [bool doubleMonth = false]) =>
      DateRangePickerWidget(
        doubleMonth: doubleMonth,
        quickDateRanges: [
          QuickDateRange(dateRange: null, label: "Remove date range"),
          QuickDateRange(
            label: 'Last 3 days',
            dateRange: DateRange(
              DateTime.now().subtract(const Duration(days: 3)),
              DateTime.now(),
            ),
          ),
          QuickDateRange(
            label: 'Last 7 days',
            dateRange: DateRange(
              DateTime.now().subtract(const Duration(days: 7)),
              DateTime.now(),
            ),
          ),
          QuickDateRange(
            label: 'Last 30 days',
            dateRange: DateRange(
              DateTime.now().subtract(const Duration(days: 30)),
              DateTime.now(),
            ),
          ),
          QuickDateRange(
            label: 'Last 90 days',
            dateRange: DateRange(
              DateTime.now().subtract(const Duration(days: 90)),
              DateTime.now(),
            ),
          ),
          QuickDateRange(
            label: 'Last 180 days',
            dateRange: DateRange(
              DateTime.now().subtract(const Duration(days: 180)),
              DateTime.now(),
            ),
          ),
        ],
        minimumDateRangeLength: 1,
        initialDateRange: selectedDateRange,
        initialDisplayedDate: selectedDateRange?.start,
        onDateRangeChanged: onDateRangeChanged,
        theme: CalendarTheme(
          selectedColor: AppTheme.of(context).primaryColor,
          dayNameTextStyle:
              TextStyle(color: AppTheme.of(context).primaryText, fontSize: 10), //texto dias
          inRangeColor:
              AppTheme.of(context).primaryColor.withOpacity(.2), //color rango seleccionado
          inRangeTextStyle: TextStyle(color: AppTheme.of(context).primaryColor),
          selectedTextStyle: TextStyle(color: AppTheme.of(context).primaryBackground),
          todayTextStyle: const TextStyle(fontWeight: FontWeight.bold),
          defaultTextStyle: TextStyle(color: AppTheme.of(context).primaryText, fontSize: 12),
          radius: 10,
          tileSize: 40,
          disabledTextStyle: const TextStyle(color: Colors.grey),
        ),
      );
}
