import 'package:json_annotation/json_annotation.dart';

part 'uld_no_filter.g.dart';

@JsonSerializable()
class ULDNoFilter {

  String uldNum;

  ULDNoFilter({
    required this.uldNum
  });

  factory ULDNoFilter.fromJson(Map<String, dynamic> json) =>
      _$ULDNoFilterFromJson(json);

  Map<String, dynamic> toJson() => _$ULDNoFilterToJson(this);

}