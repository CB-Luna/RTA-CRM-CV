import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:rta_crm_cv/helpers/globals.dart';
import 'package:rta_crm_cv/models/role.dart';
import 'package:rta_crm_cv/providers/providers.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class SelectAppForm extends StatefulWidget {
  const SelectAppForm({super.key});

  @override
  State<SelectAppForm> createState() => _SelectAppFormState();
}

class _SelectAppFormState extends State<SelectAppForm> {
  @override
  Widget build(BuildContext context) {
    final UserState userState = Provider.of<UserState>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LoginDropDown<Role>(
          label: 'Choose an app:',
          icon: Icons.person,
          width: 450,
          list: currentUser!.roles,
          dropdownValue: currentUser!.currentRole,
          onChanged: (role) {
            if (role == null) return;
            print(currentUser!.currentRole.roleName);
            currentUser!.currentRole = role;
            print("----------");
            print(currentUser!.currentRole.roleName);
            setState(() {});
          },
          items: currentUser!.roles.map<DropdownMenuItem<Role>>((Role value) {
            return DropdownMenuItem<Role>(
              value: value,
              child: Text(
                value.roleApplication,
                style: const TextStyle(fontSize: 14),
              ),
            );
          }).toList(),
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
          buttonColor: AppTheme.of(context).primaryColor,
          onPressed: () async {
            userState.view = FormView.loginForm;
            await prefs.setString(
                'currentRole', currentUser!.currentRole.roleName);
            if (!mounted) return;
            print("-------------- a");
            print(currentUser!.currentRole.roleName);
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
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final Color buttonColor;
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
        onTap: widget.onPressed,
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

class LoginDropDown<T> extends StatefulWidget {
  const LoginDropDown({
    super.key,
    this.enabled = true,
    required this.list,
    required this.dropdownValue,
    required this.items,
    required this.onChanged,
    required this.icon,
    required this.label,
    required this.width,
    this.hint,
  });

  final bool enabled;
  final double width;
  final IconData icon;
  final String label;
  final List<T> list;
  final T? dropdownValue;
  final List<DropdownMenuItem<T>>? items;
  final void Function(dynamic) onChanged;
  final String? hint;

  @override
  State<LoginDropDown> createState() => _LoginDropDownState();
}

class _LoginDropDownState<T> extends State<LoginDropDown<T>> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 55,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, bottom: 10),
            child: Text(
              widget.label,
              style: TextStyle(
                  fontSize: 16,
                  color: widget.enabled
                      ? AppTheme.of(context).primaryColor
                      : AppTheme.of(context).hintText.color),
            ),
          ),
          Container(
            width: widget.width,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppTheme.of(context).primaryBackground,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.1,
                  blurRadius: 3,
                  // changes position of shadow
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Icon(
                  widget.icon,
                  color: widget.enabled
                      ? AppTheme.of(context).primaryColor
                      : AppTheme.of(context).hintText.color,
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: widget.width - 60,
                  child: DropdownButton<T>(
                    hint: Text(
                      widget.hint ?? '',
                      style: TextStyle(
                        color: widget.enabled
                            ? AppTheme.of(context).primaryColor
                            : AppTheme.of(context).hintText.color,
                      ),
                    ),
                    icon: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_drop_down,
                            color: widget.enabled
                                ? AppTheme.of(context).primaryColor
                                : AppTheme.of(context).hintText.color,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                    borderRadius: BorderRadius.circular(5),
                    elevation: 0,
                    dropdownColor: AppTheme.of(context).primaryBackground,
                    style: TextStyle(color: AppTheme.of(context).primaryColor),
                    underline: const SizedBox.shrink(),
                    onChanged: widget.enabled ? widget.onChanged : null,
                    value: widget.dropdownValue,
                    items: widget.items,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
