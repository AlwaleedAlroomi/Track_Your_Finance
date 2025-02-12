import 'package:financial_tracker/data/local/database_helper.dart';
import 'package:financial_tracker/features/accounts/provider/accounts_notifier.dart';
import 'package:financial_tracker/features/accounts/provider/accounts_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/accounts_repository.dart';
import '../domain/models/account_model.dart';

final databaseHelperProvider =
    Provider<DatabaseHelper>((ref) => DatabaseHelper());

final accountsRepositoryProvider = Provider((ref) {
  final databaseHelper = ref.watch(databaseHelperProvider);
  return AccountsRepository(databaseHelper);
});

final accountsNotifierProvider =
    StateNotifierProvider<AccountsNotifier, AccountsState>((ref) {
  final accountsRepository = ref.watch(accountsRepositoryProvider);
  return AccountsNotifier(accountsRepository);
});

final accountProvider =
    Provider.family<AsyncValue<Account?>, int>((ref, accountId) {
  final accountsState = ref.watch(accountsNotifierProvider);
  return accountsState.accounts.when(
    data: (accounts) {
      final account = accounts.firstWhere((acc) => acc.id == accountId,
          orElse: () => Account(accountName: "", balance: 0));
      return AsyncValue.data(account);
    },
    loading: () => const AsyncValue.loading(),
    error: (e, stack) => AsyncValue.error(e, stack),
  );
});
