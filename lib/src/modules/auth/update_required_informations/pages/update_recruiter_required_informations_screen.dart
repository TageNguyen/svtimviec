import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/models/province.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/auth/update_required_informations/update_required_informations_bloc.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';
import 'package:student_job_applying/src/utils/permission_utils.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/widgets/input_text_field.dart';

class UpdateRecruiterRequiredInformationsScreen extends StatefulWidget {
  const UpdateRecruiterRequiredInformationsScreen({Key? key}) : super(key: key);

  @override
  _UpdateRecruiterRequiredInformationsScreenState createState() =>
      _UpdateRecruiterRequiredInformationsScreenState();
}

class _UpdateRecruiterRequiredInformationsScreenState
    extends State<UpdateRecruiterRequiredInformationsScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();

  final FocusNode _companyNameNode = FocusNode();
  final FocusNode _districtNode = FocusNode();
  final FocusNode _wardNode = FocusNode();

  late UpdateRequiredInformationsBloC bloC;
  late UserManager userManager;

  @override
  void initState() {
    bloC = context.read<UpdateRequiredInformationsBloC>();
    userManager = context.read<UserManager>();
    bloC.getProvinces();
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _companyNameController.dispose();
    _provinceController.dispose();
    _districtController.dispose();
    _wardController.dispose();
    _companyNameNode.dispose();
    _districtNode.dispose();
    _wardNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Stack(
          children: [
            _backgroundImage(context),
            SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60.0),
                  Text(
                    AppStrings.youHaveToUpdateInformationsToUseApplication,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 40.0),
                  Align(
                    alignment: Alignment.center,
                    child: _buildCompanyImage(context),
                  ),
                  const SizedBox(height: 24.0),
                  // phone number
                  InputTextField(
                    hintText: AppStrings.phoneNumber,
                    controller: _phoneController,
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    onChanged: (phone) {
                      bloC.recruiterRequestModel.phone = phone.trim();
                      bloC.updateButtonStatus();
                    },
                    onSubmitted: (_) => _companyNameNode.requestFocus(),
                  ),
                  const SizedBox(height: 12.0),
                  // company name
                  InputTextField(
                    hintText: AppStrings.companyName,
                    controller: _companyNameController,
                    focusNode: _companyNameNode,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    onChanged: (companyName) {
                      bloC.recruiterRequestModel.companyName =
                          companyName.trim();
                      bloC.updateButtonStatus();
                    },
                    onSubmitted: (_) => _districtNode.requestFocus(),
                  ),
                  const SizedBox(height: 12.0),
                  // province
                  InputTextField(
                    hintText: AppStrings.province,
                    controller: _provinceController,
                    readOnly: true,
                    onTap: pickProvince,
                  ),
                  const SizedBox(height: 12.0),
                  // district
                  InputTextField(
                    hintText: AppStrings.district,
                    controller: _districtController,
                    focusNode: _districtNode,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (district) {
                      bloC.recruiterRequestModel.district = district.trim();
                      bloC.updateButtonStatus();
                    },
                    onSubmitted: (_) => _wardNode.requestFocus(),
                  ),
                  const SizedBox(height: 12.0),
                  // ward
                  InputTextField(
                    hintText: AppStrings.ward,
                    controller: _wardController,
                    focusNode: _wardNode,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (ward) {
                      bloC.recruiterRequestModel.ward = ward.trim();
                      bloC.updateButtonStatus();
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: _buildUpdateButton(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _backgroundImage(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePaths.loginBackground),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return StreamBuilder<bool>(
      stream: bloC.updateButtonStatusStream,
      builder: (_, snapshot) {
        bool isEnable = snapshot.data ?? false;
        return ElevatedButton(
          onPressed: isEnable
              ? () {
                  updateUserInformations().catchError((error) {
                    Navigator.pop(context); // hide loading
                    showNotificationDialog(context, error.message);
                  });
                }
              : null,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(AppStrings.update),
              SizedBox(width: 8.0),
              Icon(Icons.arrow_forward_rounded),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCompanyImage(BuildContext context) {
    return InkWell(
      onTap: pickImage,
      child: StreamBuilder<File>(
        stream: bloC.companyImageStream,
        builder: (context, snapshot) {
          return buildFileCircleAvatar(snapshot.data,
              size: MediaQuery.of(context).size.width / 2.5);
        },
      ),
    );
  }

  void pickProvince() {
    showCupertinoBottomPicker<Province>(
      context,
      listData: bloC.provinces,
      item: (province) => Text(province.name),
      initialItem: bloC.recruiterRequestModel.province,
    ).then((province) {
      if (province != null) {
        _provinceController.text = province.name;
        bloC.recruiterRequestModel.province = province;
        bloC.updateButtonStatus();
      }
    });
  }

  Future<void> pickImage() async {
    bool isGranted = await PermissionUtil.checkPhotoAccessPermission(context);
    if (isGranted) {
      final ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        bloC.companyImage = File(file.path);
      }
    }
  }

  Future<void> updateUserInformations() async {
    showLoading(context, message: AppStrings.updating);
    await bloC.updateRequiredInformations();
    Navigator.pop(context); // hide loading
    await getUserInformations();
  }

  Future<void> getUserInformations() async {
    showLoading(context, message: AppStrings.loadingUserInformations);
    User userData = await bloC.getCurrentUserInformations();
    userManager.broadcastUser(userData);
    Navigator.of(context).pop(); // hide loading
    // move to main page
    Navigator.pushReplacementNamed(context, RouteNames.main);
  }
}
