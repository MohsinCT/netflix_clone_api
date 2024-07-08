import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/movie_detailed_model.dart';
import 'package:netflix_clone/models/movie_recommendation_model.dart';
import 'package:netflix_clone/services/api_services.dart';

class MovieDetailedScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailedScreen({super.key, required this.movieId});

  @override
  State<MovieDetailedScreen> createState() => _MovieDetailedScreenState();
}

class _MovieDetailedScreenState extends State<MovieDetailedScreen> {
  ApiServices apiServices = ApiServices();
  late Future<MovieDetailedModel> movieDetail;
  late Future<MovieRecommendationModel> movieRecommendation;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  fetchInitialData() {
    movieDetail = apiServices.getMovieDetails(widget.movieId);
    movieRecommendation = apiServices.getMovieRecommendation(widget.movieId);
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(widget.movieId);
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<MovieDetailedModel>(
            future: movieDetail,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final movie = snapshot.data;
                String genreText =
                    movie!.genres.map((gen) => gen.name).join(',');

                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    '$imageUrl${movie.posterPath}',
                                  ),
                                  fit: BoxFit.cover)),
                          child: SafeArea(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: nWhite,
                                      )),
                                ]),
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          movie.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              movie.releaseDate.year.toString(),
                              style:
                                  const TextStyle(color: nGray, fontSize: 18),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              genreText,
                              style:
                                  const TextStyle(color: nGray, fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          movie.overview,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                   const  SizedBox(
                      height: 30,
                    ),
                    FutureBuilder(
                        future: movieRecommendation,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final movieRecommendation = snapshot.data;
                            return movieRecommendation!.results.isEmpty
                                ?const SizedBox()
                                : Column(
                                    children: [
                                    const  Text('More like this'),
                                      GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount:
                                            movieRecommendation.results.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                mainAxisSpacing: 15,
                                                crossAxisSpacing: 5,
                                                childAspectRatio: 1.5 / 2),
                                        itemBuilder: (context, index) {
                                         return InkWell(
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> MovieDetailedScreen(movieId:movieRecommendation.results[index].id ,)));
                                          },
                                           child: CachedNetworkImage(
                                                imageUrl:
                                                    "$imageUrl${movieRecommendation.results[index].posterPath}"),
                                         );
                                                  
                                        },
                                      )
                                    ],
                                  );
                          } 
                          return const Text("someting went wrong");
                        })
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
      ),
    );
  }
}
