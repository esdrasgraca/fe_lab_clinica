import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import './patient_information_form_repository.dart';

class PatientInformationFormRepositoryImpl implements PatientInformationFormRepository {
  final RestClient _restClient;

  PatientInformationFormRepositoryImpl({
    required RestClient restClient,
  }) : _restClient = restClient;

  @override
  Future<Either<RepositoryException, PatientInformationFormModel?>> callNextToCheckin() async {
    try {
      final Response(:List data) = await _restClient.auth.get(
        '/patientInformationForm',
        queryParameters: {
          'status': PatientInformationFormStatus.waiting.id,
          'page': 1,
          'limit': 1,
        },
      );

      if (data.isEmpty) {
        return Right(null);
      }

      final formData = data.first;
      final updateStatusResponse = await updateStatus(formData['id'], PatientInformationFormStatus.checkedIn);

      switch (updateStatusResponse) {
        case Left(value: final exception):
          return Left(exception);
        case Right():
          formData['status'] = PatientInformationFormStatus.checkedIn.id;
          formData['patient'] = await _getPatient(formData['patient_id']);

          return Right(PatientInformationFormModel.fromJson(formData));
      }
    } on DioException catch (e, s) {
      log('Erro ao chamar próxima senha.', error: e, stackTrace: s);

      return Left(RepositoryException(message:  'Erro ao chamar próxima senha.'));
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> updateStatus(String id, PatientInformationFormStatus status) async {
    try {
      await _restClient.auth.put(
        '/patientInformationForm/$id',
        data: {'status': status.id},
      );

      return Right(unit);
    } on DioException catch (e, s) {
      log('Erro ao atualizar status do form.', error: e, stackTrace: s);

      return Left(RepositoryException(message:  'Erro ao atualizar status do form.'));
    }
  }

  Future<Map<String, dynamic>> _getPatient(String id) async {
    final Response(:data) = await _restClient.auth.get('/patients/$id');

    return data;
  }

}