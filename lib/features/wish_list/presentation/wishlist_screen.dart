import 'package:cached_network_image/cached_network_image.dart';
import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/core/themes/colors.dart';
import 'package:financial_tracker/core/utils/is_dark_mode.dart';
import 'package:financial_tracker/core/widgets/custom_progressbar.dart';
import 'package:financial_tracker/features/settings/riverpod/app_theme_riverpod.dart';
import 'package:financial_tracker/features/wish_list/domain/model/wishlist_model.dart';
import 'package:financial_tracker/features/wish_list/provider/wishlist_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistState = ref.watch(wishlistNotifierProvider);
    final selectedTheme = ref.watch(themeProvider).themeMode;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Wish List Items",
            style: Theme.of(context).textTheme.headlineMedium,
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
        body: wishlistState.wishlistItems.when(
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (wishlist) {
            return wishlist.isEmpty
                ? const Center(child: Text("No Items to show"))
                : ListView.builder(
                    itemCount: wishlist.length,
                    itemBuilder: (context, index) {
                      final wish = wishlist[index];
                      String formattedDate =
                          DateFormat('dd-MMM-yyyy').format(wish.dueDate);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Dismissible(
                          key: Key(wish.id.toString()),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          confirmDismiss: (direction) async {
                            return await showDialog(
                              context: context,
                              builder: (context) => DeleteDialog(
                                selectedTheme: selectedTheme,
                                wish: wish,
                                ref: ref,
                              ),
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, RouteNames.showWish,
                                  arguments: wish.id);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              height: 125,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    width: 2, color: AppColors.border),
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
                                              (context, url, progress) =>
                                                  Center(
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
                                          style: TextStyle(
                                            fontWeight: wish.isCompleted == true
                                                ? FontWeight.w200
                                                : FontWeight.w500,
                                            decoration: wish.isCompleted == true
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
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
                                    progress:
                                        (wish.currentAmount / wish.goalAmount),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.selectedTheme,
    required this.wish,
    required this.ref,
  });

  final ThemeMode selectedTheme;
  final Wishlist wish;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: isDarkMode(context, selectedTheme)
          ? AppColors.textPrimary.withValues(alpha: 0.8) // Gray for dark mode
          : null,
      title: Text("Delete ${wish.name} wish"),
      content: Text("Are you sure you want to delete ${wish.name} wish?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            ref
                .read(wishlistNotifierProvider.notifier)
                .deleteWishListItem(wish);
            Navigator.of(context).pop();
          },
          child: const Text(
            "Delete",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.error,
            ),
          ),
        ),
      ],
    );
  }
}
