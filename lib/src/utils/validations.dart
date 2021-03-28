bool isNumeric(String value) {
  final number = double.tryParse(value);
  if (value == null || number == null || number == 0) return false;
  return true;
}
