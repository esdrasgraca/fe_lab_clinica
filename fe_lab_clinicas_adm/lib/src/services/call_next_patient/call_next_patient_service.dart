import 'dart:developer';

import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import '../../models/patient_information_form_model.dart';
import '../../repositories/attendant_desk_assigment/attendant_desk_assignment_repository.dart';
import '../../repositories/panel/panel_repository.dart';
import '../../repositories/patient_information_form/patient_information_form_repository.dart';


class CallNextPatientService {
  final PatientInformationFormRepository _patientInformationFormRepository;
  final AttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;
  final PanelRepository _panelRepository;

  CallNextPatientService({
    required PatientInformationFormRepository patientInformationFormRepository,
    required AttendantDeskAssignmentRepository attendantDeskAssignmentRepository,
    required PanelRepository panelRepository,
  })  : _patientInformationFormRepository = patientInformationFormRepository,
        _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository,
        _panelRepository = panelRepository;

  Future<Either<RepositoryException, PatientInformationFormModel?>> execute() async {
    final response = await _patientInformationFormRepository.callNextToCheckin();

    switch (response) {
      case Left(value: final exception):
        return Left(exception);

      case Right(value: final form?):
        return updatePanel(form);
      case Right():
        return Right(null);
    }
  }

  Future<Either<RepositoryException, PatientInformationFormModel?>> updatePanel(
    PatientInformationFormModel form,
  ) async {
    final response = await _attendantDeskAssignmentRepository.getDeskAssignment();

    switch (response) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final deskNumber):
        final panelResponse = await _panelRepository.callOnPanel(form.password, deskNumber);

        switch (panelResponse) {
          case Left(value: final exception):
            log(
              'ATENÇÃO: Não foi possível chamar o paciente.',
              error: exception,
              stackTrace: StackTrace.fromString('ATENÇÃO: Não foi possível chamar o paciente.'),
            );

            return Right(form);

          case Right():
            return Right(form);
        }
    }
  }
}
