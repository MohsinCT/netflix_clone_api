import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/movie_recommendation_model.dart';
import 'package:netflix_clone/models/search_model.dart';
import 'package:netflix_clone/screens/movie_detail_screen.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'dart:async';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();
  SearchModel? searchMovie;
  late Future<MovieRecommendationModel> popularMovies;
  Timer? _debounce;

  void search(String query) {
    apiServices.getSearchMovies(query).then((results) {
      setState(() {
        searchMovie = results;
      });
    });
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        search(query);
      }
    });
  }

  @override
  void initState() {
    popularMovies = apiServices.getPopularMovies();

    // Add listener to the TextEditingController
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setState(() {
          searchMovie = null;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    _debounce?.cancel();
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: CupertinoSearchTextField(
                  controller: searchController,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: nGray,
                  ),
                  suffixIcon: const Icon(
                    Icons.cancel,
                    color: nGray,
                  ),
                  style: const TextStyle(color: nWhite),
                  backgroundColor: nGray.withOpacity(0.3),
                  onChanged: onSearchChanged,
                ),
              ),
              searchController.text.isEmpty
                  ? FutureBuilder<MovieRecommendationModel>(
                      future: popularMovies,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasError) {
                          print('Error: ${snapshot.error}');
                          return const Center(
                            child: Text('Failed to load data'),
                          );
                        }
                        if (!snapshot.hasData || snapshot.data == null) {
                          print('No data found');
                          return const Center(
                            child: Text('No data available'),
                          );
                        }
                        var data = snapshot.data?.results;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Top Searches",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: data!.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var movie = data[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  MovieDetailedScreen(
                                                    movieId: data[index].id,
                                                  )));
                                    },
                                    child: Container(
                                      height: 150,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Row(
                                        children: [
                                          Image.network(
                                            '$imageUrl${movie.posterPath}',
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: SizedBox(
                                              width: 260,
                                              child: Text(
                                                data[index].title,
                                                style: const TextStyle(
                                                    fontSize: 12),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                          ],
                        );
                      },
                    )
                  : searchMovie == null
                      ? const SizedBox.shrink()
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchMovie?.results.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 1.2 / 2),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => MovieDetailedScreen(
                                        movieId:
                                            searchMovie!.results[index].id)));
                              },
                              child: Column(
                                children: [
                                  // ignore: unnecessary_null_comparison
                                  searchMovie!.results[index].backdropPath ==
                                          null
                                      ? Image.asset('assets/netflix.png')
                                      : CachedNetworkImage(
                                          imageUrl:
                                              "$imageUrl${searchMovie!.results[index].backdropPath}",
                                          height: 170,
                                        ),
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      searchMovie!.results[index].originalTitle,
                                      style: const TextStyle(fontSize: 11),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
