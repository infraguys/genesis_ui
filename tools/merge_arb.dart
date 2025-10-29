// Склеиваем все *.arb (включая вложенные папки).
// Локаль берём из поля "@@locale" внутри файла.
// Выход: lib/src/l10n/merged_arb/app_<locale>.arb

import 'dart:convert';
import 'dart:io';

void main() async {
  final srcDir = Directory('lib/src/l10n/src');
  final outDir = Directory('lib/src/l10n/merged_arb');

  if (!srcDir.existsSync()) {
    stderr.writeln('Source directory not found: ${srcDir.path}');
    exit(1);
  }
  outDir.createSync(recursive: true);

  // Собираем файлы (сортируем пути)
  final files =
      srcDir
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) => file.path.toLowerCase().endsWith('.arb'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  final Map<String, Map<String, dynamic>> byLocale = {};

  for (final file in files) {
    final raw = await file.readAsString();

    // читаем json
    Map<String, dynamic> data;
    try {
      data = json.decode(raw) as Map<String, dynamic>;
    } catch (e) {
      stderr.writeln('Skipping invalid JSON: ${file.path} ($e)');
      continue;
    }

    // не тащим @@locale внутрь объединённых ключей — проставим позже
    final locale = data.remove('@@locale')?.toString();

    if (locale == null || locale.isEmpty) {
      stderr.writeln('Skipping (no @@locale): ${file.path}');
      continue;
    }

    final map = Map.of(data);

    byLocale.putIfAbsent(locale, () => {}).addAll(map);
    stdout.writeln(' + ${file.path}  →  $locale');
  }

  // Пишем выходные файлы
  const encoder = JsonEncoder.withIndent('  ');
  for (final entry in byLocale.entries) {
    final locale = entry.key;
    final map = entry.value;
    // гарантируем наличие @@locale в результате
    final merged = {'@@locale': locale, ...map};
    final outFile = File('${outDir.path}/app_$locale.arb');
    await outFile.writeAsString(encoder.convert(merged));
    stdout.writeln(' ✓ ${outFile.path}');
  }

  stdout.writeln('Done.');
}
