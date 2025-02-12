import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/features/accounts/provider/accounts_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/themes/colors.dart';
import '../../../core/utils/format_utils.dart';

class AccountScreen extends ConsumerWidget {
  final int accountId;

  const AccountScreen({super.key, required this.accountId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountState = ref.watch(accountProvider(accountId));
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              size: 30,
            ),
          ),
          title: accountState.when(
              data: (account) => Text(
                    account!.accountName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
              error: (error, stackTrace) => Center(
                    child: Text('errors: $error'),
                  ),
              loading: () => const CircularProgressIndicator()),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                final account = accountState.value;
                if (account != null) {
                  Navigator.pushNamed(context, RouteNames.addEditAccount,
                      arguments: account);
                }
              },
              icon: const Icon(Icons.edit),
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: SizedBox(height: 20),
          ),
        ),
        body: Center(
          child: accountState.when(
            data: (account) {
              String formattedBalance =
                  formatNumber(account!.balance.toString());
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Net Worth"),
                  const SizedBox(height: 20),
                  Text(
                    formattedBalance,
                    style: const TextStyle(
                        fontSize: 40,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text("Transaction"),
                ],
              );
            },
            error: (error, stackTrace) => Center(
              child: Text('errors: $error'),
            ),
            loading: () => const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
