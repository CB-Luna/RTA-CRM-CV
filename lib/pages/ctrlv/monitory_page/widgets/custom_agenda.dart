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
    DateTime checkIn = DateTime.now();
    //Controlador para compartir entre scrollbar y singlechild
    ScrollController _scrollController = ScrollController();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            provider.calendarController.selectedDate == null
                ? const Text('No date selected yet',
                    style: TextStyle(
                      fontSize: 30,
                    ))
                : Text('${provider.selectedDay}, ${provider.selectedMonth}/${provider.calendarController.selectedDate?.day}/${provider.calendarController.selectedDate?.year}',
                    style: const TextStyle(
                      fontSize: 30,
                    )),
          ],
        ),
        provider.calendarController.selectedDate == null || provider.idEventos.isEmpty
            ? Container(
                height: 200,
              )
            : Expanded(
                child: SizedBox(
                  height: 300,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(provider.idEventos.length, (index) {
                          if (provider.idEventos[index].dateAddedD != null) {
                            checkIn = provider.idEventos[index].dateAddedD!;
                          }
                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: provider.idEventos[index].dateAddedD == null
                                ?
                                //Cuando tiene Fecha de Check In
                                provider.idEventos[index].company.company == "ODE"
                                    ? Container(
                                        width: 400,
                                        decoration: BoxDecoration(
                                          color: AppTheme.of(context).secondaryColor,
                                          borderRadius: BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: AppTheme.of(context).tertiaryColor,
                                            width: 5,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                                style: TextStyle(
                                                  color: color,
                                                )),
                                            Text(
                                              provider.idEventos[index].vehicle.licesensePlates,
                                              style: TextStyle(
                                                color: color,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Check Out: ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedR),
                                                  style: TextStyle(
                                                    color: color,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Text(DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedD),
                                            // style: TextStyle(
                                            //       color: color,
                                            //     ),),
                                            Image.network(
                                              height: 150,
                                              provider.idEventos[index].vehicle.image!,
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      )
                                    : provider.idEventos[index].company.company == "CRY"
                                        ? Container(
                                            width: 400,
                                            decoration: BoxDecoration(
                                              color: AppTheme.of(context).primaryColor,
                                              borderRadius: BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color: AppTheme.of(context).tertiaryColor,
                                                width: 5,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                                  style: TextStyle(
                                                    color: color,
                                                  ),
                                                ),
                                                Text(
                                                  provider.idEventos[index].vehicle.licesensePlates,
                                                  style: TextStyle(
                                                    color: color,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Check Out: ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedR),
                                                      style: TextStyle(
                                                        color: color,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Image.network(
                                                  height: 150,
                                                  provider.idEventos[index].vehicle.image!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            ))
                                        : provider.idEventos[index].company.company == "SMI"
                                            ? Container(
                                                width: 400,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(255, 138, 0, 1),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  border: Border.all(
                                                    color: AppTheme.of(context).tertiaryColor,
                                                    width: 5,
                                                  ),
                                                ),
                                                padding: const EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                                      style: TextStyle(
                                                        color: color,
                                                      ),
                                                    ),
                                                    Text(
                                                      provider.idEventos[index].vehicle.licesensePlates,
                                                      style: TextStyle(
                                                        color: color,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Text(
                                                          'Check Out: ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedR),
                                                          style: TextStyle(
                                                            color: color,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Image.network(
                                                      height: 150,
                                                      provider.idEventos[index].vehicle.image!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ],
                                                ))
                                            : Container()
                                :
                                //Cuando tiene Fecha de Check In
                                provider.idEventos[index].company.company == "ODE"
                                    ? Container(
                                        width: 400,
                                        decoration: BoxDecoration(
                                          color: AppTheme.of(context).secondaryColor,
                                          borderRadius: BorderRadius.circular(8.0),
                                          border: Border.all(
                                            color: const Color.fromRGBO(245, 6, 213, 1),
                                            width: 5,
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                                style: TextStyle(
                                                  color: color,
                                                )),
                                            Text(
                                              provider.idEventos[index].vehicle.licesensePlates,
                                              style: TextStyle(
                                                color: color,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Check Out: ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedR),
                                                  style: TextStyle(
                                                    color: color,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const Text(
                                                  'Check In: ',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  DateFormat('hh:mm:ss a').format(checkIn),
                                                  style: TextStyle(
                                                    color: color,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Image.network(
                                              height: 150,
                                              provider.idEventos[index].vehicle.image!,
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      )
                                    : provider.idEventos[index].company.company == "CRY"
                                        ? Container(
                                            width: 400,
                                            decoration: BoxDecoration(
                                              color: AppTheme.of(context).primaryColor,
                                              borderRadius: BorderRadius.circular(8.0),
                                              border: Border.all(
                                                color: const Color.fromRGBO(245, 6, 213, 1),
                                                width: 5,
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                                  style: TextStyle(
                                                    color: color,
                                                  ),
                                                ),
                                                Text(
                                                  provider.idEventos[index].vehicle.licesensePlates,
                                                  style: TextStyle(
                                                    color: color,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Check Out: ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedR),
                                                      style: TextStyle(
                                                        color: color,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      'Check In: ',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      DateFormat('hh:mm:ss a').format(checkIn),
                                                      style: TextStyle(
                                                        color: color,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Image.network(
                                                  height: 150,
                                                  provider.idEventos[index].vehicle.image!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            ))
                                        : provider.idEventos[index].company.company == "SMI"
                                            ? Container(
                                                width: 400,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(255, 138, 0, 1),
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  border: Border.all(
                                                    color: const Color.fromRGBO(245, 6, 213, 1),
                                                    width: 5,
                                                  ),
                                                ),
                                                padding: const EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${provider.idEventos[index].employee.name} ${provider.idEventos[index].employee.lastName}',
                                                      style: TextStyle(
                                                        color: color,
                                                      ),
                                                    ),
                                                    Text(
                                                      provider.idEventos[index].vehicle.licesensePlates,
                                                      style: TextStyle(
                                                        color: color,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Text(
                                                          'Check Out: ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          DateFormat('hh:mm:ss a').format(provider.idEventos[index].dateAddedR),
                                                          style: TextStyle(
                                                            color: color,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        const Text(
                                                          'Check In: ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Text(
                                                          DateFormat('hh:mm:ss a').format(checkIn),
                                                          style: TextStyle(
                                                            color: color,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Image.network(
                                                      height: 150,
                                                      provider.idEventos[index].vehicle.image!,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ],
                                                ))
                                            : Container(),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
