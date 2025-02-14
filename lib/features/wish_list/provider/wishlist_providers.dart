import 'package:financial_tracker/features/accounts/provider/accounts_providers.dart';
import 'package:financial_tracker/features/wish_list/data/repositories/wishlist_repository.dart';
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
