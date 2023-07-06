import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../models/monitory.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';
import 'custom_agenda.dart';

class Calendario extends StatefulWidget {
  const Calendario({super.key});

  @override
  State<Calendario> createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);

    return Column(
      children: [
        Expanded(
          child: SfCalendar(
            controller: provider.calendarController,
            // onTap: (calendarTapDetails) {
            //   provider.updateActualDate(calendarTapDetails.date!);
            //   print("Actual Date es: ${provider.actualDate}");
            // },
            appointmentTextStyle: TextStyle(
                fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                fontSize: AppTheme.of(context).bodyText1.fontSize,
                fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                color: AppTheme.of(context).primaryText),
            headerStyle: CalendarHeaderStyle(
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                  fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                  fontSize: 30, //AppTheme.of(context).bodyText1.fontSize,
                  fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                  fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                  color: AppTheme.of(context).primaryText),
            ),
            showWeekNumber: true,
            monthViewSettings: const MonthViewSettings(
              agendaStyle: AgendaStyle(),
              agendaItemHeight: 60,
              appointmentDisplayCount: 10,
              dayFormat: 'EEEE',
            ),
            showDatePickerButton: true,
            viewHeaderStyle: ViewHeaderStyle(
              backgroundColor: AppTheme.of(context).gris,
              dayTextStyle: TextStyle(
                  fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                  fontSize: AppTheme.of(context).bodyText1.fontSize,
                  fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                  fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                  color: AppTheme.of(context).primaryText),
            ),
            weekNumberStyle: WeekNumberStyle(
              textStyle: TextStyle(
                  fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                  fontSize: AppTheme.of(context).bodyText1.fontSize,
                  fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                  fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                  color: AppTheme.of(context).primaryText),
            ),
            onSelectionChanged: (calendarSelectionDetails) =>
                provider.getAppointmentsByDate(),
            view: CalendarView.month,
            firstDayOfWeek: 1,
            dataSource: MeetingDataSource(provider.meet),
            appointmentBuilder:
                (BuildContext context, CalendarAppointmentDetails details) {
              final idAppointment = details.appointments.first.id;

              final monitory = provider.monitory.firstWhere(
                  (element) => element.idControlForm == idAppointment);
              return CustomAppointmentView(
                  details.appointments.first, monitory);
            },
          ),
        ),
      ],
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}

class CustomAppointmentView extends StatefulWidget {
  final Appointment appointment;
  final Monitory monitory;

  const CustomAppointmentView(this.appointment, this.monitory);

  @override
  State<CustomAppointmentView> createState() => _CustomAppointmentViewState();
}

class _CustomAppointmentViewState extends State<CustomAppointmentView> {
  @override
  Widget build(BuildContext context) {
    //CEHCAR EL ULTIMO LUGAR DE LA CADENA SUBJECT Y PONER SOLO HORAS DE ENTRADA EN R y SALIDA EN D
    String tipo = widget.appointment.subject.endsWith("R") ? "R" : "D";
    return Container(
      width: 350,
      height: 100,
      decoration: BoxDecoration(
        color: AppTheme.of(context).gris,
        border: Border.all(
            color:
                tipo == "R" ? const Color(0XFF25A531) : const Color(0XFF173938),
            width: 1),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color:
                tipo == "R" ? const Color(0XFF25A531) : const Color(0XFF173938),
            offset: const Offset(-1, 1),
          )
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${widget.appointment.subject.substring(0, widget.appointment.subject.length - 2)} ${DateFormat("hh:mm a").format(widget.appointment.startTime)}",
                style: TextStyle(
                    fontFamily:
                        AppTheme.of(context).encabezadoTablas.fontFamily,
                    fontSize: AppTheme.of(context).bodyText1.fontSize,
                    fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                    fontWeight:
                        AppTheme.of(context).encabezadoTablas.fontWeight,
                    color: AppTheme.of(context).primaryText),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.appointment.color,
                      ),
                      width: 10,
                      height: 10,
                    ),
                  ),
                  Text(
                    widget.monitory.vehicle.licesensePlates,
                    style: TextStyle(
                        fontFamily:
                            AppTheme.of(context).encabezadoTablas.fontFamily,
                        fontSize: AppTheme.of(context).bodyText1.fontSize,
                        fontStyle:
                            AppTheme.of(context).encabezadoTablas.fontStyle,
                        fontWeight:
                            AppTheme.of(context).encabezadoTablas.fontWeight,
                        color: AppTheme.of(context).primaryText),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppTheme.of(context).gris,
                border: Border.all(color: AppTheme.of(context).gris, width: 1),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: AppTheme.of(context).gris,
                    offset: const Offset(-2, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                widget.monitory.vehicle.image!,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
