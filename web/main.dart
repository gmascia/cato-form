import 'package:angular2/platform/browser.dart';
import 'package:angular2/angular2.dart';
import 'package:cato_form/form_component.dart';
import 'package:cato_form/field_config.dart';
import 'dart:html';
import 'dart:async';

main() => bootstrap(App);

@Component(
    selector: 'app',
    styleUrls: const ['app.css'],
    templateUrl: 'app.html',
    directives: const [FormComponent])
class App {
  static List<FieldConfig> _fields = <FieldConfig>[
    FieldConfig.textInputRequired('name', 'Nome'),
    FieldConfig.textInputRequired('last_name', 'Cognome'),
    FieldConfig.textInputRequired('company', 'Azienda'),
    FieldConfig.textInputRequired('phone', 'Telefono'),
    FieldConfig.textInputRequired('email', 'Email'),
    FieldConfig.textInputRequired('language', 'Lingua'),
    FieldConfig.textInputRequired('city', 'Citta'),
    FieldConfig.textInput('country', 'Stato'),
    FieldConfig.dateInput('date_from', 'Da', false),
    FieldConfig.dateInput('date_to', 'A', false),
    FieldConfig.textAreaRequired('notes', 'Note'),
  ];

  List<FieldConfig> get fields => _fields;

  Future submitCallback(Map<String, String> formData) {
    //do smth with form data :)
    window.console.log(formData.toString());
  }
}