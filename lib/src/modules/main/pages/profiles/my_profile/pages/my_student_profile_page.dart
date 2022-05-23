import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/request_models/required_informations_request_model.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/my_profile/my_profile_bloc.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/permission_utils.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/widgets/input_text_field.dart';

class MyStudentProfilePage extends StatefulWidget {
  const MyStudentProfilePage({Key? key}) : super(key: key);

  @override
  State<MyStudentProfilePage> createState() => _MyStudentProfilePageState();
}

class _MyStudentProfilePageState extends State<MyStudentProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  late MyProfileBloC bloC;
  late UserManager userManager;

  @override
  void initState() {
    bloC = context.read<MyProfileBloC>();
    userManager = context.read<UserManager>();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Stack(
          children: [
            _buildScrollableView(context),
            const Positioned(
              top: 28.0,
              left: 4.0,
              child: BackButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScrollableView(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 16.0),
      child: StreamBuilder<User?>(
        stream: userManager.currentUser,
        builder: (context, snapshot) {
          User? userData = snapshot.data;
          bloC.studentRequestModel =
              StudentRequiredInformationsRequestModel.fromUser(userData);
          _updateTextController(userData);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: _buildAvatar(context, userData?.avatar)),
              const SizedBox(height: 24.0),
              // full name
              InputTextField(
                hintText: AppStrings.fullName,
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                onChanged: (name) {
                  bloC.studentRequestModel.name = name.trim();
                },
              ),
              const SizedBox(height: 12.0),
              // age
              InputTextField(
                hintText: AppStrings.age,
                controller: _ageController,
                readOnly: true,
                onTap: pickAge,
              ),
              const SizedBox(height: 12.0),
              // gender
              InputTextField(
                hintText: AppStrings.gender,
                controller: _genderController,
                readOnly: true,
                onTap: pickGender,
              ),
              const SizedBox(height: 12.0),
              // phone number
              InputTextField(
                hintText: AppStrings.phoneNumber,
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 11,
                onChanged: (phone) {
                  bloC.studentRequestModel.phone = phone.trim();
                },
              ),
              const SizedBox(height: 12.0),
              // email
              InputTextField(
                hintText: AppStrings.email,
                controller: _emailController,
                readOnly: true,
              ),
              const SizedBox(height: 12.0),
              // address
              InputTextField(
                hintText: AppStrings.address,
                controller: _addressController,
                readOnly: true,
              ),
              const SizedBox(height: 12.0),
              _buildChangePasswordButton(context),
              const SizedBox(height: 24.0),
              _buildUpdateButton(context),
              const SizedBox(height: 24.0),
              Center(child: _buildLogOutButton(context)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      child: const Text(
        AppStrings.update,
        style: AppTextStyles.whiteBold,
      ),
      onPressed: () {
        updateUserProfile().catchError((error) {
          Navigator.pop(context); // hide loading
          showToastMessage(error.message);
        });
      },
    );
  }

  Widget _buildLogOutButton(BuildContext context) {
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
          const Icon(Icons.logout, color: AppColors.red),
          const SizedBox(width: 12),
          Text(
            AppStrings.logout,
            style: AppTextStyles.whiteBold.copyWith(color: AppColors.red),
          ),
        ],
      ),
      onPressed: logout,
    );
  }

  Widget _buildChangePasswordButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, RouteNames.changePassword);
      },
      child: const Text(AppStrings.changePassword),
    );
  }

  Widget _buildAvatar(BuildContext context, String? avatar) {
    return InkWell(
      onTap: pickImage,
      splashColor: AppColors.noColor,
      highlightColor: AppColors.noColor,
      child: StreamBuilder<File>(
        stream: bloC.avatarStream,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return buildNetworkCircleAvatar(avatar ?? '',
                size: MediaQuery.of(context).size.width / 2.5);
          }
          return buildFileCircleAvatar(snapshot.data,
              size: MediaQuery.of(context).size.width / 2.5);
        },
      ),
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
        bloC.studentRequestModel.age = age;
      }
    });
  }

  void pickGender() {
    showCupertinoBottomPicker<Gender>(
      context,
      listData: Gender.values.sublist(0, 2),
      item: (gender) => Text(gender.name),
      initialItem: bloC.studentRequestModel.gender,
    ).then((gender) {
      if (gender != null) {
        _genderController.text = gender.name;
        bloC.studentRequestModel.gender = gender;
      }
    });
  }

  void _updateTextController(User? user) {
    _nameController.text = user?.name ?? '';
    _ageController.text = '${user?.age ?? ''}';
    _genderController.text = user?.gender?.name ?? '';
    _emailController.text = user?.email ?? '';
    _phoneController.text = user?.phone ?? '';
    _addressController.text = user?.address ?? '';
  }

  Future<void> pickImage() async {
    bool isGranted = await PermissionUtil.checkPhotoAccessPermission(context);
    if (isGranted) {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        bloC.avatar = File(file.path);
      }
    }
  }

  Future<void> updateUserProfile() async {
    showLoading(context, message: AppStrings.updatingProfile);
    await bloC.updateUserInformations();
    User user = await bloC.getCurrentUserInformations();
    userManager.broadcastUser(user);
    showToastMessage(AppStrings.updateSuccessfully);
    Navigator.pop(context); // hide loading
  }

  void logout() {
    showConfirmDialog(context,
            actionText: AppStrings.logout,
            message: '${AppStrings.areYouSureThatYouWantToLogout}?')
        .then((confirm) {
      if (confirm) {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteNames.root, (Route<dynamic> route) => false);
        userManager.clear();
      }
    });
  }
}
