import 'package:flutter/material.dart';
import 'package:rta_crm_cv/functions/sizes.dart';
import 'package:rta_crm_cv/public/colors.dart';

class SideMenuFooter extends StatefulWidget {
  const SideMenuFooter({
    super.key,
    required this.image,
    required this.text1,
    required this.text2,
    required this.isOpen,
  });

  final String image;
  final String text1;
  final String text2;
  final bool isOpen;

  @override
  State<SideMenuFooter> createState() => _SideMenuFooterState();
}

class _SideMenuFooterState extends State<SideMenuFooter> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: widget.isOpen ? 280 : 80,
      decoration: BoxDecoration(
        gradient: whiteGradient,
        border: Border.all(color: textColor),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.isOpen ? 20 : 10, vertical: widget.isOpen ? 20 : 0),
        child: widget.isOpen
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Image.network(
                              widget.image,
                              height: getWidth(30, context),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              width: getWidth(160, context),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(widget.text1),
                                  Divider(
                                    thickness: 0.67,
                                    color: textColor,
                                  ),
                                  Text(widget.text2),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.settings,
                        size: 30,
                      )
                    ],
                  ),
                ),
              )
            : Image.network(
                widget.image,
                height: getWidth(100, context),
                width: getWidth(100, context),
              ),
      ),
    );
  }
}
