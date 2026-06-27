import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import 'constants.dart';

class Language {
  final String langFrom;
  final String langTo;

  const Language({required this.langFrom, required this.langTo});
}

class GTranslate {
  Future<String> translate(Language lang, String text) async {
    if (text.isEmpty) {
      return '';
    }

    final randomUserAgent = userAgents[Random().nextInt(userAgents.length)];
    final responseHeader = {
      'User-Agent': randomUserAgent,
      'Content-Type': 'application/x-www-form-urlencoded;charset=utf-8',
    };
    final responseBody = {'sl': lang.langFrom, 'tl': lang.langTo, 'q': text};

    final response = await http.post(
      Uri.parse(translateUrl),
      headers: responseHeader,
      body: responseBody,
    );

    final translated = decode(response);

    return translated;
  }

  String decode(http.Response response) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final sentences = data['sentences'] as List<dynamic>;
    final translated = sentences
        .map((s) => s['trans'] as String?)
        .where((s) => s != null)
        .join();

    return translated;
  }
}
