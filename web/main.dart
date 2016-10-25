import 'dart:html';
import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular2/platform/browser.dart';

import 'package:cato_form/component/cato_form.dart';
import 'package:cato_form/config/field_config.dart';

main() => bootstrap(App);

@Component(
    selector: 'app',
    templateUrl: 'app.html',
    directives: const [CatoFormComponent])
class App {
  static final List<FieldConfig> _fields = <FieldConfig>[
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
    // Do something with form data.
    window.console.log(formData.toString());
  }
}