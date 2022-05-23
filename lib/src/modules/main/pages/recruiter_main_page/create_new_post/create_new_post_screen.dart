import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/extensions/exception_ex.dart';
import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/enums/salary_type.dart';
import 'package:student_job_applying/src/models/job_category.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/create_new_post/create_new_post_bloc.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/widgets/input_text_field.dart';

class CreateNewPostScreen extends StatefulWidget {
  const CreateNewPostScreen({Key? key}) : super(key: key);

  @override
  _CreateNewPostScreenState createState() => _CreateNewPostScreenState();
}

class _CreateNewPostScreenState extends State<CreateNewPostScreen> {
  final _jobNameController = TextEditingController();
  final _jobDescriptionController = TextEditingController();
  final _jobCategoryNameController = TextEditingController();
  final _jobCategoryDescriptionController = TextEditingController();
  final _salaryTypeController = TextEditingController();
  final _minSalaryController = TextEditingController();
  final _maxSalaryController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();

  late CreateNewPostBloC bloC;

  @override
  void dispose() {
    _jobNameController.dispose();
    _jobDescriptionController.dispose();
    _jobCategoryNameController.dispose();
    _jobCategoryDescriptionController.dispose();
    _salaryTypeController.dispose();
    _minSalaryController.dispose();
    _maxSalaryController.dispose();
    _genderController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    bloC = context.read<CreateNewPostBloC>();
    bloC.getJobCategories();
    _salaryTypeController.text = SalaryType.fixed.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: _buildScrollableBody(context),
      ),
    );
  }

  Widget _buildScrollableBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '${AppStrings.jobInformations}: ',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 12),
          InputTextField(
            hintText: '${AppStrings.jobName}*',
            controller: _jobNameController,
            textCapitalization: TextCapitalization.words,
            onChanged: (value) {
              bloC.post.jobName = value.trim();
              bloC.updatePostButtonState();
            },
          ),
          const SizedBox(height: 12),
          InputTextField(
            hintText: '${AppStrings.jonDescription}*',
            controller: _jobDescriptionController,
            maxLines: 5,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) {
              bloC.post.jobDescription = value.trim();
              bloC.updatePostButtonState();
            },
          ),
          const SizedBox(height: 12),
          InputTextField(
            hintText: '${AppStrings.jobCategoryName}*',
            controller: _jobCategoryNameController,
            textCapitalization: TextCapitalization.words,
            suffixIcon: IconButton(
              onPressed: pickJobCategory,
              icon: const Icon(
                Icons.menu_book_outlined,
                color: AppColors.black1A,
              ),
            ),
            onChanged: (value) {
              bloC.jobCategory.name = value.trim();
              bloC.updatePostButtonState();
              if (bloC.jobCategory.id != null) {
                bloC.jobCategory.id = null;
              }
            },
          ),
          const SizedBox(height: 12),
          InputTextField(
            hintText: '${AppStrings.jobCategoryDescription}*',
            controller: _jobCategoryDescriptionController,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) {
              bloC.jobCategory.description = value.trim();
              bloC.updatePostButtonState();
              if (bloC.jobCategory.id != null) {
                bloC.jobCategory.id = null;
              }
            },
          ),
          const SizedBox(height: 12),
          Text(
            '${AppStrings.salaryInformations}: ',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 12),
          InputTextField(
            hintText: '${AppStrings.salaryType}*',
            controller: _salaryTypeController,
            readOnly: true,
            onTap: pickSalaryType,
          ),
          const SizedBox(height: 12),
          InputTextField(
            hintText: AppStrings.minSalary,
            controller: _minSalaryController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              bloC.post.salaryFrom = double.tryParse(value.trim()) ?? 0;
              bloC.updatePostButtonState();
            },
          ),
          const SizedBox(height: 12),
          InputTextField(
            hintText: AppStrings.maxSalary,
            controller: _maxSalaryController,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              bloC.post.salaryTo = double.tryParse(value.trim()) ?? 0;
              bloC.updatePostButtonState();
            },
          ),
          const SizedBox(height: 12),
          Text(
            '${AppStrings.requirement}: ',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 12),
          InputTextField(
            hintText: AppStrings.gender,
            controller: _genderController,
            readOnly: true,
            onTap: pickGender,
          ),
          const SizedBox(height: 12),
          InputTextField(
            hintText: AppStrings.age,
            controller: _ageController,
            readOnly: true,
            onTap: pickAge,
          ),
          const SizedBox(height: 36),
          postButton(context),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.createNewPost),
    );
  }

  Widget postButton(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.postButtonState,
      builder: (_, snapshot) {
        bool enable = snapshot.data ?? false;
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
          ),
          child: const Text(
            AppStrings.postPost,
            style: AppTextStyles.whiteBold,
          ),
          onPressed: enable ? createNewPost : null,
        );
      },
    );
  }

  void pickAge() {
    showCupertinoBottomPicker<int>(
      context,
      listData: [for (var i = 18; i <= 100; i++) i],
      item: (age) => Text('$age'),
      initialItem: int.tryParse(_ageController.text),
    ).then((age) {
      if (age != null) {
        _ageController.text = '$age';
        bloC.post.minAge = age;
      }
    });
  }

  void pickGender() {
    showCupertinoBottomPicker<Gender>(
      context,
      listData: Gender.values,
      item: (gender) => Text(gender.name),
      initialItem: bloC.post.gender,
    ).then((gender) {
      if (gender != null) {
        _genderController.text = gender.name;
        bloC.post.gender = gender;
      }
    });
  }

  void pickSalaryType() {
    showCupertinoBottomPicker<SalaryType>(
      context,
      listData: SalaryType.values,
      item: (gender) => Text(gender.name),
      initialItem: bloC.post.salaryType,
    ).then((salaryType) {
      if (salaryType != null) {
        _salaryTypeController.text = salaryType.name;
        bloC.post.salaryType = salaryType;
        bloC.updatePostButtonState();
        if (salaryType == SalaryType.wage) {
          _maxSalaryController.clear();
          _minSalaryController.clear();
        }
      }
    });
  }

  void pickJobCategory() {
    showCupertinoBottomPicker<JobCategory>(
      context,
      listData: bloC.jobCategories,
      item: (jobCategory) => Text(jobCategory.name),
      initialItem: bloC.post.jobCategory,
    ).then((jobCategory) {
      if (jobCategory != null) {
        _jobCategoryNameController.text = jobCategory.name;
        _jobCategoryDescriptionController.text = jobCategory.description;
        bloC.jobCategory = jobCategory;
        bloC.updatePostButtonState();
      }
    });
  }

  void createNewPost() {
    showLoading(context, message: AppStrings.postingPost);
    bloC.createNewPost().then((_) {
      Navigator.pop(context); // hide loading
      showToastMessage(
          AppStrings.createNewPostSuccessfulyPleaseWaitAdminForApproving);
      Navigator.pop(context); // hide screen
    }).catchError((error) {
      Navigator.pop(context); // hide loading
      showToastMessage((error as Exception).message);
    });
  }
}
