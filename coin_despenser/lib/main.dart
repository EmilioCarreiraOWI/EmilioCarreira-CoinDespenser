import 'casha_app.dart';
import 'core/dependancy_injection.dart';
import 'package:flutter/material.dart';

void main() async {
  await DependencyInjection.init();
  runApp(CashaApp());
}
