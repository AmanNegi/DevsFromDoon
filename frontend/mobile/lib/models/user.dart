import 'dart:convert';

class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String registrationNo;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.registrationNo,
  });

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? registrationNo,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      registrationNo: registrationNo ?? this.registrationNo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'role': role,
      'registrationNo': registrationNo,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      registrationNo: map['registrationNo'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, role: $role, registrationNo: $registrationNo)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.role == role &&
        other.registrationNo == registrationNo;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        role.hashCode ^
        registrationNo.hashCode;
  }
}
