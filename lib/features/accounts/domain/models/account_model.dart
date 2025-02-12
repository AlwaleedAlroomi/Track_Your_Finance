class Account {
  int? id;
  final String accountName;
  final double balance;

  Account({
    this.id,
    required this.accountName,
    required this.balance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'accountName': accountName,
      'balance': balance,
    };
  }

  // Convert a map from the database to a Category object
  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      accountName: map['accountName'],
      balance: map['balance'],
    );
  }
}
