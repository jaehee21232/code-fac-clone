import 'package:code_fac/restaurant/model/restaurant_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPagination<T> {
  final CursorpaginationMeta meta;
  final List<T> data;

  CursorPagination({
    required this.meta,
    required this.data,
  });

  factory CursorPagination.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CursorPaginationFromJson(json, fromJsonT);
}

@JsonSerializable()
class CursorpaginationMeta {
  final int count;
  final bool hasMore;

  CursorpaginationMeta({
    required this.count,
    required this.hasMore,
  });

  factory CursorpaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorpaginationMetaFromJson(json);
}
