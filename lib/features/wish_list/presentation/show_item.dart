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
    return Container(
      child: Center(
        child: Text(wishListItem.name),
      ),
    );
  }
}
