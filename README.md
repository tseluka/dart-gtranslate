# dart_gtranslate

a simple dart package for google translate

## usage

```dart
final gtranslate = GTranslate();
final lang = Language(langFrom: 'en', langTo: 'es');
final result = await gtranslate.translate(lang, 'hello');
print(result); // hola
```

`langFrom` and `langTo` are just language codes like `en`, `es`, `fr`, `de`, `ka`, etc. whatever google supports.

## how it works

gtranslate sends a request to translate.google.com endpoint with the source language, target language, and text. google responds with JSON, and gtranslate parses out the translated sentences.

## test

```bash
dart test
```
