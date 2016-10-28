import '../src/model/field_type.dart';

class FieldConfig {
  final String id;
  final String label;
  final FieldType type;
  final bool required;
  final String placeholder;
  final String description;

  FieldConfig(this.id, this.label, this.type, this.required, this.placeholder,
      this.description);

  static _field(String id, String label, FieldType fieldType, bool required,
          {String placeholder: '', String description: ''}) =>
      new FieldConfig(id, label, fieldType, required, placeholder, description);

  static _optionalField(String id, String label, FieldType fieldType,
          {String placeholder: '', String description: ''}) =>
      _field(id, label, fieldType, false,
          placeholder: placeholder, description: description);

  static _requiredField(String id, String label, FieldType fieldType,
          {String placeholder: '', String description: ''}) =>
      _field(id, label, fieldType, true,
          placeholder: placeholder, description: description);

  static optionalTextField(String id, String label,
          {String placeholder: '', String description: ''}) =>
      _optionalField(id, label, FieldType.TEXT_INPUT,
          placeholder: placeholder, description: description);

  static requiredTextField(String id, String label,
          {String placeholder: '', String description: ''}) =>
      _requiredField(id, label, FieldType.TEXT_INPUT,
          placeholder: placeholder, description: description);

  static optionalDateInput(String id, String label,
          {String placeholder: '', String description: ''}) =>
      _optionalField(id, label, FieldType.DATE,
          placeholder: placeholder, description: description);

  static requiredTextArea(String id, String label, {String description: ''}) =>
      _requiredField(id, label, FieldType.TEXT_AREA, description: description);
}
