import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:metflix/state/providers/movies_provider.dart';
import 'package:metflix/utils/custom_page_route.dart';
import 'package:metflix/views/movIe_details_screen.dart';
import 'package:metflix/views/widgets/build_image.dart';
import 'package:metflix/views/widgets/lazy_load_scroll_view.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final double itemWidth = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
    var scrollDirection2 =
        orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "Favourites",
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(100),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: Icon(Icons.sort)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        body: Consumer(
          builder: (context, watch, child) {
            List<Movie> movies = watch(favouriteProvider);

            return AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: movies.length > 0
                  ? LazyLoadScrollView(
                      onEndOfPage: () {
                        context.read(movieProvider.notifier).fetchMovies();
                      },
                      child: ListView.builder(
                        scrollDirection: scrollDirection2,
                        controller: ScrollController(),
                        padding: EdgeInsets.only(
                            left: 10, right: 10, bottom: 100, top: 100),
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          return buildFavouriteItem(
                              orientation, itemWidth, movies, index, context);
                        },
                      ),
                    )
                  : ListView(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 4 / 9,
                        ),
                        Center(
                          child: Text(
                            "no favourite",
                            style: TextStyle(
                                fontSize: 20, color: Color(0xFFAFAFAF)),
                          ),
                        )
                      ],
                    ),
            );
          },
        ));
  }

  Padding buildFavouriteItem(Orientation orientation, double itemWidth,
      List<Movie> movies, int index, BuildContext context) {
    return Padding(
      padding: orientation == Orientation.portrait
          ? EdgeInsets.only(bottom: 10)
          : EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              CustomPageRoute.verticalTransition(MovieDetailScreen(
                movie: movies[index],
              )));
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: itemWidth,
          height: itemWidth,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF000000)),
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    MyImageBuilder.buildThumbNail(movies[index].backdrop_path),
              ),
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(stops: [
                  0,
                  0.2,
                  0.7,
                  1
                ], colors: [
                  Color(0x25000000),
                  Color(0x17000000),
                  Color(0x00000000),
                  Color(0x23000000)
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movies[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.fade,
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(fontSize: 25),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            movies[index].overview,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Color(0xFFFFFFFF),
                                fontSize: 18,
                                fontWeight: FontWeight.w300,
                                shadows: [
                                  Shadow(
                                      color: Color(0x50000000),
                                      offset: Offset(1, 1),
                                      blurRadius: 5)
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Tooltip(
                        message: 'remove',
                        child: InkWell(
                            onTap: () {
                              context
                                  .read(favouriteProvider.notifier)
                                  .remove(movies[index]);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(3),
                              child: Icon(Icons.delete_outline),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
