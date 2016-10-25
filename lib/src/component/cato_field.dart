import 'package:angular2/common.dart';
import 'package:angular2/core.dart' hide Optional;
import 'package:cato_form/config/field_config.dart';
import '../model/field_type.dart';

@Component(
    selector: 'cato-form-field',
    templateUrl: 'cato_field.html',
    styleUrls: const ['cato_field.css'],
    directives: const [CORE_DIRECTIVES],
    providers: const [FieldType]
)
class CatoFieldComponent {
  FieldConfig _field;
  String _value;
  bool _valid;

  @Output()
  final onValueChanged = new EventEmitter<String>();

  @Output()
  final onEnterKeyPressed = new EventEmitter();

  @Input()
  set field(FieldConfig fieldConfig) {
    _field = fieldConfig;
  }

  @Input()
  set valid(bool value) => _valid = value;

  @Input()
  Map<String, String> strings;

  String get value => _value;

  set value(String value) {
    onValueChanged.add(value);
    _value = value;
  }

  FieldType get type => _field.type;

  String get inputFieldType {
    switch(type) {
      case FieldType.DATE:
        return 'date';
      default:
        return 'text';
    }
  }

  String get fieldId => _field.id;

  String get label => _field.label;

  bool get required => _field.required;

  bool get isNotValid => !_valid;

  String get description => _field.description;

  String get placeholder => _field.description;

  bool get isTextArea => type == FieldType.TEXT_AREA;

  String get requiredMsg => strings['required'];

  void enterKeyPressed() {
    onEnterKeyPressed.add(null);
  }
}
