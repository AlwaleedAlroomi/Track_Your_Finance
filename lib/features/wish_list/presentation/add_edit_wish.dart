import 'package:cached_network_image/cached_network_image.dart';
import 'package:financial_tracker/config/routes.dart';
import 'package:financial_tracker/core/constants/colors.dart';
import 'package:financial_tracker/core/utils/format_utils.dart';
import 'package:financial_tracker/features/wish_list/domain/model/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddEditWish extends StatefulWidget {
  final Wishlist? wishlistItem;
  const AddEditWish({super.key, this.wishlistItem});

  @override
  State<AddEditWish> createState() => _AddEditWishState();
}

class _AddEditWishState extends State<AddEditWish> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _wishItemNameController;
  final _wishItemNameFocusNode = FocusNode();
  late TextEditingController _wishItemGoalAmountController;
  final _wishItemGoalAmountFocusNode = FocusNode();
  late TextEditingController _wishItemCurrentAmountController;
  final _wishItemCurrentAmountFocusNode = FocusNode();
  late String _imageURL;

  @override
  void initState() {
    super.initState();
    _wishItemNameController =
        TextEditingController(text: widget.wishlistItem?.name);
    _wishItemGoalAmountController =
        TextEditingController(text: widget.wishlistItem?.goalAmount.toString());
    _wishItemCurrentAmountController = TextEditingController(
        text: widget.wishlistItem?.currentAmount.toString() ?? "0");
    _imageURL = widget.wishlistItem?.imageURL ?? '';
  }

  @override
  void dispose() {
    _wishItemNameController.dispose();
    _wishItemNameFocusNode.dispose();
    _wishItemGoalAmountController.dispose();
    _wishItemGoalAmountFocusNode.dispose();
    _wishItemCurrentAmountController.dispose();
    _wishItemCurrentAmountFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              widget.wishlistItem != null ? "Edit Wish Item" : "New Wish Item"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: _imageURL == ''
                      ? IconButton(
                          icon: const Icon(
                            Icons.add_a_photo,
                            size: 50,
                          ),
                          onPressed: () async {
                            final value = await Navigator.pushNamed(
                                context, AppRoutes.imagePicker);
                            setState(() {
                              _imageURL =
                                  value == null ? _imageURL : value.toString();
                            });
                          },
                        )
                      : GestureDetector(
                          onTap: () async {
                            final value = await Navigator.pushNamed(
                                context, AppRoutes.imagePicker);
                            setState(() {
                              _imageURL =
                                  value == null ? _imageURL : value.toString();
                            });
                          },
                          child: CachedNetworkImage(
                            imageUrl: _imageURL,
                            progressIndicatorBuilder:
                                (context, url, progress) => Center(
                              child: CircularProgressIndicator(
                                value: progress.progress,
                                color: AppColors.primary,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.stop),
                          ),
                        ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _wishItemNameController,
                  focusNode: _wishItemNameFocusNode,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    helperText: "",
                    labelText: "Wish Item Name",
                  ),
                ),
                TextFormField(
                  controller: _wishItemGoalAmountController,
                  focusNode: _wishItemGoalAmountFocusNode,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    helperText: "",
                    labelText: "Goal Amount",
                  ),
                  onChanged: (value) {
                    String formattedValue = formatNumber(value);
                    _wishItemGoalAmountController.value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                        offset: formattedValue.length,
                      ),
                    );
                  },
                ),
                TextFormField(
                  controller: _wishItemCurrentAmountController,
                  focusNode: _wishItemCurrentAmountFocusNode,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    helperText: "",
                    labelText: "Current Amount",
                  ),
                  onChanged: (value) {
                    String formattedValue = formatNumber(value);
                    _wishItemCurrentAmountController.value = TextEditingValue(
                      text: formattedValue,
                      selection: TextSelection.collapsed(
                        offset: formattedValue.length,
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          widget.wishlistItem == null
                              ? "Add New Item"
                              : "Edit The Item",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.textAccent,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
