import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../lib.dart';

class MovieMoreDetailsColumn extends HookConsumerWidget {
  const MovieMoreDetailsColumn({super.key, required this.movieDetails});

  final MovieDetailsEntity movieDetails;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> views = useMemoized(() {
      return [
        MovieOverview(overview: movieDetails.overview),
        MovieCreditsList(id: movieDetails.id),
        MovieVideosColumn(id: movieDetails.id, movieId: movieDetails.id),
      ];
    }, []);

    final size = MediaQuery.of(context).size;
    final selectedIndexNotifier = useState(0);
    return Column(
      children: [
        TitlesRow(selectedIndexNotifier: selectedIndexNotifier),
        SizedBox(height: size.height * 0.05),
        views[selectedIndexNotifier.value],
        SizedBox(height: size.height * 0.05),
      ],
    );
  }
}
