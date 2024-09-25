import 'package:json_annotation/json_annotation.dart';

part 'package_search.g.dart';

@JsonSerializable()
class PackageSearch {

  int awb;
  String packageNum;

  PackageSearch({
    required this.awb,
    required this.packageNum
  });

  factory PackageSearch.fromJson(Map<String, dynamic> json) =>
      _$PackageSearchFromJson(json);

  Map<String, dynamic> toJson() => _$PackageSearchToJson(this);

}
