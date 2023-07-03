import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/ctrlv/monitory_provider.dart';

class CustomAgenda extends StatelessWidget {
  const CustomAgenda({super.key});

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    provider.getWeekDay();
    provider.getMonth();
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              provider.calendarController.selectedDate == null
                  ? Text('No date selected yet',
                  style: TextStyle(
                    fontSize: 30,
                  )
                  )
                  : Text('${provider.selectedDay}, ${provider.selectedMonth}/${provider.calendarController.selectedDate?.day}/${provider.calendarController.selectedDate?.year}',
                  style: TextStyle(
                    fontSize: 30,
                  )
                  ),
              ],
          ),
          Expanded(
            child: ListView.builder(
              controller: ScrollController() ,
              
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.horizontal,
              itemCount: provider.idEventos.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width:
                      400, 
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}'),
                      Text('${provider.idEventos[index].vehicle.licesensePlates}'),
                      Text('${provider.idEventos[index].dateAddedR}'),
                      Image.network(
                        provider.idEventos[index].vehicle.image,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
