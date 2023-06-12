import 'package:flutter/services.dart';
import 'package:rta_crm_cv/functions/money_format.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      // print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    //final formatter = NumberFormat.simpleCurrency(locale: "en_US");

    String newText = moneyFormat(value / 100);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
