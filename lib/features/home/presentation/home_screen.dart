import 'package:dotted_border/dotted_border.dart';
import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/core/themes/colors.dart';
import 'package:financial_tracker/features/accounts/provider/accounts_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/utils/format_utils.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final PageController _pageController = PageController(viewportFraction: 1.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountState = ref.watch(accountsNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.filter_alt_outlined),
            iconSize: 40,
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                border: Border.all(
                  color: AppColors.border,
                  width: 3.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  const Text(
                    "March 2022",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteNames.setting);
            },
            icon: const Icon(Icons.settings_outlined),
            iconSize: 40,
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(8),
          child: SizedBox(height: 8),
        ),
      ),
      body: Column(
        children: [
          accountState.accounts.when(
            loading: () => SizedBox(
                height: MediaQuery.of(context).size.height * .25,
                child: const Center(child: CircularProgressIndicator())),
            error: (error, stackTrace) => Center(
              child: Text('errors: $error'),
            ),
            data: (accounts) {
              return Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .22,
                    child: PageView.builder(
                      itemCount: accounts.length + 1,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        if (index == accounts.length) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, RouteNames.addEditAccount);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(12),
                                dashPattern: const [8, 4],
                                color: AppColors.textSecondary,
                                strokeWidth: 2,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: AppColors.primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      const Flexible(
                                        child: Text(
                                          "Create New Account",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        final account = accounts[index];
                        String formattedBalance =
                            formatNumber(account.balance.toString());

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RouteNames.showAccount,
                                arguments: account.id);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  account.accountName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Center(
                                  child: Text(
                                    '\$$formattedBalance',
                                    style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.arrow_downward,
                                                color: Color(0xFF757575),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            const Column(
                                              children: [
                                                Text(
                                                  'Income',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  '\$1000}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.arrow_upward,
                                                color: Color(0xFF757575),
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            const Column(
                                              children: [
                                                Text(
                                                  'Expenses',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Text(
                                                  '\$1000}',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: accounts.length + 1,
                    effect: const WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              children: [
                Text(
                  "Transactions",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteNames.transaction);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17.0),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [8, 4],
                color: AppColors.textSecondary,
                strokeWidth: 2,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SizedBox(
                    height: 80,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Flexible(
                            child: Text(
                              "You don’t have any transaction for this period.\nTap to add one.",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
