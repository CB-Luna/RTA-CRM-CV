import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import '../../../../providers/ctrlv/monitory_provider.dart';

class CustomAgenda extends StatelessWidget {
   final double width;
  const CustomAgenda({super.key, required this.width});
  

  @override
  Widget build(BuildContext context) {
    MonitoryProvider provider = Provider.of<MonitoryProvider>(context);
    provider.getWeekDay();
    provider.getMonth();
    Color color = Colors.white;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            provider.calendarController.selectedDate == null
                ? Text('No date selected yet',
                    style: TextStyle(
                      fontSize: 30,
                    ))
                : Text(
                    '${provider.selectedDay}, ${provider.selectedMonth}/${provider.calendarController.selectedDate?.day}/${provider.calendarController.selectedDate?.year}',
                    style: TextStyle(
                      fontSize: 30,
                    )),
          ],
        ),
        provider.calendarController.selectedDate == null || provider.idEventos.isEmpty
              ? Container(
                height: 200,
              )
            : Container(
              height: 300,
              child: ListView.builder(
                controller: ScrollController(),
                scrollDirection: Axis.horizontal,
                  itemCount: provider.idEventos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: 
                      provider.idEventos[index].company.company == "ODE"
                      ?
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                          color: AppTheme.of(context).secondaryColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                style: TextStyle(
                                  color: color,
                                )),
                            Text(
                                '${provider.idEventos[index].vehicle.licesensePlates}',
                                style: TextStyle(
                                  color: color,
                                ),),
                            Text(DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedR),
                            style: TextStyle(
                                  color: color,
                                ),),
                            Image.network(
                              height: 200,
                              provider.idEventos[index].vehicle.image,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ): provider.idEventos[index].company.company == "CRY" ?
                      Container(
                        width: 400,
                        decoration: BoxDecoration(
                          color: AppTheme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                style: TextStyle(
                                  color: color,
                                ),),
                            Text(
                                '${provider.idEventos[index].vehicle.licesensePlates}',
                                style: TextStyle(
                                  color: color,
                                ),),
                            Text(DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedR),
                            style: TextStyle(
                                  color: color,
                                ),),
                            Image.network(
                              height: 200,
                              provider.idEventos[index].vehicle.image,
                              fit: BoxFit.cover,
                            ),
                          ],
                        )
                    ): provider.idEventos[index].company.company == "SMI" ?
                    Container(
                        width: 400,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 138, 0, 1),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                style: TextStyle(
                                  color: color,
                                ),),
                            Text(
                                '${provider.idEventos[index].vehicle.licesensePlates}',
                                style: TextStyle(
                                  color: color,
                                ),),
                            Text(DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedR),
                            style: TextStyle(
                                  color: color,
                                ),),
                            Image.network(
                              height: 200,
                              provider.idEventos[index].vehicle.image,
                              fit: BoxFit.cover,
                            ),
                          ],
                        )
                    ): Container(),
                    );
                  },
                 
                ),
            ),
        
      ],
    );
  }
}
