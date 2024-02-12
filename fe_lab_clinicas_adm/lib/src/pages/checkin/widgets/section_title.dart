import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: LabClinicasTheme.lightOrangeColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        title,
        style: LabClinicasTheme.subTitleStyle.copyWith(
          color: LabClinicasTheme.orangeColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
