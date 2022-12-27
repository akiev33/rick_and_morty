// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FilterEntity {
  late final int? currentPage;
  final int? maxPage;
  final String? searchText;
  FilterEntity({
    this.currentPage,
    this.maxPage,
    this.searchText,
  });

  FilterEntity copyWith({
    int? currentPage,
    int? maxPage,
    String? searchText,
  }) {
    return FilterEntity(
      currentPage: currentPage ?? this.currentPage,
      maxPage: maxPage ?? this.maxPage,
      searchText: searchText ?? this.searchText,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentPage': currentPage,
      'maxPage': maxPage,
      'searchText': searchText,
    };
  }

  factory FilterEntity.fromMap(Map<String, dynamic> map) {
    return FilterEntity(
      currentPage: map['currentPage'] as int,
      maxPage: map['maxPage'] as int,
      searchText: map['searchText'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterEntity.fromJson(String source) =>
      FilterEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'FilterEntity(currentPage: $currentPage, maxPage: $maxPage, searchText: $searchText)';

  @override
  bool operator ==(covariant FilterEntity other) {
    if (identical(this, other)) return true;

    return other.currentPage == currentPage &&
        other.maxPage == maxPage &&
        other.searchText == searchText;
  }

  @override
  int get hashCode =>
      currentPage.hashCode ^ maxPage.hashCode ^ searchText.hashCode;
}
