import 'package:flutter/material.dart';
import 'package:student_job_applying/src/models/enums/type_role.dart';
import 'package:student_job_applying/src/utils/app_style/app_colors.dart';
import 'package:student_job_applying/src/utils/utils.dart';

class TypeRoleCheckBox extends StatefulWidget {
  final void Function(TypeRole value) onChanged;
  const TypeRoleCheckBox({Key? key, required this.onChanged}) : super(key: key);

  @override
  _TypeRoleCheckBoxState createState() => _TypeRoleCheckBoxState();
}

class _TypeRoleCheckBoxState extends State<TypeRoleCheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.all(AppColors.darkBlue),
          value: isChecked,
          onChanged: _onChanged,
        ),
        const Expanded(child: Text(AppStrings.loginAsRecruiter)),
      ],
    );
  }

  void _onChanged(bool? value) {
    setState(() {
      isChecked = value!;
    });
    widget.onChanged(isChecked ? TypeRole.recruiter : TypeRole.student);
  }
}
