import 'package:flutter/material.dart';
import 'package:rta_crm_cv/pages/ctrlv/inventory_page/widgets/trapecio.dart';

import '../../../../theme/theme.dart';

class CryCard extends StatelessWidget {
  final int totalVehicleCRY;
  final int totalRepairCRY;
  final int totalAssignedCRY;
  final int totalAvailableCRY;
  const CryCard({
    super.key,
    required this.totalVehicleCRY,
    required this.totalRepairCRY,
    required this.totalAssignedCRY,
    required this.totalAvailableCRY,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 304,
        height: 269,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Stack(
          children: [
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 97,
                    height: 28,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: ShapeDecoration(
                      color: const Color(0x260B63F8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: 0.65,
                          child: Text(
                            '● VEHICLES',
                            style: TextStyle(
                              color: Color(0xFF2E5899),
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.08,
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Text(
                          "Total: $totalVehicleCRY ",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF2E5899),
                            fontSize: 16,
                            fontFamily: 'Plus Jakarta Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 235,
                child: Text(
                  'CRY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF2E5899),
                    fontSize: 22,
                    fontFamily: 'Plus Jakarta Sans',
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.13,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Assigned: $totalAssignedCRY",
                      style: TextStyle(
                        color: AppTheme.of(context).primaryColor,
                        fontFamily: 'Bicyclette-Thin',
                        fontSize:
                            AppTheme.of(context).encabezadoTablas.fontSize,
                      ),
                    ),
                    Text(
                      "Repair: $totalRepairCRY",
                      style: TextStyle(
                        color: AppTheme.of(context).primaryColor,
                        fontFamily: 'Bicyclette-Thin',
                        fontSize:
                            AppTheme.of(context).encabezadoTablas.fontSize,
                      ),
                    ),
                    Text(
                      "Available: $totalAvailableCRY ",
                      style: TextStyle(
                        color: AppTheme.of(context).primaryColor,
                        fontFamily: 'Bicyclette-Thin',
                        fontSize:
                            AppTheme.of(context).encabezadoTablas.fontSize,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                width: 304,
                height: 79,
                decoration: const BoxDecoration(color: Color(0xFF2E5899)),
              ),
            ]),
            Positioned(
              top: 150,
              right: 60,
              child: Container(
                width: 173,
                height: 86,
                alignment: Alignment.center,
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                        "https://supa43.rtatel.com/storage/v1/object/public/assets/Vehicles/JLZ7391.jpg"),
                    fit: BoxFit.cover,
                  ),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 2.50, color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
