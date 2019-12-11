import 'package:flutter/material.dart';
import 'upcoming_bloc.dart';

class UpComingProvider extends InheritedWidget {
  final HomeBloc bloc;
  final Widget child;

  UpComingProvider({Key key, this.bloc, this.child})
      : super(key: key, child: child);

@override
  bool updateShouldNotify(UpComingProvider oldWidget) {
    return true;
  }
  static UpComingProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(UpComingProvider)
        as UpComingProvider);
  }
}
