import 'package:genesis/src/features/clusters/domain/entities/cluster.dart';
import 'package:json_annotation/json_annotation.dart';

class ClusterIdConverter extends JsonConverter<ClusterID, String> {
  const ClusterIdConverter();

  @override
  ClusterID fromJson(String json) => ClusterID(json);

  @override
  String toJson(ClusterID object) => object.raw;
}