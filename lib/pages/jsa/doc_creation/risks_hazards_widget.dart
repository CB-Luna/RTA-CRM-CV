import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/animated_containers/animated_control_container.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/animated_containers/animated_risk_container.dart';
import 'package:rta_crm_cv/pages/jsa/doc_creation/widgets/animated_containers/animated_step_container.dart';

class RisksHazardsScreen extends StatefulWidget {
  const RisksHazardsScreen({Key? key}) : super(key: key);

  @override
  State<RisksHazardsScreen> createState() => _RisksHazardsScreenState();
}

int listSpot = 0;

TextEditingController stepController = TextEditingController();
TextEditingController stepDesc = TextEditingController();

class _RisksHazardsScreenState extends State<RisksHazardsScreen> {
  TextEditingController searchController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  // List<String> vehicleServicesList = ["Hola", "Adios"];

  @override
  void initState() {
    super.initState();
    setState(() {
      // context
      //     .read<UsuarioController>()
      //     .recoverPreviousControlForms(DateTime.now());
      // controlFormCheckOut = context
      //     .read<UsuarioController>()
      //     .getControlFormCheckOutToday(DateTime.now());
      // controlFormCheckIn = context
      //     .read<UsuarioController>()
      //     .getControlFormCheckInToday(DateTime.now());
      // context
      //     .read<UsuarioController>()
      //     .getUser(prefs.getString("userId") ?? "");
      // vehicleServicesList = context
      //     .read<UsuarioController>()
      //     .usuarioCurrent
      //     ?.vehicle
      //     .target
      //     ?.vehicleServices
      //     .where((element) => !element.completed)
      //     .toList();
    });
  }

  @override
  bool valueCheck = false;
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();

    // final checkOutFormProvider = Provider.of<CheckOutFormController>(context);
    // final checkInFormProvider = Provider.of<CheckInFormController>(context);
    // final usuarioProvider = Provider.of<UsuarioController>(context);
   
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const AnimatedStepContainer(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const AnimatedRiskContainer(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                const AnimatedControlContainer(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                
                 
              ],
            ),
          ),
        ),
      );
    
  }
}

bool isContainerOpen = true;

TextEditingController stepNameController = TextEditingController();
TextEditingController stepDescriptionController = TextEditingController();

TextEditingController controlNameController = TextEditingController();

String? id;
int? stepId;
int? riskId;

bool editStep = false;
bool editControl = false;
