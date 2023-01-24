// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FilterEntity {
  final int? currentPage;
  final int? maxPage;
  final String? searchText;
  final String? status;
  final String? gender;

  FilterEntity({
    this.currentPage,
    this.maxPage,
    this.searchText,
    this.status,
    this.gender,
  });

  FilterEntity copyWith({
    int? currentPage,
    int? maxPage,
    String? searchText,
    String? status,
    String? gender,
  }) {
    return FilterEntity(
      currentPage: currentPage ?? this.currentPage,
      maxPage: maxPage ?? this.maxPage,
      searchText: searchText ?? this.searchText,
      status: status ?? this.status,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentPage': currentPage,
      'maxPage': maxPage,
      'searchText': searchText,
      'status': status,
      'gender': gender,
    };
  }

  factory FilterEntity.fromMap(Map<String, dynamic> map) {
    return FilterEntity(
      currentPage:
          map['currentPage'] != null ? map['currentPage'] as int : null,
      maxPage: map['maxPage'] != null ? map['maxPage'] as int : null,
      searchText:
          map['searchText'] != null ? map['searchText'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FilterEntity.fromJson(String source) =>
      FilterEntity.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FilterEntity(currentPage: $currentPage, maxPage: $maxPage, searchText: $searchText, status: $status, gender: $gender)';
  }

  @override
  bool operator ==(covariant FilterEntity other) {
    if (identical(this, other)) return true;

    return other.currentPage == currentPage &&
        other.maxPage == maxPage &&
        other.searchText == searchText &&
        other.status == status &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return currentPage.hashCode ^
        maxPage.hashCode ^
        searchText.hashCode ^
        status.hashCode ^
        gender.hashCode;
  }
}
