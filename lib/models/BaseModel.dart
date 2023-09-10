
import 'package:json_annotation/json_annotation.dart';

part 'BaseModel.g.dart';


@JsonSerializable()
class BaseModel{
  bool? success;
  int? responseCode;
  String? message;
  bool? accessDenied;

  BaseModel({this.success,this.responseCode,this.message, this.accessDenied});

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}