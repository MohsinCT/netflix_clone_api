import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/movie_model.dart';
import 'package:netflix_clone/models/now_playing_model.dart';
import 'package:netflix_clone/models/tv_series_model.dart';
import 'package:netflix_clone/screens/search_screen.dart';
import 'package:netflix_clone/services/api_services.dart';
import 'package:netflix_clone/widgets/custom_carousal.dart';
import 'package:netflix_clone/widgets/movie_card.dart';
import 'package:netflix_clone/widgets/movie_card_two.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices apiServices = ApiServices();
  late Future<UpcomingMovieModel> upcomingFuture;
  late Future<NowPlayingModel> nowPlayingFuture;
  late Future<TvSeriesModel> tvSeriesFuture;

  @override
  void initState() {
    super.initState();
     nowPlayingFuture = apiServices.getNowPlayingMovies();
     upcomingFuture = apiServices.getUpcomingMovies();
     tvSeriesFuture = apiServices.getTvSeriesMovies();
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: nBlack,
        title: Image.asset(
          "assets/logo.png",
          height: 50,
          width: 120,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (ctx) => const SearchScreen()));
              },
              child: const Icon(
                Icons.search,
                color: nWhite,
                size: 30,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Container(
              color: nBlue,
              height: 27,
              width: 27,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<TvSeriesModel>(
              future: tvSeriesFuture,
               builder: (context , snashot){
                if(snashot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snashot.hasError || snashot.data == null){
                  return const  Center(
                    child: Text('No data available'),
                  );
                }
                return CustomCarousalSlider(data: snashot.data!);
               }),
            SizedBox(
              height: 220,
              child: MovieCardTwo(future: nowPlayingFuture, headLineText: 'NowPlaying Movies'),
            ),
            SizedBox(
                height: 220,
                child: MovieCard(
                    future: upcomingFuture, headLineText: 'Upcoming Movies'))
          ],
        ),
      ),
    );
  }
}
