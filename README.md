dart_infinite_scroll
====================

This is an experiment of an infinite scroller with Dart and Polymer.
  
This demo provides 3 loading views: click on the corresponding menu to change the view used when new lines are loaded.  
  
A online demonstration can be seen [here](./user-story-2-1.md)  
  
**Warning**: when new lines are added all elements are refreshed which is, in term of performance, very bad ! 
I think this is due to the `template repeat` polyfill implementation. If you any idea how to solve this issue, please contribute to this experiment and send a push request
