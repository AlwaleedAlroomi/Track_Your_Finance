import 'package:financial_tracker/features/wish_list/domain/model/wishlist_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistState {
  final AsyncValue<List<Wishlist>> wishlistItems;

  WishlistState({required this.wishlistItems});

  WishlistState copyWith({AsyncValue<List<Wishlist>>? wishlistItems}) {
    return WishlistState(wishlistItems: wishlistItems ?? this.wishlistItems);
  }
}
