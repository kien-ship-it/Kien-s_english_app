import 'package:flutter/material.dart';

class ConfirmDialog extends StatefulWidget {
  final Function() confirmFunction;

  const ConfirmDialog({super.key, required this.confirmFunction});

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Confirm Action',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Are you sure you want to proceed?',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    widget.confirmFunction(); // Call the confirm function
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
