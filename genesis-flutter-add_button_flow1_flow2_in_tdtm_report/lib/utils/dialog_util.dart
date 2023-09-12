import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DialogUtil {
  static showDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure"),
      content: const Text("Do you want to exit app"),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No")),
        TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("yes"))
      ],
    );
  }

  static showToast() {}

//   String formatDate(DateTime date) {
//   var now = DateTime.now();
//   if (date.year == now.year) {
//     if (date.month == now.month) {
//       if (date.day == now.day) {
//         return 'today at ' + DateFormat('HH:mm').format(date);
//       } else if (date.day == now.day - 1) {
//         return 'yesterday at ' + DateFormat('HH:mm').format(date);
//       }
//     }
//     // Using ' to escape the "at" portion of the output
//     return DateFormat("MMM dd 'a't HH:mm").format(date);
//   } else {
//     return DateFormat("MMM dd yyyy 'a't HH:mm").format(date);
//   }
// }
}
