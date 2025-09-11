import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extension_dto.g.dart';

@JsonSerializable(createToJson: false, constructor: '_')
final class ExtensionDto implements IDto<Extension> {
  ExtensionDto._({
    required this.uuid,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.version,
    required this.installType,
    required this.link,
  });

  factory ExtensionDto.fromJson(Map<String, dynamic> json) => _$ExtensionDtoFromJson(json);

  final String uuid;
  final String name;
  final String description;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  final String status;
  final String version;
  final String installType;
  final String link;

  @override
  Extension toEntity() {
    return Extension(
      uuid: ExtensionUUID(uuid),
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
      version: version,
      installType: installType,
      link: link,
    );
  }
}