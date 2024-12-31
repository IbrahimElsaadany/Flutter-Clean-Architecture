import 'package:flutter/material.dart';

InputDecorator infoItem({
  required final BuildContext context,
  required final String label,
  required final Map<String, String> data
})
=> InputDecorator(
  decoration: InputDecoration(
    label: Text(
      label,
      style: Theme.of(context).textTheme.titleLarge,
    ),
    border: OutlineInputBorder(
      
    )
  ),
  child: SingleChildScrollView(
    child: Column(
      children: List.generate(
        data.length,
        (final int i)=> _dataItem(context, data.entries.toList()[i])
      )
    ),
  )
);

Row _dataItem(
  final BuildContext context,
  final MapEntry<String, String> entry
)
=> Row(
  crossAxisAlignment: CrossAxisAlignment.baseline,
  textBaseline: TextBaseline.alphabetic,
  children: [
    Text(
      "${entry.key}: ",
      style: Theme.of(context).textTheme.bodyLarge,
    ),
    Expanded(
      child: Text(entry.value,),
    )
  ],
);