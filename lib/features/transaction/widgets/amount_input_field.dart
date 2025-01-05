import 'package:flutter/material.dart';
import '../../../core/themes/colors.dart';
import '../../../core/utils/format_utils.dart';

class AmountInputField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final GlobalKey<FormState> formKey;

  const AmountInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: formKey,
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    focusNode: focusNode,
                    controller: controller,
                    onChanged: (value) {
                      String formattedValue = formatNumber(value);
                      controller.value = TextEditingValue(
                        text: formattedValue,
                        selection: TextSelection.collapsed(
                            offset: formattedValue.length),
                      );
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      hintText: "Amount",
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      helperText: "",
                      errorStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 25,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an amount.";
                      }

                      final parsedValue =
                          double.tryParse(value.replaceAll(",", ""));
                      if (parsedValue == null || parsedValue <= 0) {
                        return "Please enter a valid positive number.";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
