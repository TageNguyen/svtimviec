import 'package:flutter/material.dart';
import 'package:student_job_applying/src/models/filter_model.dart';
import 'package:student_job_applying/src/modules/main/pages/student_main_page/student_main_page_bloc.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';

class FilterScreen extends StatefulWidget {
  final StudentMainPageBloC studentMainPageBloC;
  const FilterScreen({Key? key, required this.studentMainPageBloC})
      : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<FilterModel> listFilterType = [
    FilterModel(AppStrings.wageSalary, Icons.attach_money_rounded),
    FilterModel(AppStrings.ageGreaterThanTwenty, Icons.downloading_rounded),
    FilterModel(AppStrings.male, Icons.male_rounded),
    FilterModel(AppStrings.female, Icons.female_rounded),
    FilterModel(AppStrings.salaryGreaterThanThreeMillions, Icons.money_rounded),
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.filter,
            style: AppTextStyles.darkBlueBold.copyWith(fontSize: 24),
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 12.0),
          _buildListFilter(context),
          const SizedBox(height: 22.0),
          _buildApplyButton(context),
        ],
      ),
    );
  }

  Widget _buildListFilter(BuildContext context) {
    return StreamBuilder<List<FilterModel>>(
      stream: widget.studentMainPageBloC.chosenFilters,
      builder: (_, snapshot) {
        List<FilterModel> chosenFilters = snapshot.data ?? [];
        return Column(
          children: List.generate(listFilterType.length, (index) {
            bool isChosen = chosenFilters
                .any((element) => element.title == listFilterType[index].title);
            return _buildFilterItem(listFilterType[index], isChosen);
          }),
        );
      },
    );
  }

  Widget _buildFilterItem(FilterModel filterModel, [bool isEnable = false]) {
    return InkWell(
      onTap: () {
        if (isEnable) {
          widget.studentMainPageBloC.removeFilter(filterModel);
        } else {
          widget.studentMainPageBloC.choseFilter(filterModel);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 2.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        decoration: BoxDecoration(
          color: isEnable ? AppColors.tintLighter : Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          children: [
            Icon(
              filterModel.icon,
              color: AppColors.darkBlue,
              size: 24,
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child:
                  Text(filterModel.title, style: AppTextStyles.defaultRegular),
            ),
            if (isEnable)
              const Icon(
                Icons.check_rounded,
                color: AppColors.darkBlue,
              )
          ],
        ),
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: const Text(
        AppStrings.applyFilter,
        style: AppTextStyles.whiteBold,
      ),
      onPressed: () {
        widget.studentMainPageBloC.applyFilter();
        Navigator.pop(context, true);
      },
    );
  }
}
