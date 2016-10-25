import 'package:cato_form/field_config.dart';
import 'package:quiver/strings.dart';

class FormModel {
  static const num _maxFieldValueLength = 50;

  final List<FieldConfig> _fields;

  final Map<String, String> _formData = new Map<String, String>();

  final Set<String> notValidFields = new Set<String>();
  bool hasLengthIssue = false;

  FormModel(this._fields);

  //TODO: make a copy.
  Map<String, String> get formData => _formData;

  void setFieldValue(String fieldName, String fieldValue) {
    _formData[fieldName] = fieldValue;
  }

  void _resetValidation() {
    notValidFields.clear();
    hasLengthIssue = false;
  }

  List<FieldConfig> get fields => _fields;

  Map<String, String> get labels {
    Map<String, String> labelsMap = new Map<String, String>();
    fields.forEach((FieldConfig fieldConfig) {
      labelsMap[fieldConfig.id] = fieldConfig.label;
    });
    return labelsMap;
  }

  List<String> get _requiredFields {
    return fields.where((FieldConfig field) {
      return field.required ;
    }).map((FieldConfig field) {
      return field.id;
    });
  }

  void validate() {
    _resetValidation();
    // Validate required fields.
    for(String fieldName in _requiredFields) {
      if (!_formData.containsKey(fieldName) || isBlank(_formData[fieldName])) {
        notValidFields.add(fieldName);
      }
    }
    // Validate max length.
    for (String fieldName in _formData.keys) {
      final fieldValue = _formData[fieldName];
      if (fieldValue.toString().length > _maxFieldValueLength) {
        hasLengthIssue = true;
        notValidFields.add(fieldName);
      }
    }
  }

  List<String> get errorMessages {
    final List<String> errors = new List<String>();

    if (hasLengthIssue) {
      errors.add('I campi di testo non possono superare i '
          '$_maxFieldValueLength caratteri');
    }

    if (notValidFields.length == 1) {
      errors.add('Il campo ${labels[notValidFields.first]} e\' '
          'obbligatorio');
    } else {
      final fieldNames = notValidFields.map(
          (String notValidField) => labels[notValidField]);
      errors.add('I campi ${fieldNames.join(', ')} sono obbligatori');
    }

    return errors;
  }

  String getLabel(String fieldName) => labels[fieldName];

  bool isFieldValid(String fieldName) => !notValidFields.contains(fieldName);

  bool get isFormValid => notValidFields.isEmpty && !hasLengthIssue;
}