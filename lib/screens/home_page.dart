import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elwarshatask/Model/upComing_model.dart';
import 'package:elwarshatask/bloc/upcoming_bloc.dart';
import 'package:elwarshatask/constant/gradient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../searshdelagat.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _imageURL = 'https://image.tmdb.org/t/p/w500';

  HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = HomeBloc();
    bloc.fetchAllUpcoming();
    bloc.fetchAllPopular();
    bloc.fetchAllTopRated();
    bloc.fetchTrendingWeek();
    bloc.fetchPopularTv();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7FB),
      resizeToAvoidBottomPadding: false,
      body: ListView(
        // padding: const EdgeInsets.all(0.0),
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(0),
                height: 325,
                child: Stack(
                  // fit: StackFit.loose,
                  children: <Widget>[
                    Positioned(
                      top: -90,
                      left: -60,
                      bottom: 50,
                      right: 120,
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: pinkgradient, shape: BoxShape.circle),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      // left: 0,
                      // bottom: 0,
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, gradient: yellowgradient),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      right: 20,
                      left: 100,
                      // bottom: 10,
                      child: Container(
                        padding: EdgeInsets.all(0),
                        height: 53.0,
                        width: 80.0,
                        child: InkWell(
                          child: Card(
                            elevation: 18.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    // enabled: false,
                                    onTap: () {
                                      // ! search delagate here
                                      showSearch(
                                          context: context,
                                          delegate: UserSearchDelegate());
                                      print(null);
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                      hintText:
                                          "Serach for any Movie or TV Show..",
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {},
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ! using streem Builder
                    Positioned(
                      top: 100,
                      right: 5,
                      bottom: 100,
                      left: 100,
                      child: Container(
                        child: StreamBuilder(
                          /////////////////////upComingMovies
                          stream: bloc.allUpComing,
                          builder: (context, snapshot) {
                            MoviesModel movies = snapshot
                                .data; ////////////////////////////////////////
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                                return Center(
                                  child: Text(" no connections"),
                                );
                              case ConnectionState.waiting:
                                return Center(
                                  child: SpinKitThreeBounce(
                                    size: 30.0,
                                    itemBuilder: (context, index) {
                                      return DecoratedBox(
                                          decoration: BoxDecoration(
                                              gradient:
                                                  greyGradintForNotloading,
                                              shape: BoxShape.circle));
                                    },
                                  ),
                                );

                              default:
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error ${snapshot.error}"),
                                  );
                                } else {
                                  movies = snapshot.data;
                                  return ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: movies.results.length,
                                    itemBuilder: (context, int index) {
                                      Movie movie = movies.results[index];
                                      return Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: InkWell(
                                          child: Hero(
                                            tag: movie.backdroPath,
                                            child: Container(
                                              height: 1,
                                              width: 225,
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: CachedNetworkImage(
                                                  imageUrl: movie.backdroPath !=
                                                          null
                                                      ? _imageURL +
                                                          movie.backdroPath
                                                      : 'https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg',
                                                  fit: BoxFit.cover,
                                                  alignment: Alignment.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (c, a1, a2) =>
                                                    DetailsPage(
                                                  image: movie.backdroPath,
                                                  movie: movies.results[index],
                                                ),
                                                transitionsBuilder:
                                                    (c, anim, a2, child) =>
                                                        FadeTransition(
                                                            opacity: anim,
                                                            child: child),
                                                transitionDuration: Duration(
                                                    milliseconds: 1000),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  );
                                }
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              Padding(
                padding: EdgeInsets.only(top: 0, left: 20, bottom: 0),
                child: Text(
                  "Trending This Week",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              /////////////////////
              Padding(
                padding: EdgeInsets.only(top: 1, left: 20),
                child: Divider(
                  color: Colors.pinkAccent,
                  thickness: 3,
                  height: 4,
                  endIndent: 180,
                ),
              ),
              ////////////////////////
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SizedBox(
                  height: 260,
                  child: StreamBuilder(
                    stream: bloc.trendingWeek,
                    builder: (context, snapshot) {
                      MoviesModel movies = snapshot.data; ///////////////////

                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: Text("No internet"),
                          );
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitThreeBounce(
                                size: 24.0,
                                itemBuilder: (context, index) {
                                  return DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: greyGradintForNotloading,
                                          shape: BoxShape.circle));
                                }),
                          );
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error ${snapshot.error}"),
                            );
                          } else {
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: movies.results.length,
                              itemBuilder: (context, int index) {
                                List<Movie> movie = movies
                                    .results; ///////////////////////////////
                                return ClipRect(
                                  clipBehavior: Clip.antiAlias,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: 180,
                                          width: 128,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(11),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 5,
                                                  color: Colors.black38,
                                                  offset: Offset(0, 2))
                                            ],
                                          ),
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: CachedNetworkImage(
                                              imageUrl: movie[index]
                                                          .posterPath !=
                                                      null
                                                  ? _imageURL +
                                                      movie[index].posterPath
                                                  : 'https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg',
                                              fit: BoxFit.cover,
                                              // alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),

                                        SizedBox(
                                          width: 100,
                                          height: 50,
                                          child: Text(
                                            "${movie[index].titel}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),

                                        //        Container(
                                        //          width: 150,
                                        //          height: 50,
                                        //  child: Column(
                                        //    mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                        //    children: <Widget>[
                                        //       Flexible(
                                        //          child:  Text("${movie[index].titel}",))
                                        //           ],
                                        //   ))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                      }
                    },
                  ),
                ),
              ),
              ////////////////////////////////////////////////////////////////////////////////////

              Padding(
                padding: EdgeInsets.only(left: 20, top: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Top Rated Movies",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                  ],
                ),
              ),
              ////////////////////////////
              Padding(
                  padding: EdgeInsets.only(top: 0, left: 20),
                  child: Divider(
                    color: Colors.pinkAccent,
                    thickness: 3,
                    height: 4,
                    endIndent: 180,
                  )),
              ////////////////////////////////////////////////////////////////
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 5),
                child: SizedBox(
                  height: 250,
                  child: StreamBuilder(
                    stream: bloc.allTopRated,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: Text("no internet"),
                          );
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitThreeBounce(
                                size: 24.0,
                                itemBuilder: (context, index) {
                                  return DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: greyGradintForNotloading,
                                          shape: BoxShape.circle));
                                }),
                          );

                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error ${snapshot.error}"),
                            );
                          } else {
                            MoviesModel topMovies = snapshot.data;
                            return ListView.builder(
                              // shrinkWrap: true
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: topMovies.results.length,
                              itemBuilder: (context, int index) {
                                List<Movie> topMovie = topMovies.results;
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: ClipRect(
                                    // clipBehavior: Clip.hardEdge,
                                    child: Column(
                                      children: <Widget>[
                                        Stack(children: <Widget>[
                                          Container(
                                            height: 190,
                                            width: 300,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5,
                                                    color: Colors.grey)
                                              ],
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.grey[200]),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: topMovie[index]
                                                          .posterPath !=
                                                      null
                                                  ? _imageURL +
                                                      topMovie[index].posterPath
                                                  : 'https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg',
                                              fit: BoxFit.cover,
                                              // alignment: Alignment.center,
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 5, sigmaY: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade400
                                                        .withOpacity(0.1)),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 8,
                                            left: 10,
                                            child: Container(
                                              height: 175,
                                              width: 130,
                                              child: Card(
                                                clipBehavior: Clip.antiAlias,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(15),
                                                    ),
                                                    side: BorderSide(
                                                        width: 2.0,
                                                        color: Colors.white10)),
                                                margin: EdgeInsets.all(0),
                                                elevation: 20,
                                                child: CachedNetworkImage(
                                                  imageUrl: topMovie[index]
                                                              .posterPath !=
                                                          null
                                                      ? _imageURL +
                                                          topMovie[index]
                                                              .posterPath
                                                      : 'https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg',
                                                  fit: BoxFit.cover,
                                                  // alignment: Alignment.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 30,
                                            right: 30,
                                            child: SizedBox(
                                              width: 100,
                                              height: 50,
                                              child: Text(
                                                "${topMovie[index].titel}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 100,
                                            right: 105,
                                            child: Container(
                                              height: 18,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  gradient: pinkgradient,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                "   7.7 ☆",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 100,
                                            right: 10,
                                            child: Container(
                                              height: 18,
                                              width: 85,
                                              decoration: BoxDecoration(
                                                  gradient: pinkgradient,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                " 2019-06-28 ",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ]),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                      }
                    },
                  ),
                ),
              ),

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              Padding(
                padding: EdgeInsets.only(top: 0, left: 20, bottom: 0),
                child: Text(
                  "Popular TV Shows",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              /////////////////////
              Padding(
                padding: EdgeInsets.only(top: 1, left: 20),
                child: Divider(
                  color: Colors.pinkAccent,
                  thickness: 3,
                  height: 4,
                  endIndent: 180,
                ),
              ),
              ////////////////////////
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SizedBox(
                  height: 260,
                  child: StreamBuilder(
                    stream: bloc.popularTv,
                    builder: (context, snapshot) {
                      MoviesModel movies = snapshot.data;

                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: Text("No internet"),
                          );
                        case ConnectionState.waiting:
                          return Center(
                            child: SpinKitThreeBounce(
                                size: 24.0,
                                itemBuilder: (context, index) {
                                  return DecoratedBox(
                                      decoration: BoxDecoration(
                                          gradient: greyGradintForNotloading,
                                          shape: BoxShape.circle));
                                }),
                          );
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error ${snapshot.error}"),
                            );
                          } else {
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: movies.results.length,
                              itemBuilder: (context, int index) {
                                List<Movie> moive = movies.results;

                                return ClipRect(
                                  clipBehavior: Clip.antiAlias,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: 180,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 5,
                                                    color: Colors.black38,
                                                    offset: Offset(0, 2))
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(11)),
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: CachedNetworkImage(
                                              imageUrl: moive[index]
                                                          .posterPath !=
                                                      null
                                                  ? _imageURL +
                                                      moive[index].posterPath
                                                  : 'https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg',
                                              fit: BoxFit.cover,
                                              // alignment: Alignment.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: 100,
                                          height: 50,
                                          child: Text(
                                            "${moive[index].originalName}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                      }
                    },
                  ),
                ),
              ),
//////////////////////////////////////////////////////////////////////////////////////////////////////////
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black87,
        icon: Icon(Icons.home),
        tooltip: ' Home ',
        label: Text(" Home "),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 12,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.movie,
                color: Colors.blue,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.live_tv,
                color: Colors.redAccent,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
