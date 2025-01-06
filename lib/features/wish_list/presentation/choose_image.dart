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

  Future<void> fetchImages(String imageName) async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedImages =
          await ImageSearchRepository().searchImages(imageName);
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
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (value) {
                    _imageNameFocusNode.unfocus();
                    fetchImages(_imageNameController.text.trim());
                  },
                  keyboardType: TextInputType.name,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    helperText: "",
                    labelText: "Search for your wish",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () =>
                          fetchImages(_imageNameController.text.trim()),
                    ),
                  ),
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
