import 'package:genesis/src/features/extensions/domain/entities/extension.dart';
import 'package:json_annotation/json_annotation.dart';

class ExtensionIdConverter extends JsonConverter<ExtensionID, String> {
  const ExtensionIdConverter();

  @override
  ExtensionID fromJson(String json) => ExtensionID(json);

  @override
  String toJson(ExtensionID object) => object.raw;
}