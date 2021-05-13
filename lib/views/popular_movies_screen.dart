import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metflix/state/providers/movies_provider.dart';
import 'package:metflix/utils/custom_page_route.dart';
import 'package:metflix/views/movIe_details_screen.dart';
import 'package:metflix/views/widgets/build_image.dart';
import 'package:metflix/views/widgets/lazy_load_scroll_view.dart';

class PopularMovieScreen extends StatefulWidget {
  PopularMovieScreen({Key? key, required this.scrollController})
      : super(key: key);
  final ScrollController scrollController;

  @override
  _PopularMovieScreenState createState() => _PopularMovieScreenState();
}

class _PopularMovieScreenState extends State<PopularMovieScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Trending Movies",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return context.read(movieProvider.notifier).refresh();
        },
        child: Consumer(
          builder: (context, watch, child) {
            MovieFetchingStatus fetchingStatus = watch(movieProvider).status;
            List<Movie> movies = watch(movieProvider).movies;
            List<Movie> favourites = watch(favouriteProvider);

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: movies.length > 0
                  ? LazyLoadScrollView(
                      onEndOfPage: () {
                        context.read(movieProvider.notifier).fetchMovies();
                      },
                      child: GridView.builder(
                        controller: widget.scrollController,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 100, top: 100),
                        itemCount: movies.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: min(screenWidth / 2, 200),
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          bool isFavourite = favourites.contains(movies[index]);
                          return buildPopularItem(
                              context, movies, index, isFavourite);
                        },
                      ),
                    )
                  : ListView(
                      children: [
                        SizedBox(
                          height: screenHeight * 4 / 9,
                        ),
                        Center(
                          child: fetchingStatus == MovieFetchingStatus.loading
                              ? Container(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator())
                              : Text("internet connection lost",
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0xFFAFAFAF))),
                        )
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  InkWell buildPopularItem(
      BuildContext context, List<Movie> movies, int index, bool isFavourite) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CustomPageRoute.verticalTransition(MovieDetailScreen(
              movie: movies[index],
            )));
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xFF000000)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                tag: movies[index].id,
                child:
                    MyImageBuilder.buildThumbNail(movies[index].backdrop_path),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(stops: [
                0,
                0.2,
                0.7,
                1
              ], colors: [
                Color(0x46000000),
                Color(0x11000000),
                Color(0x21000000),
                Color(0x42000000)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movies[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                        onTap: () {
                          isFavourite
                              ? context
                                  .read(favouriteProvider.notifier)
                                  .remove(movies[index])
                              : context
                                  .read(favouriteProvider.notifier)
                                  .add(movies[index]);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: isFavourite
                              ? Icon(CupertinoIcons.star_fill)
                              : Icon(CupertinoIcons.star),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
