import 'package:flutter/material.dart';
import 'package:rta_crm_cv/theme/theme.dart';

class CustomTextCell extends StatelessWidget {
  const CustomTextCell({Key? key, required this.text, required this.textAlign}) : super(key: key);
  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              text,
              style: AppTheme.of(context)
                  .contenidoTablas
                  .override(fontFamily: 'Gotham-Regular', useGoogleFonts: false),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: textAlign,
            ),
          ),
        )
      ],
    );
  }
}
