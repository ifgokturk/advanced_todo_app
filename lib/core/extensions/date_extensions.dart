import 'package:intl/intl.dart';

extension DateExt on DateTime{

  String get timeOnly => DateFormat('hh:mm').format(this);
}