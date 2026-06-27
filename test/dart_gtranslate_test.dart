import 'package:dart_gtranslate/dart_gtranslate.dart';
import 'package:test/test.dart';

void main() {
  group('Language', () {
    test('stores langFrom and langTo', () {
      final lang = Language(langFrom: 'en', langTo: 'fr');
      expect(lang.langFrom, 'en');
      expect(lang.langTo, 'fr');
    });

    test('can be const', () {
      const lang = Language(langFrom: 'de', langTo: 'pl');
      expect(lang.langFrom, 'de');
      expect(lang.langTo, 'pl');
    });

    test('supports same language', () {
      final lang = Language(langFrom: 'en', langTo: 'en');
      expect(lang.langFrom, lang.langTo);
    });
  });

  group('GTranslate', () {
    late GTranslate gtranslate;

    setUp(() {
      gtranslate = GTranslate();
    });

    test('translate returns empty string for empty input', () async {
      final lang = Language(langFrom: 'en', langTo: 'es');
      final result = await gtranslate.translate(lang, '');
      expect(result, '');
    });

    test('translate en -> es: hello', () async {
      final lang = Language(langFrom: 'en', langTo: 'es');
      final result = await gtranslate.translate(lang, 'hello');
      expect(result.toLowerCase(), 'hola');
    });

    test('translate en -> fr: thank you', () async {
      final lang = Language(langFrom: 'en', langTo: 'fr');
      final result = await gtranslate.translate(lang, 'thank you');
      expect(result.toLowerCase(), 'merci');
    });

    test('translate en -> de: good morning', () async {
      final lang = Language(langFrom: 'en', langTo: 'de');
      final result = await gtranslate.translate(lang, 'good morning');
      expect(result.toLowerCase(), 'guten morgen');
    });

    test('translate en -> ka: outfitted', () async {
      final lang = Language(langFrom: 'en', langTo: 'ka');
      final result = await gtranslate.translate(lang, 'outfitted');
      expect(result, 'ეკიპირებული');
    });

    test('translate handles multiple sentences', () async {
      final lang = Language(langFrom: 'en', langTo: 'es');
      final result = await gtranslate.translate(lang, 'Hello. How are you?');
      expect(result, isNotEmpty);
      expect(result, contains('?'));
    });
  });
}
