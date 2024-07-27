import 'package:flutter/material.dart';
//import 'package:flutter_fire/constants/routes.dart';

Future<void> showErrorDialog(BuildContext context, String msg) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        icon: const Icon(
          Icons.error,
        ),
        title: const Text(
          'Error occured!',
        ),
        content: Text(msg),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

Future<bool> showEmailNotVerifiedDialog(
  BuildContext context,
) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        icon: const Icon(
          Icons.info,
        ),
        title: const Text('Information'),
        content: const Text(
          'Your email is not verified yet! We are redirecting you on verify email page',
        ),
        actions: [
          TextButton(
              onPressed: () {
                //Navigator.of(context).pushNamedAndRemoveUntil(verifyEmailRoute, (context) => false);
              },
              child: const Text('OK')),
        ],
      );
    },
  ).then((value) => value ?? false);
}

Future<bool> showLogOutDailog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Are you sure to log out?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Log out')),
          ],
        );
      }).then((value) => value ?? false);
}

Future<bool> showDeleteDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Note'),
          content: const Text('Are you sure to delete this note?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('No')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Yes')),
          ],
        );
      }).then((value) => value ?? false);
}

Future<void> showCannotShareEmptyNoteDailog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sharing'),
          content: const Text('You cannot share an empty note!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ok')),
          ],
        );
      });
}
