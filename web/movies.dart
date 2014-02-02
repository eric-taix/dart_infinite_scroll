import 'dart:html';
import 'dart:async';

import 'package:polymer/polymer.dart';


@CustomTag('jared-movies')
class Movies extends PolymerElement {
  
  static const int PAGE_SIZE = 20;
  
  @observable bool loading = false;
  @observable bool hasMore = true;
  int _lastItems = 0;

  
  List<String> movies = toObservable([]);
  
  Movies.created() : super.created() {
    _addNextItem();
  }
  
  _addNextItem() {
    loading = true;
    new Timer(new Duration(milliseconds: 400), () {
      movies.addAll(new List.generate(PAGE_SIZE, (i) => 'Line #${movies.length + i + 1}')); 
      loading = false;
      if (movies.length >= 500) {
        hasMore = false;
      }
    });
  }
  
  loadNextLines(Event e, var detail, Element target) {
    _addNextItem();
    _lastItems = movies.length-1;
  }

}