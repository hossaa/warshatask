import 'dart:ui';

import 'package:flutter/material.dart';
import 'Model/upComing_model.dart';
import 'bloc/upcoming_bloc.dart';
import 'screens/details_search.dart';

class UserSearchDelegate extends SearchDelegate {
  UserSearchDelegate() {
    // ! to Fetch data first
    bloc.fetchAllTopRated();
  }

  MoviesModel movies;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.length < 2) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than one letters.",
            ),
          )
        ],
      );
    }
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // final sugestList=query.isEmpty?movies:movies
    return StreamBuilder(
      stream: bloc.allTopRated,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Center(
              child: Text("no internet"),
            );
          case ConnectionState.waiting:
            return Center(child: Container());

          default:
            if (snapshot.hasError) {
              return Center(
                child: Text("Error ${snapshot.error}"),
              );
            } else {
              MoviesModel topMovies = snapshot.data;
              List<Movie> topMovie = topMovies.results;
              final resuit =
                  topMovie.where((a) => a.titel.toLowerCase().contains(query));
              return ListView(
                children: resuit
                    .map<ListTile>((a) => ListTile(
                          title: RichText(
                            text: TextSpan(
                                text: a.titel.substring(0, query.length),
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                                children: [
                                  TextSpan(
                                    text: a.titel.substring(query.length),
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 17),
                                  )
                                ]),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (c, a1, a2) => DetailsSearch(
                                  allData: a,
                                ),
                                transitionsBuilder: (c, anim, a2, child) =>
                                    FadeTransition(opacity: anim, child: child),
                                transitionDuration: Duration(milliseconds: 700),
                              ),
                            );
                          },
                        ))
                    .toList(),
              );
            }
        }
      },
    );
  }
}
