import 'dart:ffi';

bool isNumeric(String value) {
  final number = double.tryParse(value);
  if (value == null || number == null) return false;
  return true;
}
