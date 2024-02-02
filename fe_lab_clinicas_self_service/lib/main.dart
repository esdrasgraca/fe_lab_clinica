import 'dart:async';
import 'dart:developer';

import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/binding/lab_clinicas_application_binding.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/auth/auth_module.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/home/home_module.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_module.dart';
import 'package:fe_lab_clinicas_self_service/src/pages/splash_page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

void main() {
  runZonedGuarded(() {
    runApp(const LavClinicasSelfServiceApp());
  }, (error, stack) { 
    log('Erro não tratado', error: error, stackTrace: stack);
    throw error;
  });
}

class LavClinicasSelfServiceApp extends StatelessWidget {
  const LavClinicasSelfServiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      tittle: 'Lab Clinicas Auto Atendimento',
      bindings: LabClinicasApplicationBinding(),
      pagesBuilders: [
        FlutterGetItPageBuilder(
          page: (_) => const SplashPage(),
          path: '/',
        )
      ],
      modules: [
        AuthModule(),
        HomeModule(),
        SelfServiceModule(),
      ],
    );
  }
}
