import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

const List<String> mes = ['May', 'June', 'July', 'August'];
const List<String> semana = ['1 - 7', '8 - 14', '15 - 21', '22 - 28'];

class Calendario extends StatelessWidget {
  const Calendario({super.key});

  @override
  Widget build(BuildContext context) {
    String inicio = mes.first;
    String fin = semana[3];
    

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
                child: Text(
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
                      padding: EdgeInsets.fromLTRB(0, 10, 25, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(52, 86, 148, 10),
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
                      padding: EdgeInsets.fromLTRB(0, 10, 25, 10),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(191, 33, 53, 10),
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
                              color: Color.fromRGBO(217, 217, 217, 10),
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
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .15,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(224, 234, 255, 10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButton<String>(
                  value: inicio,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (String? value) {},
                  items: mes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 30),
                      ),
                    );
                  }).toList(),
                ),
              ),
              //BUSCADOR DE SEMANA
              Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width * .15,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(224, 234, 255, 10),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButton<String>(
                  value: fin,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  onChanged: (String? value) {},
                  items: semana.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(fontSize: 30),
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
            view: CalendarView.week,
            firstDayOfWeek: 1,
            dataSource: MeetingDataSource(getAppointments()),
        
          ),
        ),
          
      ],
    );
    
  }

  
}

List<Appointment> getAppointments(){
  List<Appointment> meet = <Appointment>[];
  final DateTime hoy = DateTime.now();
  final DateTime start = DateTime(hoy.year, hoy.month, hoy.day, 12, 0, 0);
  final DateTime end = start.add(const Duration(hours: 2));

  meet.add(Appointment(
    startTime: start,
    endTime: end,
    subject: 'Jane Cooper\nMKS-1839',
    color: Color.fromRGBO(191, 33, 53, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));
   meet.add(Appointment(
    startTime: start,
    endTime: end,
    subject: 'Michael\nACT-7083',
    color: Color.fromRGBO(52, 86, 148, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));
  meet.add(Appointment(
    startTime: DateTime(hoy.year, hoy.month, hoy.day, 13, 0, 0),
    endTime: end,
    subject: 'Gian\nOVX-6680',
    color: Color.fromRGBO(217, 217, 217, 10),
    // recurrenceRule: 'FREQ=DAILY;COUNT=10',
    // isAllDay: true,
  ));

  return meet;
}
class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Appointment> source){
    appointments = source;
  }
}
