import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/models/request_models/required_informations_request_model.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/main/pages/profiles/my_profile/my_profile_bloc.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';
import 'package:student_job_applying/src/utils/app_style/app_style.dart';
import 'package:student_job_applying/src/utils/permission_utils.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/widgets/input_text_field.dart';

class MyRecruiterProfilePage extends StatefulWidget {
  const MyRecruiterProfilePage({Key? key}) : super(key: key);

  @override
  State<MyRecruiterProfilePage> createState() => _MyRecruiterProfilePageState();
}

class _MyRecruiterProfilePageState extends State<MyRecruiterProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _companyAddressController =
      TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

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
    _emailController.dispose();
    _phoneController.dispose();
    _companyNameController.dispose();
    _companyAddressController.dispose();
    _websiteController.dispose();
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
      child: StreamBuilder<User?>(
        stream: userManager.currentUser,
        builder: (context, snapshot) {
          User? userData = snapshot.data;
          bloC.recruiterRequestModel =
              RecruiterRequiredInformationsRequestModel.fromUser(userData);
          _updateTextController(userData);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCompanyAndRecruiterImage(context, userData),
              const SizedBox(height: 24.0),
              _buildUserInformations(context, userData),
              const SizedBox(height: 24.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: _buildUpdateButton(context),
              ),
              const SizedBox(height: 24.0),
              Center(child: _buildLogOutButton(context)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserInformations(BuildContext context, User? user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          // full name
          InputTextField(
            hintText: AppStrings.fullName,
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            onChanged: (name) {
              bloC.recruiterRequestModel.name = name.trim();
            },
          ),
          const SizedBox(height: 12.0),
          // company name
          InputTextField(
            hintText: AppStrings.age,
            controller: _companyNameController,
            onChanged: (companyName) {
              bloC.recruiterRequestModel.companyName = companyName.trim();
            },
          ),
          const SizedBox(height: 12.0),
          // phone number
          InputTextField(
            hintText: AppStrings.phoneNumber,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            onChanged: (phone) {
              bloC.recruiterRequestModel.phone = phone.trim();
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
            controller: _companyAddressController,
            readOnly: true,
          ),
          const SizedBox(height: 12.0),
          // website
          InputTextField(
            hintText: AppStrings.website,
            controller: _websiteController,
            onChanged: (url) {
              bloC.recruiterRequestModel.website = url.trim();
            },
          ),
        ],
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

  Widget _buildCompanyAndRecruiterImage(BuildContext context, User? user) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        _buildCompanyImage(context, user?.companyImage ?? ''),
        _buildRecruiterAvatar(context, user?.avatar ?? ''),
      ],
    );
  }

  Widget _buildCompanyImage(BuildContext context, String pathImage) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: pickCompanyImage,
      splashColor: AppColors.noColor,
      highlightColor: AppColors.noColor,
      child: Container(
        color: AppColors.white,
        margin: EdgeInsets.only(bottom: screenSize.width / 5),
        height: screenSize.height / 4,
        width: screenSize.width,
        child: StreamBuilder<File>(
          stream: bloC.companyImageStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return buildNetworkImage(pathImage);
            }
            return buildFileImage(snapshot.data);
          },
        ),
      ),
    );
  }

  Widget _buildRecruiterAvatar(BuildContext context, String avatar) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: pickRecruiterAvatar,
      splashColor: AppColors.noColor,
      highlightColor: AppColors.noColor,
      child: StreamBuilder<File>(
        stream: bloC.avatarStream,
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return buildNetworkCircleAvatar(avatar,
                size: screenSize.width / 2.5);
          }
          return buildFileCircleAvatar(snapshot.data,
              size: screenSize.width / 2.5);
        },
      ),
    );
  }

  void _updateTextController(User? user) {
    _nameController.text = user?.name ?? '';
    _companyNameController.text = user?.companyName ?? '';
    _companyAddressController.text = user?.companyAddress ?? '';
    _emailController.text = user?.email ?? '';
    _phoneController.text = user?.phone ?? '';
    _websiteController.text = user?.website ?? '';
  }

  Future<void> pickRecruiterAvatar() async {
    bool isGranted = await PermissionUtil.checkPhotoAccessPermission(context);
    if (isGranted) {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        bloC.avatar = File(file.path);
      }
    }
  }

  Future<void> pickCompanyImage() async {
    bool isGranted = await PermissionUtil.checkPhotoAccessPermission(context);
    if (isGranted) {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        bloC.companyImage = File(file.path);
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
