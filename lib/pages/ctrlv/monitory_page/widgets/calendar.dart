import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../models/monitory.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';

class Calendario extends StatelessWidget {
  const Calendario({super.key});

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);

    return Column(
      children: [
        Expanded(
          child: SfCalendar(
            appointmentTextStyle: TextStyle(
              fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
              fontSize: AppTheme.of(context).bodyText1.fontSize,
              fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
              fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
              color: AppTheme.of(context).primaryText
            ),
            headerStyle: CalendarHeaderStyle(
              textStyle: TextStyle(
              fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
              fontSize: AppTheme.of(context).bodyText1.fontSize,
              fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
              fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
              color: AppTheme.of(context).primaryText
            ),
            ),
            showWeekNumber: true,
            monthViewSettings: const MonthViewSettings(showAgenda: true),
            showDatePickerButton: true,
            weekNumberStyle: WeekNumberStyle(
              textStyle: TextStyle(
              fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
              fontSize: AppTheme.of(context).bodyText1.fontSize,
              fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
              fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
              color: AppTheme.of(context).primaryText
            ),
            ),
            view: CalendarView.month,
            timeSlotViewSettings: TimeSlotViewSettings(
              timeIntervalHeight: 100,
              timeTextStyle: TextStyle(
              fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
              fontSize: AppTheme.of(context).bodyText1.fontSize,
              fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
              fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
              color: AppTheme.of(context).primaryText
            ),
            ),
            firstDayOfWeek: 1,
            dataSource: MeetingDataSource(provider.meet),
            appointmentBuilder: (BuildContext context, CalendarAppointmentDetails details) {
              final idAppointment = details.appointments.first.id;
              //busqueda en los objetos de monitory, donde el primeroque encuentre con la busqueda
              final monitory = provider.monitory.firstWhere((element) => element.idControlForm == idAppointment);
          return CustomAppointmentView(details.appointments.first,monitory);

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

class CustomAppointmentView extends StatelessWidget {
  final Appointment appointment;
  final Monitory monitory;

  const CustomAppointmentView(this.appointment, this.monitory);

  @override
  Widget build(BuildContext context) {

    //CEHCAR EL ULTIMO LUGAR DE LA CADENA SUBJECT Y PONER SOLO HORAS DE ENTRADA EN R y SALIDA EN D
    String tipo = appointment.subject.endsWith("R") ? "R" : "D";
    return Tooltip(
      message:
      tipo == "R" ? "${monitory.employee.name} ${monitory.employee.lastName}\n${monitory.licensePlates}\n${DateFormat("hh:mm").format(appointment.startTime)}"
      : "${monitory.employee.name} ${monitory.employee.lastName}\n${monitory.licensePlates}\n${DateFormat("hh:mm").format(appointment.endTime)}",
      textAlign: TextAlign.center,
        
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.of(context).gris,
          border: Border.all(
            color: tipo == "R" ? 
            const Color(0XFF25A531) : 
            Colors.orange,
            width: 1
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: tipo == "R" ? 
                const Color(0XFF25A531) : 
                Colors.orange,
              offset: const Offset(-1, 1),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  appointment.subject.substring(0,appointment.subject.length - 2),
                  style: TextStyle(
                    fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                    fontSize: AppTheme.of(context).bodyText1.fontSize,
                    fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                    fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                    color: AppTheme.of(context).primaryText
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: appointment.color,
                        ),
                        width: 10,
                        height: 10,
                      ),
                    ),
                    Text(
                      monitory.vehicle.licesensePlates,
                      style: TextStyle(
                        fontFamily: AppTheme.of(context).encabezadoTablas.fontFamily,
                        fontSize: AppTheme.of(context).bodyText1.fontSize,
                        fontStyle: AppTheme.of(context).encabezadoTablas.fontStyle,
                        fontWeight: AppTheme.of(context).encabezadoTablas.fontWeight,
                        color: AppTheme.of(context).primaryText
                      ),
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
                  border: Border.all(
                    color: AppTheme.of(context).gris,
                    width: 1
                  ),
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
                  monitory.vehicle.image,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
