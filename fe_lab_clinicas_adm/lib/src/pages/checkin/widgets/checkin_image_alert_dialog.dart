import 'package:fe_lab_clinicas_adm/src/core/env.dart';
import 'package:flutter/material.dart';


class CheckinImageAlertDialog extends AlertDialog {
  CheckinImageAlertDialog(
    BuildContext context, {
    super.key,
    required String imagePath,
  }) : super(
          content: Image.network(
            '${Env.backendBaseURL}/$imagePath',
            fit: BoxFit.cover,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
}
