import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../../models/monitory.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';

const List<String> company = ['COMPANY', 'CRY', 'ODE', 'SMI'];
const List<String> employee = ['EMPLOYEE', 'Gian', 'Jane', 'Michael'];

class Calendario extends StatelessWidget {
  const Calendario({super.key});

  @override
  Widget build(BuildContext context) {
    String comp = company.first;
    String emp = employee.first;
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //TITULO O INTRO A CALENDARIO
              Container(
                child: const Text(
                  'Vehicle: ',
                  style: TextStyle(fontSize: 45),
                ),
              ),
              //INFORMACION DE COLORES
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //CRY selector
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 25, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(52, 86, 148, 10),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          const Text(
                            "CRY",
                            style: TextStyle(fontSize: 40),
                          )
                        ],
                      ),
                    ),
                    //ODE selector
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 10, 25, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(191, 33, 53, 10),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          const Text(
                            "ODE",
                            style: TextStyle(fontSize: 40),
                          )
                        ],
                      ),
                    ),
                    //SMI selector
                    Container(
                      //padding: EdgeInsets.fromLTRB(0, 10, 25, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(217, 217, 217, 10),
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          const Text(
                            "SMI",
                            style: TextStyle(fontSize: 40),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              //BUSCADOR DE MES

              //COMPANY
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .15,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(224, 234, 255, 10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButton<String>(
                  value: comp,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (String? value) {
                    provider.getAppointmentsbyCompany(provider.monitory, value!);
                  },
                  items: company.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 30),
                      ),
                    );
                  }).toList(),
                ),
              ),
              //Employee
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .15,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(224, 234, 255, 10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButton<String>(
                  value: emp,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (String? value) {},
                  items: employee.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 30),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SfCalendar(
            showWeekNumber: true,
            showDatePickerButton: true,
            view: CalendarView.week,
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
    return Tooltip(
      message:"${monitory.employee.name} ${monitory.employee.lastName}\n${monitory.licensePlates}\n${appointment.startTime.hour}:${appointment.startTime.minute} - ${appointment.endTime.hour}:${appointment.endTime.minute}",
        
      child: Container(
        color: appointment.color,
        child: Text(appointment.subject,
        style:TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,)),
      ),
    );
  }
}
