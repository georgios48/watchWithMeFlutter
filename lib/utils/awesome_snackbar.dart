import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  late ContentType snackbarContent;

  SnackBar displaySnacbar(int statusCode, String message) {
    switch (statusCode) {
      case 200:
      case 201:
      case 202:
        snackbarContent = ContentType.success;

      case 400:
      case 403:
      case 431:
        snackbarContent = ContentType.warning;

      default:
        snackbarContent = ContentType.failure;
    }

    final snackbar = SnackBar(
      /// need to set following properties for best effect of awesome_snackbar_content
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: '',
        message: message,

        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
        contentType: snackbarContent,
        // to configure for material banner
      ),
    );

    return snackbar;
  }
}
