import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:signals_flutter/signals_flutter.dart';

enum FormSteps {
  none,
  whoIAm,
  findPatient,
  patient,
  documents,
  done,
  restart,
}

class SelfServiceController with MessageStateMixin {
  
  final _step = ValueSignal(FormSteps.none);
  FormSteps get step => _step.value;
  var _model = const SelfServiceModel();

  void startProcess(){
    _step.forceUpdate(FormSteps.whoIAm);
  }

  void setWhiIAmDatastepAndNext(String name, String lastName) {
    _model = _model.copyWith(name: () => name, lastName: () => lastName,);
    _step.forceUpdate(FormSteps.findPatient);
  }

  void clearForm() {
    _model = _model.clear();
  }
}
