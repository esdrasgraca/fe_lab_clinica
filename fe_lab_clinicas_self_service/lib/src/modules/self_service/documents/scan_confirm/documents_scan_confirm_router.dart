import 'package:fe_lab_clinicas_self_service/src/repositories/documents/document_repository.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/documents/document_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'documents_scan_confirm_controller.dart';
import 'documents_scan_confirm_page.dart';

class DocumentsScanConfirmRouter extends FlutterGetItModulePageRouter {
  const DocumentsScanConfirmRouter({super.key});

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton<DocumentRepository>((i) => DocumentRepositoryImpl(restClient: i())),
        Bind.lazySingleton((i) => DocumentsScanConfirmController(documentRepository: i())),
      ];

  @override
  WidgetBuilder get view => (context) => DocumentsScanConfirmPage();
}