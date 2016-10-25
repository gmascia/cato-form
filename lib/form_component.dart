import 'dart:html';
import 'dart:async';
import 'package:angular2/core.dart';
import 'package:angular2/common.dart' hide Form;
import 'package:collection/equality.dart';

import 'package:cato_form/form_field_component.dart';
import 'package:cato_form/field_config.dart';
import 'package:cato_form/form_model.dart';
import 'package:cato_form/strings.dart';

typedef dynamic FormSubmitCallback(Map<String, String> formData);

@Component(
    selector: 'cato-form',
    templateUrl: 'form_component.html',
    styleUrls: const ['form_component.css'],
    directives: const [
      CORE_DIRECTIVES,
      FORM_DIRECTIVES,
      FormFieldComponent,
    ],
    providers: const [
      FieldConfig, FormModel
    ]
 )
class FormComponent {
  List<FieldConfig> _fields;
  FormModel _formModel;
  bool isFormSubmitted = false;
  Map<String, String> formSubmitResponse;
  Map<String, String> strings;


  @Input()
  set lang(String value) {
    switch(value) {
      case 'it':
        strings = IT.strings;
        break;
      case 'en':
        strings = EN.strings;
        break;
    }
  }

  @Input('submit-callback')
  FormSubmitCallback submitCallback;

  List<FieldConfig> get fields => _fields;

  @Input()
  set fields(List<FieldConfig> value) {
    Function eq = const ListEquality().equals;
    if (eq(_fields, value)) return;
    _fields = value;
    _formModel = new FormModel(_fields);
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

  String get formSubmittedMsg => 'Form inviato';
}
