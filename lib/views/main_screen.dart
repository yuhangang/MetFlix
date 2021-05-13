import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:metflix/utils/services/movie_services.dart';
import 'package:metflix/views/favourites_screen.dart';
import 'package:metflix/views/popular_movies_screen.dart';

class MainScreen extends StatefulWidget {
  static const route = "/";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final bottomnavigationkey = GlobalKey();
  int index = 0;
  Orientation? orientation;
  PageController pageController = new PageController();
  ScrollController popularMovieController = new ScrollController();

  late final List<Widget> childPage;

  //static const List<String> titles = ['Dashboard', 'Workspaces', "Setting"];

  @override
  void initState() {
    childPage = [
      PopularMovieScreen(scrollController: popularMovieController),
      FavouriteScreen()
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, _) {
        if (orientation != _) {
          MediaQuery.of(context).orientation == Orientation.landscape
              ? SystemChrome.setEnabledSystemUIOverlays(
                  [SystemUiOverlay.bottom])
              : SystemChrome.setEnabledSystemUIOverlays(
                  [SystemUiOverlay.bottom, SystemUiOverlay.top]);
          orientation = _;
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,

          body: Stack(
            fit: StackFit.expand,
            children: [
              NotificationListener<UserScrollNotification>(
                //onNotification: handleScrollActivityDetected,
                child: PageView(
                  controller: pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: childPage,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildBottomNavi(context),
                ],
              ),
            ],
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        );
      },
    );
  }

  Container _buildBottomNavi(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          gradient: LinearGradient(stops: const [
        0,
        0.4,
        1
      ], colors: [
        Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
        Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
        Theme.of(context).scaffoldBackgroundColor
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        currentIndex: index,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.film), label: "popular movies"),
          BottomNavigationBarItem(
              icon: const Icon(CupertinoIcons.star),
              activeIcon: const Icon(CupertinoIcons.star_fill),
              label: "my favourites"),
        ],
        onTap: (_) {
          if (_ == index && index == 0)
            popularMovieController.animateTo(0,
                duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          else if (_ == index) return;

          setState(() {
            index = _;
            pageController.jumpToPage(_);
            //if ((_ - index).abs() > 1) {
            //  index = _;
            //  pageController.jumpToPage(_);
            //} else {
            //  index = _;
            //  pageController.animateToPage(_,
            //      duration: const Duration(milliseconds: 400),
            //      curve: Curves.easeOut);
            //}
          });
        },
      ),
    );
  }
}
