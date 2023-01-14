import 'package:translator/translator.dart';

void Translate() async {
  final translator = GoogleTranslator();

  var translation = await translator.translate('Su nawa', from: 'en', to: 'ha');

  translator.baseUrl = 'translate.google.cn';
  translator.translateAndPrint('The translation from database is:');
  print('translation:$translation');
}
