import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:netflix_clone/common/utils.dart';

class EveryoneWatchingWidget extends StatelessWidget {
  final String imageUrl;
  final String overView;
  final String logoUrl;
  final String month;
  final String day;

  const EveryoneWatchingWidget(
      {super.key,
      required this.imageUrl,
      required this.overView,
      required this.logoUrl,
      required this.month,
      required this.day});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Text(
                month,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                day,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    letterSpacing: 5),
              )
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.3,
                      height: size.height * 0.2,
                      child: CachedNetworkImage(
                        imageUrl: logoUrl,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    const Spacer(),
                    const Column(
                      children: [
                        Icon(
                          Icons.notifications_none_rounded,
                          size: 25,
                          color: nWhite,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Remind Me',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 8),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 25,
                          color: nWhite,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Info',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 8),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const  Text(
                      'About This Movie',
                      style:  TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.5),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      overView,
                      textAlign: TextAlign.left,
                      maxLines: 3,
                      style:
                          const TextStyle(color: Colors.grey, fontSize: 12.5),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
