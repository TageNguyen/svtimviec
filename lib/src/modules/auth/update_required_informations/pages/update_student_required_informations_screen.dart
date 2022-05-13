import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:student_job_applying/src/managers/user_manager.dart';
import 'package:student_job_applying/src/models/enums/gender.dart';
import 'package:student_job_applying/src/models/province.dart';
import 'package:student_job_applying/src/models/user.dart';
import 'package:student_job_applying/src/modules/auth/update_required_informations/update_required_informations_bloc.dart';
import 'package:student_job_applying/src/struct/routes/route_names.dart';
import 'package:student_job_applying/src/utils/utils.dart';
import 'package:student_job_applying/src/widgets/input_text_field.dart';

class UpdateStudentRequiredInformationsScreen extends StatefulWidget {
  const UpdateStudentRequiredInformationsScreen({Key? key}) : super(key: key);

  @override
  _UpdateStudentRequiredInformationsScreenState createState() =>
      _UpdateStudentRequiredInformationsScreenState();
}

class _UpdateStudentRequiredInformationsScreenState
    extends State<UpdateStudentRequiredInformationsScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
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
    _ageController.dispose();
    _phoneController.dispose();
    _provinceController.dispose();
    _districtController.dispose();
    _wardController.dispose();
    _genderController.dispose();
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
                  // phone number
                  InputTextField(
                    hintText: AppStrings.phoneNumber,
                    controller: _phoneController,
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    onChanged: (phone) {
                      bloC.studentRequestModel.phone = phone.trim();
                      bloC.updateButtonStatus();
                    },
                    onSubmitted: (value) => _districtNode.requestFocus(),
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
                      bloC.studentRequestModel.district = district.trim();
                      bloC.updateButtonStatus();
                    },
                    onSubmitted: (value) => _wardNode.requestFocus(),
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
                      bloC.studentRequestModel.ward = ward.trim();
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

  void pickAge() {
    showCupertinoBottomPicker<int>(
      context,
      listData: [for (var i = 1; i <= 100; i++) i],
      item: (age) => Text('$age'),
      initialItem: int.tryParse(_ageController.text),
    ).then((age) {
      if (age != null) {
        _ageController.text = '$age';
        bloC.studentRequestModel.age = age;
        bloC.updateButtonStatus();
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
        bloC.updateButtonStatus();
      }
    });
  }

  void pickProvince() {
    showCupertinoBottomPicker<Province>(
      context,
      listData: bloC.provinces,
      item: (province) => Text(province.name),
      initialItem: bloC.studentRequestModel.province,
    ).then((province) {
      if (province != null) {
        _provinceController.text = province.name;
        bloC.studentRequestModel.province = province;
        bloC.updateButtonStatus();
      }
    });
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
    Navigator.pushReplacementNamed(context, RouteNames.root);
  }
}
