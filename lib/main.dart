import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:stylo/app/app.dart';
import 'package:stylo/app/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  await di.init();
  runApp(StyloApp());
}
