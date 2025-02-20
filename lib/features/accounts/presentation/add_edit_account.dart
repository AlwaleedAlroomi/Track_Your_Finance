import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/core/utils/format_utils.dart';
import 'package:financial_tracker/features/accounts/domain/models/account_model.dart';
import 'package:financial_tracker/features/accounts/provider/accounts_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddEditAccount extends ConsumerStatefulWidget {
  final Account? account;

  const AddEditAccount({super.key, this.account});

  @override
  AddEditAccountState createState() => AddEditAccountState();
}

class AddEditAccountState extends ConsumerState<AddEditAccount> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _accountNameController;
  final _accountFocusNode = FocusNode();
  late TextEditingController _accountBalanceController;
  final _accountBalanceFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _accountNameController =
        TextEditingController(text: widget.account?.accountName);
    widget.account != null
        ? _accountBalanceController = TextEditingController(
            text: formatNumber(widget.account!.balance.toString()))
        : _accountBalanceController = TextEditingController();
  }

  @override
  void dispose() {
    _accountNameController.dispose();
    _accountFocusNode.dispose();
    _accountBalanceController.dispose();
    _accountBalanceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(
            widget.account?.accountName == null
                ? "Add New Account"
                : "Edit Account",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          centerTitle: true,
          actions: [
            if (widget.account != null)
              IconButton(
                onPressed: () async {
                  await ref
                      .read(accountsNotifierProvider.notifier)
                      .deleteAccount(widget.account!);
                  Navigator.pushNamedAndRemoveUntil(context, RouteNames.home,
                      (Route<dynamic> route) => false);
                },
                icon: const Icon(Icons.delete),
              ),
            IconButton(
              onPressed: () async {
                final newAcc = Account(
                  id: widget.account?.id,
                  accountName: _accountNameController.text,
                  balance: double.parse(
                      _accountBalanceController.text.replaceAll(",", "")),
                );
                if (widget.account == null) {
                  await ref
                      .read(accountsNotifierProvider.notifier)
                      .addAccount(newAcc);
                  Navigator.pushNamedAndRemoveUntil(context, RouteNames.home,
                      (Route<dynamic> route) => false);
                } else {
                  await ref
                      .read(accountsNotifierProvider.notifier)
                      .updateAccount(newAcc);
                  Navigator.pop(context, newAcc);
                }
              },
              icon: const Icon(Icons.save_alt),
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: SizedBox(height: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _accountNameController,
                  focusNode: _accountFocusNode,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    helperText: "",
                    labelText: "Account Name",
                  ),
                ),
                TextFormField(
                  controller: _accountBalanceController,
                  focusNode: _accountBalanceFocusNode,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    String formattedValue = formatNumber(value);
                    _accountBalanceController.value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                        offset: formattedValue.length,
                      ),
                    );
                  },
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    helperText: "",
                    labelText: "Account Balance",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
