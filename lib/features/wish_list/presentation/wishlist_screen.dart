import 'package:cached_network_image/cached_network_image.dart';
import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/core/themes/colors.dart';
import 'package:financial_tracker/core/widgets/custom_progressbar.dart';
import 'package:financial_tracker/features/wish_list/domain/model/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<Wishlist> wishlist = [
    Wishlist(
      id: 1,
      name: 'name',
      dueDate: DateTime.now(),
      goalAmount: 1500.0,
      isCompleted: false,
      currentAmount: 500.5,
      imageURL: "https://image.coolblue.nl/max/500x500/products/2092559.png",
    ),
    Wishlist(
      id: 1,
      name: 'name',
      dueDate: DateTime.now(),
      goalAmount: 1800.0,
      isCompleted: false,
      currentAmount: 900.0,
      imageURL:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1egO1T-jTq57sEXTPABDGfQ1KbN-BWPxP_w&s",
    ),
    Wishlist(
      id: 1,
      name: 'name',
      dueDate: DateTime.now(),
      goalAmount: 1500.0,
      isCompleted: false,
      currentAmount: 453.2,
      imageURL:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT34hfoVfmnWbjsoESajIKJ3d_p7FymSBf2yg&s",
    ),
    Wishlist(
      id: 1,
      name: 'name',
      dueDate: DateTime.now(),
      goalAmount: 1500.0,
      isCompleted: false,
      currentAmount: 1000.0,
      imageURL:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHBwvZksFshT_j4D6hynV1FbZaGDDvN_akqg&s",
    ),
    Wishlist(
      id: 1,
      name: 'Samsung S23 Ultra Phone for my family gift',
      dueDate: DateTime.now(),
      goalAmount: 1500.0,
      isCompleted: false,
      currentAmount: 700.5,
      imageURL:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqG5GnYCpisQnm6Q8h4mvfxuypdRqcXSiEUg&s",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Wish List Items",
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.addEditWish);
              },
              icon: const Icon(Icons.add),
            ),
          ],

        ),
        body: ListView.builder(
          itemCount: wishlist.length,
          itemBuilder: (context, index) {
            final wish = wishlist[index];
            String formattedDate =
                DateFormat('dd-MMM-yyyy').format(wish.dueDate);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.showWish,
                      arguments: wish);
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: 2, color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: CachedNetworkImage(
                              height: 100,
                              width: 100,
                              imageUrl: wish.imageURL.toString(),
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primary,
                                  value: progress.progress,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              wish.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Text(
                                "\$${wish.currentAmount}/\$${wish.goalAmount}",
                                style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(formattedDate),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      CustomProgressBar(
                        height: 20,
                        width: 300,
                        progress: (wish.currentAmount / wish.goalAmount),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
