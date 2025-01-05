import 'package:financial_tracker/core/themes/colors.dart';
import 'package:financial_tracker/features/wish_list/data/repositories/image_search_repository.dart';
import 'package:flutter/material.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  final _formKey = GlobalKey<FormState>();
  final _imageNameController = TextEditingController();
  final _imageNameFocusNode = FocusNode();
  bool isLoading = false;
  final List<String> images = [];

  @override
  void dispose() {
    _imageNameController.dispose();
    _imageNameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _imageNameController,
                  focusNode: _imageNameFocusNode,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {},
                  decoration: const InputDecoration(
                    helperText: "",
                    label: Text("Enter Wish Item Name"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    _imageNameFocusNode.unfocus();
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      final fetchedImages = await ImageSearchRepository()
                          .searchImages(_imageNameController.text.trim());
                      setState(() {
                        images.clear();
                        images.addAll(fetchedImages);
                        isLoading = false;
                      });
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            e.toString(),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text("search"),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ))
                      : images.isEmpty
                          ? const Center(child: Text("No images found."))
                          : GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context, images[index]);
                                  },
                                  child: Image.network(
                                    images[index],
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
