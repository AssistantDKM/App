import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatCurrency(Locale locale, int price) {
  NumberFormat format = NumberFormat.currency(
    locale: locale.toString(),
    decimalDigits: 0,
    symbol: '',
  );

  return format.format(price);
}
