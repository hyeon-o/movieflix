import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/movie.dart';
import 'package:movie/models/movie_detail.dart';
import 'package:movie/services/api_service.dart';

class DetailScreen extends StatelessWidget {
  final Movie movie;

  const DetailScreen({super.key, required this.movie});

  String getAdditionalInfo(MovieDetail movieDetail) {
    return '${movieDetail.runtime} min | ${movieDetail.genres.map((e) => e.name).join(', ')}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 배경 이미지
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(movie.getBackdropUrl()),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        // 그라데이션 오버레이
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple.withAlpha(50),
                  Colors.purple.withAlpha(70),
                  Colors.purple.withAlpha(90),
                  Colors.black.withAlpha(150),
                  Colors.black.withAlpha(200),
                ],
                stops: [0.0, 0.3, 0.6, 0.9, 1.0],
              ),
            ),
          ),
        ),
        // 메인 콘텐츠
        Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Back to list',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          body: FutureBuilder(
            future: ApiService.getMovieDetail(movie.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 50,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data!.title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        getAdditionalInfo(snapshot.data!),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Storyline',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        snapshot.data!.overview,
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 60),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Buy Ticket',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
