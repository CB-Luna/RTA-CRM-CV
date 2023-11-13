import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/theme/theme.dart';
import 'package:rta_crm_cv/widgets/captura/custom_ddown_menu/custom_dropdown.dart';

class SelectAppForm extends StatefulWidget {
  const SelectAppForm({super.key});

  @override
  State<SelectAppForm> createState() => _SelectAppFormState();
}

class _SelectAppFormState extends State<SelectAppForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDDownMenu(
          label: 'Choose an app:',
          icon: Icons.person,
          width: 450,
          list: currentUser!.roles.map((role) => role.roleName).toList(),
          dropdownValue: currentUser!.currentRole.roleName,
          onChanged: (val) {
            if (val == null) return;
            // provider.selectRole(val);
          },
        ),
        const SizedBox(height: 20),
        _SelectAppButton(
          label: 'Cancel',
          buttonColor: Colors.grey,
          onPressed: () {
            currentUser = null;
            userState.changeView(FormView.loginForm);
          },
        ),
        const SizedBox(height: 20),
        _SelectAppButton(
          label: 'Continue',
          formKey: formKey,
          buttonColor: AppTheme.of(context).primaryColor,
          onPressed: () {
            userState.view = FormView.loginForm;
            context.pushReplacement('/');
          },
        ),
      ],
    );
  }
}

class _SelectAppButton extends StatefulWidget {
  const _SelectAppButton({
    Key? key,
    required this.label,
    required this.buttonColor,
    this.formKey,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final Color buttonColor;
  final GlobalKey<FormState>? formKey;
  final Function() onPressed;

  @override
  State<_SelectAppButton> createState() => _SelectAppButtonState();
}

class _SelectAppButtonState extends State<_SelectAppButton> {
  late Color buttonColor;

  @override
  void initState() {
    buttonColor = widget.buttonColor;
    super.initState();
  }

  Color lighten(Color c, [int percent = 10]) {
    assert(1 <= percent && percent <= 100);
    var p = percent / 100;
    return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        buttonColor = lighten(buttonColor, 10);
        setState(() {});
      },
      onExit: (event) {
        buttonColor = widget.buttonColor;
        setState(() {});
      },
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          if (widget.formKey != null) {
            if (!widget.formKey!.currentState!.validate()) {
              return;
            }
          }
          await widget.onPressed();
        },
        child: Container(
          height: 41,
          width: double.infinity,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(7.75),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18.6,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
