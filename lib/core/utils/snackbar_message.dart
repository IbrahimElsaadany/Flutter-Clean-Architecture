import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class SnackBarMessage{
  static void showErrorSnackBar({
    required final BuildContext context,
    required final String message
  })
  => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    )
  );

  static void showSuccessSnackBar({
    required final BuildContext context,
    required final String message
  })
  => ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: AppColors.lightPurple,
    )
  );
}