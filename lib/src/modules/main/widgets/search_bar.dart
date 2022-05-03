import 'package:flutter/material.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 4.0),
      child: TextField(
        cursorColor: Colors.white,
        controller: _searchController,
        keyboardType: TextInputType.text,
        onChanged: (keyword) {
          // context.read<ManageUserBloC>().filter(keyword);
        },
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 16.0,
        ),
        decoration: InputDecoration(
          hintText: AppStrings.search,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              ImagePaths.iconSearch,
              color: AppColors.white,
            ),
          ),
          prefixIconConstraints:
              const BoxConstraints(maxHeight: 40, maxWidth: 40),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.tintLighter,
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 0.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              color: AppColors.tintLighter,
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
