import 'package:flutter/material.dart';

import '../../domain/entities/post_entity.dart';

InkWell postItem(final BuildContext context, final PostEntity post)
=> InkWell(
  onTap: () => Navigator.pushNamed(context, '/single_post', arguments: post),
  borderRadius: BorderRadius.circular(10.0),
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          post.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          post.body,
          maxLines: 2,
        ),
      ],
    ),
  ),
);