import 'dart:typed_data';
import 'package:asyncstate/asyncstate.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/documents/document_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';


class DocumentsScanConfirmController with MessageStateMixin {
  final DocumentRepository _documentRepository;

  DocumentsScanConfirmController({
    required DocumentRepository documentRepository,
  }) : _documentRepository = documentRepository;

  final pathRemoteStorage = signal<String?>(null);

  Future<void> uploadImage(Uint8List imageBytes, String fileName) async {
    final result = await _documentRepository.uploadImage(imageBytes, fileName).asyncLoader();

    switch (result) {
      case Left(value: RepositoryException(:final message)):
        showError(message);
      case Right(value: final filePath):
        pathRemoteStorage.value = filePath;
    }
  }
}