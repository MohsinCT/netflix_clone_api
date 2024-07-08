import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/models/now_playing_model.dart';
import 'package:netflix_clone/screens/movie_detail_screen.dart';

class MovieCardTwo extends StatelessWidget {
  final Future<NowPlayingModel> future;
  final String headLineText;
  const MovieCardTwo({super.key, required this.future, required this.headLineText});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NowPlayingModel>(
      future:future ,
      builder: (context , snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if(snapshot.hasError || snapshot.data == null){
          return const Center(
            child: Center(
              child: Text('No data available'),
            ),
          );
        }
        var data = snapshot.data?.results;
        return  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headLineText,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      var movie = data[index];
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> MovieDetailedScreen(movieId: data[index].id)));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          child: Image.network('$imageUrl${movie.posterPath}'),
                        ),
                      );
                    }))
          ],
        );
      },

    );
  }
}