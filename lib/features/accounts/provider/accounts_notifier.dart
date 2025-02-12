import 'package:financial_tracker/features/accounts/data/accounts_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/models/account_model.dart';
import 'accounts_state.dart';

class AccountsNotifier extends StateNotifier<AccountsState> {
  final AccountsRepository _repository;

  AccountsNotifier(this._repository)
      : super(AccountsState(accounts: const AsyncValue.loading())) {
    loadAccounts();
  }

  Future<void> addAccount(Account account) async {
    try {
      await _repository.addAccount(account);
      await loadAccounts();
    } catch (e, stackTrace) {
      state = state.copyWith(accounts: AsyncValue.error(e, stackTrace));
    }
  }

  Future<void> loadAccounts() async {
    state = state.copyWith(accounts: const AsyncValue.loading());
    try {
      final accounts = await _repository.getAllAccounts();
      state = state.copyWith(accounts: AsyncValue.data(accounts));
    } catch (e, stackTrace) {
      state = state.copyWith(accounts: AsyncValue.error(e, stackTrace));
    }
  }

  Future<void> updateAccount(Account account) async {
    try {
      await _repository.updateAccount(account);
      await loadAccounts();
    } catch (e, stackTrace) {
      state = state.copyWith(accounts: AsyncValue.error(e, stackTrace));
    }
  }

  Future<void> deleteAccount(Account account) async {
    try {
      await _repository.deleteAccount(account);
      await loadAccounts();
    } catch (e, stackTrace) {
      state = state.copyWith(accounts: AsyncValue.error(e, stackTrace));
    }
  }
}
