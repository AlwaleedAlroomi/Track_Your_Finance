import 'package:cached_network_image/cached_network_image.dart';
import 'package:financial_tracker/core/routes/routes_name.dart';
import 'package:financial_tracker/core/themes/colors.dart';
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
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
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
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateFormat('yyyy-MM-dd').parse(_dateController.text),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        // Update the text field with the selected date
        _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
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
                            onPressed: () async {
                              final value = await Navigator.pushNamed(
                                  context, RouteNames.imagePicker);
                              setState(() {
                                _imageURL = value == null
                                    ? _imageURL
                                    : value.toString();
                              });
                            },
                          )
                        : GestureDetector(
                            onTap: () async {
                              final value = await Navigator.pushNamed(
                                  context, RouteNames.imagePicker);
                              setState(() {
                                _imageURL = value == null
                                    ? _imageURL
                                    : value.toString();
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
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
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
      ),
    );
  }
}
