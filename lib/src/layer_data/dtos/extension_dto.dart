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

//  {
//     "uuid": "12345678-2e86-5a75-aabf-1ec34371a379",
//     "name": "core",
//     "description": "",
//     "created_at": "2025-09-09T15:06:53.685028Z",
//     "updated_at": "2025-09-09T15:06:53.685030Z",
//     "status": "NEW",
//     "version": "0.0.1",
//     "install_type": "MANUAL",
//     "link": "$core"
//   }
