import 'package:flutter/material.dart';

class ContainerWidget extends StatefulWidget {
  const ContainerWidget(
      {this.text, this.icon, this.card, this.widget, super.key});
  final String? text;
  final Icon? icon;
  final int? card;
  final Widget? widget;
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
          ),
          Padding(
            padding: const EdgeInsets.only(left: 440, top: 10),
            child: Row(
              children: [
                const Text("Search"),
                Container(
                  margin: const EdgeInsets.only(right: 15, left: 15),
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: widget.widget,
            ),
          )
        ]),
      ),
    );
  }
}
