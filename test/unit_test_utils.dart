import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jhon_rhay_parreno_technical_assessment/generated/l10n.dart';

Future<S> setupLocale([String langCode = 'en']) {
  return S.load(Locale(langCode));
}
