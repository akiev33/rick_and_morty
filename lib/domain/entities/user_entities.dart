// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  final String? image;
  final String? login;
  final String? name;
  final String? surname;
  final String? patronymic;

  User(
    this.image,
    this.login,
    this.name,
    this.surname,
    this.patronymic,
  );

  User copyWith({
    String? image,
    String? login,
    String? name,
    String? surname,
    String? patronymic,
  }) {
    return User(
      image ?? this.image,
      login ?? this.login,
      name ?? this.name,
      surname ?? this.surname,
      patronymic ?? this.patronymic,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'login': login,
      'name': name,
      'surname': surname,
      'patronymic': patronymic,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['image'] != null ? map['image'] as String : null,
      map['login'] != null ? map['login'] as String : null,
      map['name'] != null ? map['name'] as String : null,
      map['surname'] != null ? map['surname'] as String : null,
      map['patronymic'] != null ? map['patronymic'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(image: $image, login: $login, name: $name, surname: $surname, patronymic: $patronymic)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.image == image &&
      other.login == login &&
      other.name == name &&
      other.surname == surname &&
      other.patronymic == patronymic;
  }

  @override
  int get hashCode {
    return image.hashCode ^
      login.hashCode ^
      name.hashCode ^
      surname.hashCode ^
      patronymic.hashCode;
  }
}
