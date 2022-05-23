import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/extensions/exception_ex.dart';
import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/enums/salary_type.dart';
import 'package:student_job_applying/src/models/job_category.dart';
import 'package:student_job_applying/src/models/recruitment_post.dart';
import 'package:student_job_applying/src/modules/main/pages/recruiter_main_page/post_detail/post_detail_bloc.dart';
import 'package:student_job_applying/src/utils/app_style/app_colors.dart';
import 'package:student_job_applying/src/utils/app_style/app_text_styles.dart';
import 'package:student_job_applying/src/utils/helpers.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/widgets/input_text_field.dart';

class PostDetailScreen extends StatefulWidget {
  final void Function() onDelete;
  final void Function(RecruitmentPost newValue) onUpdated;

  const PostDetailScreen(
      {Key? key, required this.onDelete, required this.onUpdated})
      : super(key: key);

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final _jobNameController = TextEditingController();
  final _jobDescriptionController = TextEditingController();
  final _jobCategoryNameController = TextEditingController();
  final _jobCategoryDescriptionController = TextEditingController();
  final _salaryTypeController = TextEditingController();
  final _minSalaryController = TextEditingController();
  final _maxSalaryController = TextEditingController();
  final _genderController = TextEditingController();
  final _ageController = TextEditingController();

  late PostDetailBloC bloC;

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
    bloC = context.read<PostDetailBloC>();
    bloC.getJobCategories();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      getRecruitmentPostDetail(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: StreamBuilder<RecruitmentPost>(
          stream: bloC.recruitmentDetail,
          initialData: bloC.post,
          builder: (_, snapshot) {
            RecruitmentPost post = snapshot.data!;
            _updateTextController(post);
            return _buildScrollableView(context, post);
          },
        ),
      ),
    );
  }

  Widget _buildScrollableView(BuildContext context, RecruitmentPost post) {
    return StreamBuilder<bool>(
      stream: bloC.editButtonState,
      builder: (_, snapshot) {
        bool canEdit = snapshot.data ?? false;
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
                hintText: AppStrings.jobName,
                controller: _jobNameController,
                readOnly: !canEdit,
                textCapitalization: TextCapitalization.words,
                onChanged: (value) => bloC.postDetail.jobName = value.trim(),
              ),
              const SizedBox(height: 12),
              InputTextField(
                hintText: AppStrings.jonDescription,
                controller: _jobDescriptionController,
                readOnly: !canEdit,
                maxLines: 5,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) =>
                    bloC.postDetail.jobDescription = value.trim(),
              ),
              const SizedBox(height: 12),
              InputTextField(
                hintText: AppStrings.jobCategoryName,
                controller: _jobCategoryNameController,
                textCapitalization: TextCapitalization.words,
                readOnly: !canEdit,
                enabled: canEdit,
                suffixIcon: canEdit
                    ? IconButton(
                        onPressed: pickJobCategory,
                        icon: const Icon(
                          Icons.menu_book_outlined,
                          color: AppColors.black1A,
                        ),
                      )
                    : null,
                onChanged: (value) {
                  bloC.jobCategory.name = value.trim();
                  if (bloC.jobCategory.id != null) {
                    bloC.jobCategory.id = null;
                  }
                },
              ),
              const SizedBox(height: 12),
              InputTextField(
                hintText: AppStrings.jobCategoryDescription,
                controller: _jobCategoryDescriptionController,
                textCapitalization: TextCapitalization.sentences,
                readOnly: !canEdit,
                enabled: canEdit,
                onChanged: (value) {
                  bloC.jobCategory.description = value.trim();
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
                hintText: AppStrings.salaryType,
                controller: _salaryTypeController,
                readOnly: true,
                onTap: pickSalaryType,
                enabled: canEdit,
              ),
              const SizedBox(height: 12),
              InputTextField(
                hintText: AppStrings.minSalary,
                controller: _minSalaryController,
                readOnly: !canEdit,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  bloC.postDetail.salaryFrom =
                      double.tryParse(value.trim()) ?? 0;
                },
              ),
              const SizedBox(height: 12),
              InputTextField(
                hintText: AppStrings.maxSalary,
                controller: _maxSalaryController,
                readOnly: !canEdit,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  bloC.postDetail.salaryTo = double.tryParse(value.trim()) ?? 0;
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
                enabled: canEdit,
              ),
              const SizedBox(height: 12),
              InputTextField(
                hintText: AppStrings.age,
                controller: _ageController,
                readOnly: true,
                onTap: pickAge,
                enabled: canEdit,
              ),
              const SizedBox(height: 36),
              if (canEdit)
                Align(
                  alignment: Alignment.center,
                  child: _deletePostButton(context),
                ),
            ],
          ),
        );
      },
    );
  }

  void getRecruitmentPostDetail(BuildContext context) {
    if (!mounted) return;
    bloC.getRecruitmentDetail().catchError((error) {
      showToastMessage(error.message);
    });
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text(AppStrings.recruitment),
      actions: [
        _buildEditAndSaveButton(context),
      ],
    );
  }

  Widget _buildEditAndSaveButton(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.editButtonState,
      builder: (_, snapshot) {
        bool canEdit = snapshot.data ?? false;
        return TextButton(
          onPressed: () {
            if (canEdit) {
              updatePost();
            }
            bloC.editMode = !canEdit;
          },
          child: Text(
            canEdit ? AppStrings.save : AppStrings.edit,
            style: AppTextStyles.whiteBold,
          ),
        );
      },
    );
  }

  Widget _deletePostButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: AppColors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.delete, color: AppColors.red),
          const SizedBox(width: 12),
          Text(
            AppStrings.deletePost,
            style: AppTextStyles.whiteBold.copyWith(color: AppColors.red),
          ),
        ],
      ),
      onPressed: deletePost,
    );
  }

  void updatePost() {
    showLoading(context, message: AppStrings.updating);
    bloC.updatePost().then((_) {
      Navigator.pop(context); // hide loading
      showToastMessage(AppStrings.updateSuccessfully);
      widget.onUpdated(bloC.postDetail);
    }).catchError((error) {
      Navigator.pop(context); // hide loading
      showToastMessage((error as Exception).message);
    });
  }

  void deletePost() {
    showConfirmDialog(context,
            actionText: AppStrings.delete,
            message: '${AppStrings.areYouSureToDeleteThisPost}?')
        .then((confirm) {
      if (confirm) {
        showLoading(context, message: AppStrings.deleting);
        bloC.deletePost().then((_) {
          showToastMessage(AppStrings.deletePostSuccessfully);
          widget.onDelete();
          Navigator.pop(context); // hide loading
          Navigator.pop(context); // hide detail screen
        });
      }
    }).catchError((error) {
      Navigator.pop(context); // hide loading
      showToastMessage((error as Exception).message);
    });
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
        bloC.postDetail.minAge = age;
      }
    });
  }

  void pickGender() {
    showCupertinoBottomPicker<Gender>(
      context,
      listData: Gender.values,
      item: (gender) => Text(gender.name),
      initialItem: bloC.postDetail.gender,
    ).then((gender) {
      if (gender != null) {
        _genderController.text = gender.name;
        bloC.postDetail.gender = gender;
      }
    });
  }

  void pickSalaryType() {
    showCupertinoBottomPicker<SalaryType>(
      context,
      listData: SalaryType.values,
      item: (gender) => Text(gender.name),
      initialItem: bloC.postDetail.salaryType,
    ).then((salaryType) {
      if (salaryType != null) {
        _salaryTypeController.text = salaryType.name;
        bloC.postDetail.salaryType = salaryType;
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
      initialItem: bloC.postDetail.jobCategory,
    ).then((jobCategory) {
      if (jobCategory != null) {
        _jobCategoryNameController.text = jobCategory.name;
        _jobCategoryDescriptionController.text = jobCategory.description;
        bloC.jobCategory = jobCategory;
      }
    });
  }

  void _updateTextController(RecruitmentPost post) {
    _jobNameController.text = post.jobName;
    _jobDescriptionController.text = post.jobDescription;
    _jobCategoryNameController.text = post.jobCategory?.name ?? '';
    _jobCategoryDescriptionController.text =
        post.jobCategory?.description ?? '';
    _salaryTypeController.text = post.salaryType.name;
    _minSalaryController.text = post.salaryFrom.toStringAsFixed(0);
    _maxSalaryController.text = post.salaryTo.toStringAsFixed(0);
    _genderController.text = post.gender?.name ?? '';
    _ageController.text = post.minAge.toString();
  }
}
