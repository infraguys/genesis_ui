import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/layer_domain/entities/extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'extension_dto.g.dart';

@JsonSerializable(constructor: '_')
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

  @JsonKey(name: 'uuid')
  final String uuid;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  @JsonKey(fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'status', fromJson: _statusFromJson)
  final String status;
  @JsonKey(name: 'version')
  final String version;
  @JsonKey(name: 'install_type')
  final String installType;
  @JsonKey(name: 'link')
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

  static ExtensionStatus _statusFromJson(String json) => switch (json) {
    'NEW' => ExtensionStatus.newStatus,
    'ACTIVE' => ExtensionStatus.active,
    'IN_PROGRESS' => ExtensionStatus.inProgress,
    _ => ExtensionStatus.unknown,
  };
}
