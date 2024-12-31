import 'package:flutter/material.dart';

abstract class ConfirmationPopup{
  static void showDeletePopup(
    final BuildContext context,
    {
      required final String message,
      required final void Function() func
    }
  )
  => showDialog(
    context: context,
    builder: (final BuildContext context) => AlertDialog(
      contentPadding: const EdgeInsets.all(20.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            message,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                    func();
                  },
                  child: const Text("Yes")
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("No")
                ),
              )
            ],
          )
        ],
      ),
    )
  );
}