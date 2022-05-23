import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/student_main_page_bloc.dart';
import 'package:student_job_applying/src/modules/main/widgets/filter_screen.dart';
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
      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
      child: Row(
        children: [
          Expanded(child: _buildSearchField(context)),
          _buildFilterButton(context),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      controller: _searchController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      onChanged: (keyword) {
        context.read<StudentMainPageBloC>().keyword = keyword.trim();
      },
      onSubmitted: (_) => context
          .read<StudentMainPageBloC>()
          .getRecruitmentPosts(isRefresh: true),
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
    );
  }

  Widget _buildFilterButton(BuildContext context) {
    return IconButton(
      onPressed: () => showFilterBottomSheet(context),
      tooltip: AppStrings.filter,
      icon: Image.asset(
        ImagePaths.iconFilter,
        color: AppColors.white,
      ),
    );
  }

  void showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      builder: (BuildContext _) {
        return BottomSheet(
          onClosing: () {},
          builder: (_) => FilterScreen(
              studentMainPageBloC: context.read<StudentMainPageBloC>()),
        );
      },
    );
  }
}
