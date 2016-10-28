import 'dart:async';

import 'package:angular2/common.dart';
import 'package:angular2/core.dart';
import 'package:collection/equality.dart';
import 'package:cato_button/button.dart';
import 'package:cato_form/config/field_config.dart';
import 'package:cato_form/config/field_group.dart';

import '../src/component/cato_field.dart';
import '../src/model/form_model.dart';
import '../src/model/strings.dart';

typedef dynamic FormSubmitCallback(Map<String, String> formData);

@Component(
    selector: 'cato-form',
    templateUrl: 'cato_form.html',
    styleUrls: const ['cato_form.css'],
    directives: const [
      CORE_DIRECTIVES,
      FORM_DIRECTIVES,
      CatoFieldComponent,
      CatoButtonComponent
    ],
    providers: const [
      FieldConfig,
      FormModel
    ])
class CatoFormComponent {
  List<FieldGroup> _fieldGroups;
  FormModel _formModel;
  bool isFormSubmitted = false;
  Map<String, String> formSubmitResponse;
  Map<String, String> strings;

  Map<String, Map<String, String>> _langCodeToStrings =
      new Map<String, Map<String, String>>()
        ..addAll({'it': IT.strings, 'en': EN.strings});

  @Input()
  set lang(String value) {
    strings = _langCodeToStrings[value];
  }

  @Input('submit-callback')
  FormSubmitCallback submitCallback;

  List<FieldGroup> get fieldGroups => _fieldGroups;

  @Input('field-groups')
  set fieldGroups(List<FieldGroup> value) {
    Function eq = const ListEquality().equals;
    if (eq(_fieldGroups, value)) return;
    _fieldGroups = value;
    _initModel();
  }

  void _initModel() {
    if (_formModel == null) {
      _formModel = new FormModel(_fieldGroups);
    }
  }

  void onFieldValueChanged(String fieldName, String fieldValue) {
    if (_formModel != null) {
      _formModel.setFieldValue(fieldName, fieldValue);
    }
  }

  bool isFieldValid(String fieldName) => _formModel?.isFieldValid(fieldName);

  bool get isFormValid => _formModel?.isFormValid;

  List<String> get errorMessages => _formModel?.errorMessages;

  Future submit() async {
    _formModel?.validate();
    if (isFormValid) {
      final responseObject = submitCallback(_formModel?.formData);
      isFormSubmitted = responseObject != null;
      formSubmitResponse = responseObject;
    }
  }

  String get formSubmittedMsg => strings['form_sent'];
}
