import 'package:flutter/material.dart';
import 'package:movie/services/api_service.dart';
import 'package:movie/widgets/poster_movie_view.dart';

class ComingSoonSection extends StatelessWidget {
  const ComingSoonSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Coming Soon',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: FutureBuilder(
            future: ApiService.getComingSoonMovies(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.results.length,
                  itemBuilder: (context, index) {
                    return PosterMovieView(movie: snapshot.data!.results[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 12);
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}
