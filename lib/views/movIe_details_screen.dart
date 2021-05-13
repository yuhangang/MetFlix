import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:metflix/state/providers/movies_provider.dart';
import 'package:metflix/views/widgets/build_image.dart';

class MovieDetailScreen extends StatelessWidget {
  static const route = "/details";
  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: detailAppBar(context),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: movie.id,
              child: MyImageBuilder.buildThumbNail(movie.backdrop_path,
                  original: true),
            ),
            DetailFadeIn(
              movie: movie,
            ),
          ],
        ),
      ),
    );
  }

  AppBar detailAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    CupertinoIcons.back,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        Consumer(
          builder: (context, watch, child) {
            var isFavourite = watch(favouriteProvider).contains(movie);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: 1,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    isFavourite
                        ? context.read(favouriteProvider.notifier).remove(movie)
                        : context.read(favouriteProvider.notifier).add(movie);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: isFavourite
                            ? Icon(CupertinoIcons.star_fill)
                            : Icon(CupertinoIcons.star),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

class DetailFadeIn extends StatefulWidget {
  const DetailFadeIn({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  _DetailFadeInState createState() => _DetailFadeInState();
}

class _DetailFadeInState extends State<DetailFadeIn> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () => setState(() => isShow = true));
    return AnimatedOpacity(
      duration: Duration(milliseconds: 600),
      opacity: isShow ? 1 : 0,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(stops: [
          0,
          0.1,
          0.3,
          1
        ], colors: [
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              Text(widget.movie.title.toUpperCase(),
                  style: Theme.of(context).textTheme.headline1!.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF5ACFC6),
                      )),
              SizedBox(
                height: 15,
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Opacity(
                  opacity: 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Tooltip(
                        message: 'average vote',
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.film),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.movie.vote_average.toString(),
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Tooltip(
                        message: 'release date',
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.time),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              DateFormat("yyyy-MM-dd")
                                  .format(widget.movie.release_date),
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                widget.movie.overview,
                style: TextStyle(
                    fontSize: 20,
                    height: 1.6,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 1.1),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ))),
      ),
    );
  }
}
