import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsPage extends StatefulWidget {
  final movie;
  final String image;
  DetailsPage({Key key, this.movie, this.image}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DetailsPageState();
  }
}

class DetailsPageState extends State<DetailsPage> {
  final _imageURL = 'https://image.tmdb.org/t/p/w500';

  // @override
  // void initState() {
  //   super.initState();
  //   bloc.fetchMovieGener(widget.movie.id);
  // }

  // @override
  // void dispose() {
  //   super.dispose();

  //   bloc.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Container(
        padding: EdgeInsets.all(0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: widget.movie.posterPath != null
                  ? _imageURL + widget.movie.posterPath
                  : 'https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                  // decoration: BoxDecoration(color: Colors.grey.withOpacity(0.2)),
                ),
              ),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Stack(
                        fit: StackFit.loose,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(0),
                            child: Hero(
                              tag: widget.image,
                              child: Container(
                                height: 370,
                                width: 350,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black,
                                        blurRadius: 20,
                                        offset: Offset(0.0, 14.0))
                                  ],
                                ),
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.movie.posterPath != null
                                        ? _imageURL + widget.movie.posterPath
                                        : 'https://image.freepik.com/free-vector/404-error-concept-with-camel-and-cactus_23-2147736339.jpg',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 45,
                            left: 10,
                            child: Text(
                              "☆☆☆☆",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 15,
                              left: 15,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.imdb,
                                    color: Colors.yellow,
                                  ),
                                  Text(" ${widget.movie.voteAvrage}/10 ",
                                      style: TextStyle(color: Colors.white))
                                ],
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        child: Text(
                          "${widget.movie.titel}",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 24),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 25.0, bottom: 10.0),
                      child: Divider(
                        height: 4,
                        thickness: 3,
                        endIndent: 155,
                        color: Colors.yellow,
                      ),
                    ),
                    Text(
                      "${widget.movie.overView}",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Cast",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w800),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Divider(
                        height: 4,
                        thickness: 3,
                        endIndent: 155,
                        color: Colors.yellow,
                      ),
                    ),
                    Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width - 30,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 8,
                                  itemBuilder: (context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            height: 90,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                // borderRadius: BorderRadius.all(Radius.circular(35)),
                                                color: Colors.red,
                                                shape: BoxShape.circle),
                                          ),
                                          SizedBox(
                                            height: 15,
                                            width: 10,
                                          ),
                                          Text(
                                            "Actor",
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.justify,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ])),
                    SizedBox(
                      height: 18,
                    ),
                    Text(
                      "Similar Movies",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w800),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Divider(
                        height: 4,
                        thickness: 3,
                        endIndent: 155,
                        color: Colors.yellow,
                      ),
                    ),
                    Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width - 30,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 8,
                                  itemBuilder: (context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            height: 100,
                                            width: 90,
                                            decoration: BoxDecoration(
                                                // borderRadius: BorderRadius.all(Radius.circular(35)),
                                                color: Colors.red,
                                                shape: BoxShape.rectangle),
                                          ),
                                          SizedBox(
                                            height: 15,
                                            width: 10,
                                          ),
                                          Text(
                                            "Actor",
                                            style:
                                                TextStyle(color: Colors.white),
                                            textAlign: TextAlign.justify,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ]))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        label: Text(
          "Trailer",
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          FontAwesomeIcons.youtube,
          color: Colors.red,
        ),
        onPressed: () {},
      ),
    );
  }
}
