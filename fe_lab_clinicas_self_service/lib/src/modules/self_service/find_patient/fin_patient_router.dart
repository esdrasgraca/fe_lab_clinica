
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/find_patient/find_patient_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_getit/flutter_getit.dart';

class FinPatientRouter extends FlutterGetItModulePageRouter{
  const FinPatientRouter({super.key});

  @override  
  WidgetBuilder get view => (_) => const FindPatientPage();
  
}