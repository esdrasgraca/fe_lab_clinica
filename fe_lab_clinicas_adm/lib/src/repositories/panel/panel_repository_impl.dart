import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import 'panel_repository.dart';

class PanelRepositoryImpl implements PanelRepository {
  final RestClient _restClient;

  PanelRepositoryImpl({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, String>> callOnPanel(String password, int attendantDesk) async {
    try {
      final Response(data: {'id': id}) = await _restClient.auth.post(
        '/painelCheckin',
        data: {
          'password': password,
          'time_called': DateTime.now().toIso8601String(),
          'attendant_desk': attendantDesk,
        },
      );

      return Right(id);
    } on DioException catch (e, s) {
      log('Erro ao chamar paciente no painel.', error: e, stackTrace: s);

      return Left(RepositoryException(message:  'Erro ao chamar paciente no painel.'));
    }
  }
}
