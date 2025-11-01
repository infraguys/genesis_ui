import 'package:genesis/src/core/interfaces/i_dto.dart';
import 'package:genesis/src/features/dbaas/domain/entities/db_version.dart';
import 'package:json_annotation/json_annotation.dart';

part 'db_version_dto.g.dart';

@JsonSerializable(constructor: '_')
final class DbVersionDto implements IDto<DbVersion> {
  DbVersionDto._({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  factory DbVersionDto.fromJson(Map<String, dynamic> json) => _$DbVersionDtoFromJson(json);

  @JsonKey(name: 'uuid', fromJson: _toID)
  final DbVersionID id;
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @JsonKey(name: 'description', defaultValue: '')
  final String description;
  @JsonKey(name: 'created_at', fromJson: DateTime.parse)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: DateTime.parse)
  final DateTime updatedAt;
  @JsonKey(name: 'image')
  final String image;

  static DbVersionID _toID(String json) => DbVersionID(json);

  @override
  DbVersion toEntity() {
    return DbVersion(
      id: id,
      name: name,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
      image: image,
    );
  }
}
