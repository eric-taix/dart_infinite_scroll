import 'dart:html';
import 'dart:async';
import 'dart:math';

import 'package:polymer/polymer.dart';
import 'package:polymer_expressions/filter.dart';

@CustomTag('x-app')
class Application extends PolymerElement {
  
  static const int PAGE_SIZE = 20;
  
  @observable bool loading = false;
  @observable bool hasMore = true;
  @observable int distance = 1000;
  @observable String loadingview = "progressbar";
  int _lastItems = 0;

  
  List<String> lines = toObservable([]);
  
  Application.created() : super.created() {
    _addNextItem();
  }
  
  var asInt  = new StringToInt();
  
  Timer _loadingMockTimer;
  var rnd = new Random();
  _addNextItem() {
    loading = true;
    if (_loadingMockTimer != null) _loadingMockTimer.cancel();
    _loadingMockTimer = new Timer(new Duration(milliseconds: rnd.nextInt(1200) + 300), () {
      lines.addAll(new List.generate(PAGE_SIZE, (i) => 'Line #${lines.length + i + 1}')); 
      loading = false;
      if (lines.length >= 500) {
        hasMore = false;
      }
    });
  }
  
  loadNextLines(Event e, var detail, Element target) {
    _addNextItem();
    _lastItems = lines.length-1;
  }

  resetItems(Event e, var detail, Element target) {
    _lastItems = 0;
    lines.clear();
    _addNextItem();
  }
  
  changeLoadingView(Event e, var detail, Element target) {
    loadingview = target.dataset['loadingview'];
    resetItems(e, detail, target);
    applySelected(target, "item");
  }
}

applySelected(Element target, String prefix) {
  String classname = "${prefix}-selected";
  if (!target.classes.contains(classname)) {
    target.parent.children.forEach((e) => e.classes.remove(classname));
    target.classes.add(classname);
  }
}

class StringToInt extends Transformer<String, int> {
  String forward(int i) => '$i';
  int reverse(String s) => int.parse(s);
}