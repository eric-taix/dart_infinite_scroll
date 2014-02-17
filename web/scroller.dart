import 'dart:html';
import 'dart:async';

import 'package:polymer/polymer.dart';

@CustomTag('x-scroller')
class Scroller extends PolymerElement {
  
  Element _scroller;
  Element _loader;
  Element _dataView;
  
  /// The distance in pixel before the next load event is dispatched
  @published int distance = 0;
  /// True if the parent has more items to displayed. If false the load event would be dispatched anymore
  @published bool hasMore = false;
  /// When true the loader is visible otherwise it's hidden
  @published bool loading = false;
  
  Scroller.created() : super.created();
  
  void enteredView() {
    super.enteredView();
    _scroller = $['scroller'];
    _loader = $['loader'];
    if (_loader != null) {
      _loader.style.visibility = 'hidden';
    }
    _scroller.onScroll.listen(_onScroll);  
    _dataView = children.firstWhere((e) => e.id == 'data-view');
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
      dispatchEvent(new CustomEvent('load'));
    }
    _dataView.children.where((e) => e is ScrollAware).forEach(_fireScroll);
  }
  
  _fireScroll(sa) => sa.scrolling(_scroller.scrollTop, _scroller.scrollTop+_scroller.clientHeight);
}


abstract class ScrollAware {
  
  scrolling(int scrollTop, int scrollBottom);

}
