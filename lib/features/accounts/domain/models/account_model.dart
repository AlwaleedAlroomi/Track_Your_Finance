import 'package:flutter/material.dart';

class Account {
  final int id;
  final String accountName;
  final double balance;

  Account({
    required this.id,
    required this.accountName,
    required this.balance,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as int,
      accountName: json['accountName'] as String,
      balance: json['balance'] as double,
    );
  }
}
