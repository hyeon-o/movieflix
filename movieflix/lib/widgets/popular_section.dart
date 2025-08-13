import 'package:flutter/material.dart';
import 'package:movie/services/api_service.dart';
import 'package:movie/widgets/backdrop_movie_view.dart';

class PopularSection extends StatelessWidget {
  const PopularSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular Movies',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: FutureBuilder(
            future: ApiService.getPopularMovies(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.results.length,
                  itemBuilder: (context, index) {
                    return BackdropMovieView(movie: snapshot.data!.results[index]);
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
