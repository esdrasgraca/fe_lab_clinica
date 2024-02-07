import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/foundation.dart';

import './document_repository.dart';

class DocumentRepositoryImpl implements DocumentRepository {


   final RestClient _restClient;

  DocumentRepositoryImpl({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, String>> uploadImage(Uint8List imageBytes, String fileName) async {
    try {
      final formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(imageBytes, filename: fileName),
      });

      final Response(data: {'url': pathImage}) = await _restClient.auth.post('/uploads', data: formData);

      return Right(pathImage);
    } on DioException catch (e, s) {
      log('Erro ao realizar upload da imagem.', error: e, stackTrace: s);

      return Left(RepositoryException(message: 'Erro ao realizar upload da imagem.'));
    }
  }

}