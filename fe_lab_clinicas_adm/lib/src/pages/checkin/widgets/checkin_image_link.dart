import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';

import 'checkin_image_alert_dialog.dart';

class CheckinImageLink extends StatelessWidget {
  final String label;
  final String image;

  const CheckinImageLink({
    super.key,
    required this.label,
    required this.image,
  });

  void showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CheckinImageAlertDialog(context, imagePath: image);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showImageDialog(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          label,
          style: const TextStyle(
            color: LabClinicasTheme.blueColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
