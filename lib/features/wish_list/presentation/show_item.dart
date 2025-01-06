import 'package:cached_network_image/cached_network_image.dart';
import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/core/themes/colors.dart';
import 'package:financial_tracker/core/utils/format_utils.dart';
import 'package:financial_tracker/core/widgets/custom_progressbar.dart';
import 'package:financial_tracker/features/wish_list/domain/model/wishlist_model.dart';
import 'package:flutter/material.dart';

class ShowWishItem extends StatelessWidget {
  final Wishlist wishListItem;
  const ShowWishItem({
    super.key,
    required this.wishListItem,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.addEditWish,
                    arguments: wishListItem);
              },
              icon: const Icon(Icons.edit),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                spacing: 2,
                children: [
                  Card(
                    elevation: 10,
                    child: CachedNetworkImage(
                      height: 75,
                      width: 75,
                      imageUrl: wishListItem.imageURL.toString(),
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          value: progress.progress,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.signal_wifi_off),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      wishListItem.name,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              CustomProgressBar(
                height: 30,
                width: MediaQuery.of(context).size.width * .85,
                progress:
                    (wishListItem.currentAmount / wishListItem.goalAmount),
              ),
              Divider(color: Colors.grey.shade300, thickness: 1),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Goal Summary",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "\$${wishListItem.currentAmount}/\$${wishListItem.goalAmount}",
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.grey.shade300, thickness: 1),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Due Date",
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    formatDate(wishListItem.dueDate),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.grey.shade300, thickness: 1),
              const Text(
                "Transactions",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              // ListView.builder for transaction for this wish item
            ],
          ),
        ),
      ),
    );
  }
}
