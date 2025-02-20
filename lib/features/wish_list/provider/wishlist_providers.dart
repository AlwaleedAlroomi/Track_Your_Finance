import 'package:financial_tracker/features/accounts/provider/accounts_providers.dart';
import 'package:financial_tracker/features/wish_list/data/repositories/wishlist_repository.dart';
import 'package:financial_tracker/features/wish_list/domain/model/wishlist_model.dart';
import 'package:financial_tracker/features/wish_list/provider/wishlist_notifier.dart';
import 'package:financial_tracker/features/wish_list/provider/wishlist_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishListRepositoryProvider = Provider(
  (ref) {
    final databaseProvider = ref.watch(databaseHelperProvider);
    return WishlistRepository(databaseProvider);
  },
);

final wishlistNotifierProvider =
    StateNotifierProvider<WishlistNotifier, WishlistState>(
  (ref) {
    final wishListRepository = ref.watch(wishListRepositoryProvider);
    return WishlistNotifier(wishListRepository);
  },
);

final wishlistItemProvider = Provider.family<AsyncValue<Wishlist?>, int>(
  (ref, wishlistItemId) {
    final accountsState = ref.watch(wishlistNotifierProvider);
    return accountsState.wishlistItems.when(
      data: (wishlistItems) {
        final wishlistItem =
            wishlistItems.firstWhere((acc) => acc.id == wishlistItemId,
                orElse: () => Wishlist(
                      name: "",
                      dueDate: DateTime.now(),
                      goalAmount: 0,
                      isCompleted: false,
                      currentAmount: 0,
                      imageURL: "",
                    ));
        return AsyncValue.data(wishlistItem);
      },
      loading: () => const AsyncValue.loading(),
      error: (e, stack) => AsyncValue.error(e, stack),
    );
  },
);
