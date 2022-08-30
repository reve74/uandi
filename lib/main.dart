import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:uandi/app/app.dart';
import 'package:uandi/app/model/couple.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CoupleAdapter());
  await Hive.openBox<Couple>('couple');
  initializeDateFormatting('ko_KR', null);

  runApp(const ProviderScope(child: MyApp()));
}
