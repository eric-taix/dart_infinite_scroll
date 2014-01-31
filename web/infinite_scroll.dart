import 'dart:html';

import 'package:polymer/polymer.dart';


@CustomTag('jared-infinitescroll')
class InfiniteScroll extends PolymerElement {
  
  Element _scroller;
  Element _loader;
  @published double loadDistance = 0.0;
  
  InfiniteScroll.created() : super.created() {
    _scroller = $['scroller'];
    _loader = $['loader'];
    print(_loader);
    _loader.style.visibility = 'hidden';
    _scroller.onScroll.listen(_onScroll);
  }
  
  _onScroll(Event evt) {
    int y = _scroller.scrollTop + _scroller.clientHeight;
    int distance = _scroller.scrollHeight - y;
    if (distance <= loadDistance) {
      _loader.style.visibility = 'visible';
   //   dispatchEvent(new CustomEvent('load'));
    }
    else {
      _loader.style.visibility = 'hidden';
    }
    print('DIST=$distance ${_scroller.clientHeight} ${_scroller.offsetHeight} ${_scroller.scrollTop} ${_scroller.scrollHeight}');
  }
}