import 'package:polymer/polymer.dart';
import 'scroller.dart';
import 'dart:html';

@CustomTag('x-card')
class Card extends PolymerElement implements ScrollAware {
  
  Element _container;
  Element _content;
  bool visible = false;
  
  Card.created() : super.created();
    
  enteredView() {
    super.enteredView();
    _container = $['container'];
    _content = $['content'];
  }

  scrolling(int scrollTop, int scrollBottom) {
    int t = 0;
    bool partial = true;

    int top = _container.offset.top;
    int bottom = _container.offset.bottom;
    int compareTop = partial ? bottom : top;
    int compareBottom  = partial ? top : bottom;  
    bool vis = (compareTop >= scrollTop && compareBottom <= scrollBottom);
    if (vis != visible) {
      visible = vis;
    }
  }
}