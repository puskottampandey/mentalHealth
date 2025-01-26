import 'package:flutter/material.dart';

import '../../global/constants/colors_text.dart';
import '../../global/reuseable/formfield.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          titleSpacing: 0,
          title: ReusableFormField(
            hint: "Search",
            controller: TextEditingController(),
          )),
    );
  }
}
