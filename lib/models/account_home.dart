
// TODO probably delete

class AccountHome {
  final String accountId;
  final String homeId;

  AccountHome({
    required this.accountId,
    required this.homeId,
  });

  factory AccountHome.fromJson(Map<String, dynamic> json) {
    return AccountHome(
      accountId: json['account_id'] as String,
      homeId: json['home_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account_id': accountId,
      'home_id': homeId,
    };
  }
}