import 'home.dart';

class Account {
  final String? id;
  final String publicName;
  final String loginName;
  final String loginPassword;
  final String? pictureUrl;
  final List<Home> homes;

  Account({
    this.id,
    required this.publicName,
    required this.loginName,
    required this.loginPassword,
    this.pictureUrl,
    this.homes = const [],
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as String,
      publicName: json['public_name'] as String,
      loginName: json['login_name'] as String,
      loginPassword: json['login_password'] as String,
      pictureUrl: json['picture_url'] as String?,
      homes: (json['homes'] as List<dynamic>?)
          ?.map((homeJson) => Home.fromJson(homeJson as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'public_name': publicName,
      'login_name': loginName,
      'login_password': loginPassword,
      'picture_url': pictureUrl,
      'homes': homes.map((home) => home.toJson()).toList(),
    };
  }

  Account copyWith({
    String? id,
    String? publicName,
    String? loginName,
    String? loginPassword,
    String? pictureUrl,
    List<Home>? homes,
  }) {
    return Account(
      id: id ?? this.id,
      publicName: publicName ?? this.publicName,
      loginName: loginName ?? this.loginName,
      loginPassword: loginPassword ?? this.loginPassword,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      homes: homes ?? this.homes,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Account) return false;
    return other.id == id &&
        other.loginName == loginName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    loginName.hashCode;
  }

  @override
  String toString() {
    return 'Account{id: $id,'
        'publicName: $publicName,'
        'loginName: $loginName,'
        'loginPassword: $loginPassword,'
        'pictureUrl: $pictureUrl,'
        'homes: $homes}';
  }
}