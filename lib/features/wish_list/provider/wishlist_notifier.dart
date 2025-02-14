import 'package:financial_tracker/features/wish_list/domain/model/wishlist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:financial_tracker/features/wish_list/data/repositories/wishlist_repository.dart';
import 'package:financial_tracker/features/wish_list/provider/wishlist_state.dart';

class WishlistNotifier extends StateNotifier<WishlistState> {
  final WishlistRepository _repository;
  WishlistNotifier(this._repository)
      : super(WishlistState(wishlistItems: const AsyncValue.loading())) {
    loadWishList();
  }

  Future<void> addWishListItem(Wishlist wishItem) async {
    try {
      await _repository.addWishItem(wishItem);
      await loadWishList();
    } catch (e, stackTrace) {
      state = state.copyWith(wishlistItems: AsyncValue.error(e, stackTrace));
    }
  }

  Future<void> loadWishList() async {
    state = state.copyWith(wishlistItems: const AsyncValue.loading());
    try {
      final wishlist = await _repository.getAllWishes();
      state = state.copyWith(wishlistItems: AsyncValue.data(wishlist));
    } catch (e, stackTrace) {
      state = state.copyWith(wishlistItems: AsyncValue.error(e, stackTrace));
    }
  }

  Future<void> updateWishListItem(Wishlist wishItem) async {
    try {
      await _repository.updateWishItem(wishItem);
      await loadWishList();
    } catch (e, stackTrace) {
      state = state.copyWith(wishlistItems: AsyncValue.error(e, stackTrace));
    }
  }

  Future<void> deleteWishListItem(Wishlist wishItem) async {
    try {
      await _repository.deleteWishItem(wishItem);
      await loadWishList();
    } catch (e, stackTrace) {
      state = state.copyWith(wishlistItems: AsyncValue.error(e, stackTrace));
    }
  }
}
