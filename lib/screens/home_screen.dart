import 'package:dotted_border/dotted_border.dart';
import 'package:financial_tracker/config/routes.dart';
import 'package:financial_tracker/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../features/accounts/domain/models/account_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(viewportFraction: 1.0);
  // final List<Map<String, dynamic>> accounts = [
  //   {
  //     'id': 1,
  //     'accountName': 'Personal Account',
  //     'balance': 1000.0,
  //     'income': '2000',
  //     'expenses': '1000'
  //   },
  //   {
  //     'accountName': 'Savings Account',
  //     'balance': 1000.0,
  //     'income': '1000.0',
  //     'expenses': '200'
  //   },
  //   {
  //     'accountName': 'Business Account',
  //     'balance': 1000.0,
  //     'income': '4000',
  //     'expenses': '1500'
  //   },
  // ];
  final List<Account> accounts = [
    Account(id: 1, accountName: 'personal', balance: 100.0),
    Account(id: 1, accountName: 'accountName', balance: 100.0),
    Account(id: 1, accountName: 'accountName', balance: 100.0),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top screen
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_alt_outlined),
                    iconSize: 40,
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.red,
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
                              color: Colors.black,
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
                    onPressed: () {},
                    icon: const Icon(Icons.settings_outlined),
                    iconSize: 40,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Account Card
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: PageView.builder(
              itemCount: accounts.length + 1,
              controller: _pageController,
              itemBuilder: (context, index) {
                if (index == accounts.length) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.addEditAccount);
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
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  const Flexible(
                                    child: Text(
                                      "Create New Account",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
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
                  );
                }
                final account = accounts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.showAccount,
                        arguments: account);
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
                            '\$${account.balance}',
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    Column(
                                      children: [
                                        const Text(
                                          'Income',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          '\$1000}',
                                          style: const TextStyle(
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
                                    Column(
                                      children: [
                                        const Text(
                                          'Expenses',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Text(
                                          '\$1000}',
                                          style: const TextStyle(
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
          const SizedBox(height: 5),
          SmoothPageIndicator(
            controller: _pageController,
            count: accounts.length + 1,
            effect: const WormEffect(
              dotHeight: 10,
              dotWidth: 10,
            ),
          ),
          // Bottom screen
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 17),
            child: Row(
              children: [
                Text(
                  "Transactions",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.transaction);
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
                                color: Colors.black,
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
