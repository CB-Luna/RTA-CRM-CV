import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

const List<String> company = ['COMPANY', 'CRY', 'ODE', 'SMI'];
const List<String> employee = ['EMPLOYEE', 'Gian', 'Jane', 'Michael'];

class Calendario extends StatelessWidget {
  const Calendario({super.key});

  @override
  Widget build(BuildContext context) {
    String comp = company.first;
    String emp = employee.first;

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
                  onChanged: (String? value) {},
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
          child: Tooltip(
            message: 'Jane Cooper',
            child: SfCalendar(
              showWeekNumber: true,
              showDatePickerButton: true,
              view: CalendarView.week,
              firstDayOfWeek: 1,
              dataSource: MeetingDataSource(getAppointments()),
            ),
          ),
        ),
      ],
    );
  }
}

List<Appointment> getAppointments() {
  List<Appointment> meet = <Appointment>[];
  final DateTime hoy = DateTime.now();
  final DateTime start = DateTime(hoy.year, hoy.month, hoy.day, 12, 0, 0);
  final DateTime end = start.add(const Duration(hours: 2));

  meet.add(Appointment(
    startTime: start,
    endTime: start.add(const Duration(hours: 1)),
    subject: 'JC',
    color: const Color.fromRGBO(191, 33, 53, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));

  meet.add(Appointment(
    startTime: start,
    endTime: end,
    subject: 'M',
    color: const Color.fromRGBO(52, 86, 148, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));
  meet.add(Appointment(
    startTime: DateTime(hoy.year, hoy.month, hoy.day, 12, 0, 0),
    endTime: end,
    subject: 'GH',
    color: const Color.fromRGBO(217, 217, 217, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));

  meet.add(Appointment(
    startTime: start,
    endTime: start.add(const Duration(hours: 1)),
    subject: 'GJ',
    color: const Color.fromRGBO(191, 33, 53, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));

  meet.add(Appointment(
    startTime: start,
    endTime: end,
    subject: 'GJ',
    color: const Color.fromRGBO(52, 86, 148, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));
  meet.add(Appointment(
    startTime: DateTime(hoy.year, hoy.month, hoy.day, 12, 0, 0),
    endTime: end,
    subject: 'EM',
    color: const Color.fromRGBO(217, 217, 217, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));
  meet.add(Appointment(
    startTime: start,
    endTime: start.add(const Duration(hours: 1)),
    subject: 'UP',
    color: const Color.fromRGBO(191, 33, 53, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));

  meet.add(Appointment(
    startTime: start,
    endTime: end,
    subject: 'CR',
    color: const Color.fromRGBO(52, 86, 148, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));
  meet.add(Appointment(
    startTime: DateTime(hoy.year, hoy.month, hoy.day, 12, 0, 0),
    endTime: end,
    subject: 'JA',
    color: const Color.fromRGBO(217, 217, 217, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));
  meet.add(Appointment(
    startTime: DateTime(hoy.year, hoy.month, hoy.day, 12, 0, 0),
    endTime: end,
    subject: 'JM',
    color: const Color.fromRGBO(217, 217, 217, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));

  return meet;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
