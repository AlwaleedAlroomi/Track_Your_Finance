import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/account_model.dart';

class AccountsState {
  final AsyncValue<List<Account>> accounts;

  AccountsState({required this.accounts});

  AccountsState copyWith({AsyncValue<List<Account>>? accounts}) {
    return AccountsState(accounts: accounts ?? this.accounts);
  }
}
