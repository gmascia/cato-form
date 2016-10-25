import 'package:quiver/strings.dart';
import 'package:cato_form/config/field_config.dart';

class FormModel {
  static const num _maxFieldValueLength = 50;

  final List<FieldConfig> _fields;
  final Map<String, String> _labels = new Map<String, String>();
  final Set<String> notValidFields = new Set<String>();
  final Map<String, String> _formData = new Map<String, String>();

  bool hasLengthIssue = false;

  FormModel(this._fields) {
    _fields.forEach((FieldConfig fieldConfig) {
      _labels[fieldConfig.id] = fieldConfig.label;
    });
  }

  List<FieldConfig> get fields => _fields;

  Map<String, String> get labels => _labels;

  List<String> get _requiredFields => _fields
      .where((FieldConfig field) => field.required)
      .map((FieldConfig field) => field.id);

  //TODO: make an immutable copy.
  Map<String, String> get formData => _formData;

  bool get isFormValid => notValidFields.isEmpty && !hasLengthIssue;

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
      final fieldNames =
          notValidFields.map((String notValidField) => labels[notValidField]);
      errors.add('I campi ${fieldNames.join(', ')} sono obbligatori');
    }
    return errors;
  }

  String getLabel(String fieldName) => labels[fieldName];

  bool isFieldValid(String fieldName) => !notValidFields.contains(fieldName);

  void setFieldValue(String fieldName, String fieldValue) {
    _formData[fieldName] = fieldValue;
  }

  void validate() {
    _resetValidation();
    // Validate required fields.
    for (String fieldName in _requiredFields) {
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

  void _resetValidation() {
    notValidFields.clear();
    hasLengthIssue = false;
  }
}
