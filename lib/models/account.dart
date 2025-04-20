class Account {
  final String id;
  final String publicName;
  final String loginName;
  final String loginPassword;
  final String? pictureUrl;

  // TODO probably add List<Home> accountHome;

  Account({
    required this.id,
    required this.publicName,
    required this.loginName,
    required this.loginPassword,
    this.pictureUrl,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as String,
      publicName: json['public_name'] as String,
      loginName: json['login_name'] as String,
      loginPassword: json['login_password'] as String,
      pictureUrl: json['picture_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'public_name': publicName,
      'login_name': loginName,
      'login_password': loginPassword,
      'picture_url': pictureUrl,
    };
  }
}