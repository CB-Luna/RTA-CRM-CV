import 'package:flutter/material.dart';

class ContainerWidget extends StatefulWidget {
  ContainerWidget({this.text, this.icon, super.key});
  final String? text;
  final Icon? icon;
  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        width: MediaQuery.of(context).size.width * 0.44,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            border: Border.all(color: Colors.grey)),
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height * 0.07,
            decoration: const BoxDecoration(
                color: Color(0xffF7F7F7),
                border: Border(bottom: BorderSide(color: Colors.grey))),
            child: Row(children: [
              widget.icon ?? const Icon(Icons.ac_unit_outlined),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(widget.text ?? ''),
              )
            ]),
          )
        ]),
      ),
    );
  }
}
