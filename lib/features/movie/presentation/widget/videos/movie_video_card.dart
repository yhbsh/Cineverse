import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../lib.dart';

class MovieVideoCard extends HookConsumerWidget {
  const MovieVideoCard({super.key, required this.videoEntity, required this.movieId});

  final MovieVideoEntity videoEntity;
  final int movieId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => GoRouter.of(context).goNamed(AppRouteName.video, pathParameters: {'key': videoEntity.key}),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            '${AppConst.baseYoutubeThumbnailUrl}/${videoEntity.key}/0.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const CircularIndicator();
            },
          ),
        ),
      ),
    );
  }
}
