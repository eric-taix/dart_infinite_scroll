import 'dart:html';
import 'dart:async';

import 'package:polymer/polymer.dart';


@CustomTag('x-scroller')
class InfiniteScroll extends PolymerElement {
  
  Element _scroller;
  Element _loader;
  @published String text = "Loading...";
  @published String image = "./img/loading.gif";
  
  /// The distance in pixel before the next load event is dispatched
  @published double distance = 0.0;
  /// True if the parent has more items to displayed. If false the load event would be dispatched anymore
  @published bool hasMore = false;
  /// When true the loader is visible otherwise it's hidden
  @published bool loading = false;
  
  InfiniteScroll.created() : super.created();
  
  void enteredView() {
    super.enteredView();
    _scroller = $['scroller'];
    _loader = $['loader'];
    if (_loader != null) {
      _loader.style.visibility = 'hidden';
    }
    _scroller.onScroll.listen(_onScroll);  
  }
  
  loadingChanged(bool oldValue) {
    if (loading) _loader.style.visibility = 'visible';
    else _loader.style.visibility = 'hidden';
  }
  
  _onScroll(Event evt) {
    int y = _scroller.scrollTop + _scroller.clientHeight;
    int dist = _scroller.scrollHeight - y;
    // Dispatch load event when at the desired distance and if it has more items 
    // and prevent dispatching the event if it's currently loading
    if (dist <= distance && hasMore && !loading) {
      //print('==> LD:${loadDistance} D:${distance}');
      dispatchEvent(new CustomEvent('load'));
    }
    //print('DIST=$dist CH:${_scroller.clientHeight} OH:${_scroller.offsetHeight} ST:${_scroller.scrollTop} SH:${_scroller.scrollHeight}');
  }
}

