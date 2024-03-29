import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../lib.dart';

class MovieDetailsAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const MovieDetailsAppBar({Key? key, required this.movieDetails}) : super(key: key);

  final MovieDetailsEntity movieDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMoviesAsyncValue = ref.watch(favoriteMoviesNotifierProvider);
    return AppBar(
      title: const Text('Movie Details'),
      actions: [
        favoriteMoviesAsyncValue.when(
          error: (error, stack) => Text('$error $stack'),
          loading: () => const CircularIndicator(),
          data: (favoriteMovies) {
            final isFavorite = favoriteMovies.any((movie) => movie.id == movieDetails.id);
            return IconButton(
              icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_outline),
              onPressed: () {
                if (!isFavorite) ref.read(favoriteMoviesNotifierProvider.notifier).addMovieToFavorite(movieDetails);
                if (isFavorite) {
                  ref.read(favoriteMoviesNotifierProvider.notifier).removeMovieFromFavorite(movieDetails.id);
                }
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
