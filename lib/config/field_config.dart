import '../src/model/field_type.dart';

class FieldConfig {
  String id;
  String label;
  FieldType type;
  bool required;
  String placeholder;
  String description;

  FieldConfig(this.id, this.label, this.type, this.required,
      this.placeholder, this.description);

  static textInput(String id, String label,
      [String placeholder = '']) => new FieldConfig(
        id, label, FieldType.TEXT_INPUT, false, placeholder, '');

  static textInputRequired(String id, String label,
      [String placeholder = '']) => new FieldConfig(
        id, label, FieldType.TEXT_INPUT, true, placeholder, '');

  static dateInput(String id, String label, bool required,
      [String description = '']) => new FieldConfig(id, label,
      FieldType.DATE, required, '', description);

  static textAreaRequired(String id, String label, [String description = '']) =>
      new FieldConfig(id, label, FieldType.TEXT_AREA, true, '', description);
}


