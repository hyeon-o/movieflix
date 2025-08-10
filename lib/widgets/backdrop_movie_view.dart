import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/screens/detail_screen.dart';

class BackdropMovieView extends StatelessWidget {
  final Movie movie;
  
  const BackdropMovieView({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(movie: movie),
          ),
        );
      },
      child: Container(
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: CachedNetworkImageProvider(movie.getBackdropUrl()),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
