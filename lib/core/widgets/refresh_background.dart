import 'package:flutter/material.dart';

ListView refreshBackground(final String message)
=> ListView(
  physics: const BouncingScrollPhysics(parent:AlwaysScrollableScrollPhysics()),
  children: [
    const SizedBox(height: 100.0),
    const Icon(Icons.refresh, size: 60.0),
    Text(
      "$message\nDrag to refresh.",
      style: const TextStyle(
        fontSize: 30.0,
        color: Colors.grey
      ),
      textAlign: TextAlign.center,
    ),
  ],
);