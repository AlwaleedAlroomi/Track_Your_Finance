import 'package:cached_network_image/cached_network_image.dart';
import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/core/themes/colors.dart';
import 'package:financial_tracker/core/utils/format_utils.dart';
import 'package:financial_tracker/features/wish_list/domain/model/wishlist_model.dart';
import 'package:financial_tracker/features/wish_list/provider/wishlist_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddEditWish extends ConsumerStatefulWidget {
  final int? wishlistItemId;
  const AddEditWish({super.key, this.wishlistItemId});

  @override
  AddEditWishState createState() => AddEditWishState();
}

class AddEditWishState extends ConsumerState<AddEditWish> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _wishItemNameController = TextEditingController();
  final _wishItemNameFocusNode = FocusNode();
  final TextEditingController _wishItemGoalAmountController =
      TextEditingController();
  final _wishItemGoalAmountFocusNode = FocusNode();
  final TextEditingController _wishItemCurrentAmountController =
      TextEditingController();
  final _wishItemCurrentAmountFocusNode = FocusNode();
  String _imageURL = "";
  final TextEditingController _dateController = TextEditingController();
  DateTime wishDueDate = DateTime.now();
  @override
  void dispose() {
    _wishItemNameController.dispose();
    _wishItemNameFocusNode.dispose();
    _wishItemGoalAmountController.dispose();
    _wishItemGoalAmountFocusNode.dispose();
    _wishItemCurrentAmountController.dispose();
    _wishItemCurrentAmountFocusNode.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: wishDueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Wishlist? wishlistItem;

    if (widget.wishlistItemId != null) {
      final wishlistAsync =
          ref.watch(wishlistItemProvider(widget.wishlistItemId!));

      return wishlistAsync.when(
        data: (wishlist) {
          wishlistItem = wishlist;
          wishDueDate = wishlist?.dueDate ?? DateTime.now();
          // Initialize the fields only once to prevent overwriting user input
          if (_wishItemNameController.text.isEmpty) {
            _wishItemNameController.text = wishlist?.name ?? "";
          }
          if (_wishItemGoalAmountController.text.isEmpty) {
            _wishItemGoalAmountController.text =
                wishlist?.goalAmount.toString() ?? "";
          }
          if (_wishItemCurrentAmountController.text.isEmpty) {
            _wishItemCurrentAmountController.text =
                wishlist?.currentAmount.toString() ?? "0";
          }
          if (_imageURL.isEmpty) {
            _imageURL = wishlist?.imageURL ?? '';
          }
          if (_dateController.text.isEmpty) {
            _dateController.text = wishlist?.dueDate != null
                ? DateFormat('yyyy-MM-dd').format(wishlist!.dueDate)
                : "";
          }

          return _buildForm(context, wishlistItem);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text("Error loading wish item: $err")),
      );
    }
    return _buildForm(context, null);
  }

  Widget _buildForm(BuildContext context, Wishlist? wishlistItem) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            wishlistItem != null ? "Edit Wish Item" : "New Wish Item",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SingleChildScrollView(
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
                            onPressed: () {
                              imageSourceDialog(context);
                            },
                          )
                        : GestureDetector(
                            onTap: () async {
                              imageSourceDialog(context);
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
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
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
                  Row(
                    spacing: 2,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _wishItemCurrentAmountController,
                          focusNode: _wishItemCurrentAmountFocusNode,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            helperText: "",
                            labelText: "Current Amount",
                          ),
                          onChanged: (value) {
                            String formattedValue = formatNumber(value);
                            _wishItemCurrentAmountController.value =
                                TextEditingValue(
                              text: formattedValue,
                              selection: TextSelection.collapsed(
                                offset: formattedValue.length,
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            labelText: "Due Date",
                            helperText: "",
                          ),
                          onTap: () => _selectDate(context),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final goalAmount = _wishItemGoalAmountController
                                .text
                                .replaceAll(",", "");
                            final currentAmount =
                                _wishItemCurrentAmountController.text
                                    .replaceAll(",", "");
                            final progress = double.parse(currentAmount) /
                                double.parse(goalAmount);
                            final newWish = Wishlist(
                              id: wishlistItem?.id,
                              name: _wishItemNameController.text.trim(),
                              dueDate: DateTime.parse(_dateController.text),
                              goalAmount: double.parse(goalAmount),
                              isCompleted: progress == 1 ? true : false,
                              currentAmount: double.parse(currentAmount),
                              imageURL: _imageURL,
                            );

                            if (wishlistItem == null) {
                              await ref
                                  .read(wishlistNotifierProvider.notifier)
                                  .addWishListItem(newWish);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("new wish added")));
                            } else {
                              await ref
                                  .read(wishlistNotifierProvider.notifier)
                                  .updateWishListItem(newWish);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("wish added")));
                            }
                            Navigator.pop(context);
                          },
                          child: Text(
                            wishlistItem == null
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
      ),
    );
  }

  void imageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Choose Image Source"),
          content: const Text(
              "Do you want to enter an image URL or search Unsplash?"),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showURLInputDialog(context);
                  },
                  child: Text(
                    "Image URL",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    final value = await Navigator.pushNamed(
                        context, RouteNames.imagePicker);
                    if (value != null) {
                      setState(() {
                        _imageURL = value.toString();
                      });
                    } else {
                      debugPrint("No URL");
                    }
                  },
                  child: Text(
                    "Unsplash",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<String?> showURLInputDialog(BuildContext context) async {
    TextEditingController urlController = TextEditingController();
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter the image URL for your wish"),
          content: TextField(
            controller: urlController,
            decoration: const InputDecoration(
              hintText: "Paste image URL here",
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final url = urlController.text.trim();
                    if (url.isNotEmpty) {
                      setState(() {
                        _imageURL = url;
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Submit",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
