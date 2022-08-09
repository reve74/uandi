import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uandi/app/app.dart';
import 'package:uandi/app/model/couple.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CoupleAdapter());
  await Hive.openBox<Couple>('Couple');

  runApp(ProviderScope(child: const MyApp()));
}
