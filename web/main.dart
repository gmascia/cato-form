import 'dart:html';
import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular2/platform/browser.dart';

import 'package:cato_form/component/cato_form.dart';
import 'package:cato_form/config/field_config.dart';
import 'package:cato_form/config/field_group.dart';

main() => bootstrap(App);

@Component(
    selector: 'app',
    templateUrl: 'app.html',
    directives: const [CatoFormComponent])
class App {
  FieldGroup _fieldGroup1;
  FieldGroup _fieldGroup2;

  App() {
    final List<FieldConfig> _fields1 = <FieldConfig>[
      FieldConfig.requiredTextField('name', 'Nome'),
      FieldConfig.optionalTextField('last_name', 'Cognome'),
    ];
    _fieldGroup1 = new FieldGroup('dati personali', _fields1);

    final List<FieldConfig> _fields2 = <FieldConfig>[
      FieldConfig.requiredTextField('request', 'Richiesta'),
      FieldConfig.optionalDateInput('date', 'Data'),
    ];
    _fieldGroup2 = new FieldGroup('richiesta', _fields2);
  }

  List<FieldGroup> get fieldGroups => <FieldGroup>[_fieldGroup1, _fieldGroup2];

  Future submitCallback(Map<String, String> formData) {
    // Do something with form data.
    window.console.log(formData.toString());
  }
}