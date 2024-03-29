import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../lib.dart';

class MovieCarouselCard extends HookConsumerWidget {
  const MovieCarouselCard({super.key, required this.movie, required this.index});

  final MovieEntity movie;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backdropAsyncValue = ref.watch(fetchBackdropImageProvider(backdropPath: movie.backdropPath));
    return backdropAsyncValue.when(
      error: (error, stack) => Text('$error $stack'),
      loading: () => const CircularIndicator(),
      data: (backdrop) {
        return Stack(
          children: [
            MovieCarouselBackdropImage(movie: movie, backdrop: backdrop),
            MovieCarouselTitle(title: movie.title),
            MovieCarouselRatingCard(rating: movie.voteAverage),
            MovieCarouselRankingCard(index: index),
          ],
        );
      },
    );
  }
}
