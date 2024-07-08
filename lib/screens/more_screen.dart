import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';
import 'package:netflix_clone/widgets/coming_soon-widget.dart';
import 'package:netflix_clone/widgets/everyone_watching_widget.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
            child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: nBlack,
            title: const Text(
              'New & Hot',
              style: TextStyle(color: nWhite),
            ),
            actions: [
              const Icon(
                Icons.cast,
                color: nWhite,
                size: 30,
              ),
              const SizedBox(
                width: 20,
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
              ),
            ],
            bottom: const TabBar(
                dividerColor: nBlack,
                isScrollable: false,
                labelColor: nBlack,
                unselectedLabelColor: nWhite,
                labelStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: nWhite),
                tabs: [
                  Tab(
                    text: '   🍿 Coming Soon    ',
                  ),
                  Tab(
                    text: ("   🔥 Everyone's Watching    "),
                  )
                ]),
          ),
          body: const TabBarView(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  ComingSoonWidget(
                    imageUrl:
                        'https://assets-in.bmscdn.com/iedb/movies/images/mobile/thumbnail/xlarge/deadpool-and-wolverine-et00341295-1718018322.jpg',
                    overView:
                        'Wolverine is recovering from his injuries when he crosses paths with the loudmouth, Deadpool. They team up to defeat a common enemy.',
                    logoUrl:
                        "https://cdn.marvel.com/content/1x/deadpool3_lob_mas_mob_01.jpg",
                    month: "July",
                    day: "26",
                  ),
                  ComingSoonWidget(
                    imageUrl:
                        'https://assets-in.bmscdn.com/iedb/movies/images/mobile/thumbnail/xlarge/immaculate-et00386198-1712126366.jpg',
                    overView:
                        'The Immaculate Conception is the belief that the Virgin Mary was free of original sin from the moment of her conception. It is one of the four Marian dogmas of the Catholic Church. Debated by medieval theologians, it was not defined as a dogma until 1854, by Pope Pius IX in the papal bull Ineffabilis Deus.',
                    logoUrl:
                        'https://pbs.twimg.com/profile_images/1770530926268723200/GEeBYC8b_400x400.jpg',
                    month: "July",
                    day: "19",
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  EveryoneWatchingWidget(
                      imageUrl:
                          'https://assets-in.bmscdn.com/iedb/movies/images/mobile/thumbnail/xlarge/kalki-2898-ad-et00352941-1718275859.jpg',
                      overView: 'A modern avatar of the Hindu god Vishnu, is said to have descended on Earth to protect the world from evil forces.',
                      logoUrl:
                          'https://i.pinimg.com/736x/bc/16/e6/bc16e61542ec0240141bdb34a1274f83.jpg',
                      month: 'June',
                      day: '27'),
                ],
              ),
            )
          ]),
        )));
  }
}
