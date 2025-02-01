import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hint;
  final List<T> items;
  final T? value;
  final Function(T?) onChanged;
  final String? Function(T?)? validator;
  final double borderRadius;

  const CustomDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
    this.validator,
    this.borderRadius = 15.0,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      isExpanded: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 8.h),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      hint: Text(
        hint,
        style: const TextStyle(fontSize: 14),
      ),
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text(item.toString().split('.').last),
        );
      }).toList(),
      validator: validator ??
          (value) => value == null ? 'Please select an option.' : null,
      onChanged: onChanged,
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.only(right: 8),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        elevation: 6,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      menuItemStyleData: MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 8.h),
      ),
    );
  }
}
