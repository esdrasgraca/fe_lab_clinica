import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';


class DocumentBox extends StatelessWidget {
  final Widget icon;
  final bool uploaded;
  final String label;
  final int totalFiles;
  final VoidCallback? onTap;

  const DocumentBox({
    super.key,
    required this.uploaded,
    required this.icon,
    required this.label,
    required this.totalFiles,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final totalFilesText = totalFiles > 0 ? '($totalFiles)' : '';

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: uploaded ? LabClinicasTheme.lightOrangeColor : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: LabClinicasTheme.orangeColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(height: 24),
              Text(
                '$label $totalFilesText',
                style: const TextStyle(
                  fontSize: 14,
                  color: LabClinicasTheme.orangeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}