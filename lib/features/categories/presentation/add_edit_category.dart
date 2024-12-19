import 'package:financial_tracker/config/routes.dart';
import 'package:financial_tracker/core/constants/colors.dart';
import 'package:financial_tracker/features/categories/domain/models/category_model.dart';
import 'package:financial_tracker/features/categories/icons.dart';
import 'package:flutter/material.dart';

class AddEditCategoryScreen extends StatefulWidget {
  final Category? category;

  const AddEditCategoryScreen({super.key, this.category});

  @override
  State<AddEditCategoryScreen> createState() => _AddEditCategoryScreenState();
}

class _AddEditCategoryScreenState extends State<AddEditCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _categoryNameController = TextEditingController();
  final _categoryNameFocusNode = FocusNode();
  late Icon _categoryIcon;
  late Color? _selectedColor;
  late IconData? _selectedCategoryIcon;
  late final List<Color> _categoryIconColor = [
    Colors.amber,
    Colors.lightGreen,
    Colors.lightBlue,
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.pinkAccent,
    Colors.deepPurpleAccent,
    Colors.deepPurple,
    Colors.deepOrange,
    Colors.green,
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.blueGrey,
    Colors.orange,
    Colors.lime,
  ];

  @override
  void dispose() {
    _categoryNameController.dispose();
    _categoryNameFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    if (widget.category != null) {
      // Pre-fill fields for editing.
      _categoryNameController.text = widget.category!.name;
      _selectedCategoryIcon = widget.category!.icon.icon;
      _selectedColor = widget.category!.color;
    } else {
      // Default settings for adding.
      _categoryIcon = const Icon(Icons.badge_sharp);
      _selectedColor = null;
      _selectedCategoryIcon = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.categories,
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.close,
              size: 30,
            ),
          ),
          title: Text(
            widget.category != null ? "Edit Category" : "Add Category",
            style: const TextStyle(color: AppColors.textPrimary),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text(
                "Save",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Icon(
                        _selectedCategoryIcon ?? _categoryIcon.icon,
                        size: 150,
                        color: _selectedColor,
                      ),
                    ),
                    Container(
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 4, color: AppColors.border),
                      ),
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            focusNode: _categoryNameFocusNode,
                            controller: _categoryNameController,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: "Category Name",
                              hintStyle: TextStyle(
                                color: AppColors.textSecondary,
                              ),
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a valid name";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Color",
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: _categoryIconColor.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final color = _categoryIconColor[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      spacing: 2,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedColor = color;
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: _selectedColor == color
                                  ? Border.all(width: 2, color: Colors.black)
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Icon",
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 50,
                  mainAxisSpacing: 10,
                ),
                itemCount: allIcons.length,
                itemBuilder: (context, index) {
                  final icon = allIcons[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      spacing: 2,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategoryIcon = icon;
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              boxShadow: _selectedCategoryIcon == icon
                                  ? [
                                      BoxShadow(
                                        color:
                                            _selectedColor?.withOpacity(0.4) ??
                                                Colors.black,
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: const Offset(
                                          0,
                                          3,
                                        ), // changes position of shadow
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Center(
                              child: Icon(
                                icon,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}