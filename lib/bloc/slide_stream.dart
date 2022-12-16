import 'dart:async';
import 'dart:ui';

class SlideStream {
  static final _stream = SlideStream._internal();

  factory SlideStream() => _stream;

  SlideStream._internal();
/// index
  final _indexStream = StreamController<int>.broadcast();

  Stream<int> get indexStream => _indexStream.stream;
/// offset
  final _setOffsetStream = StreamController<Offset>.broadcast();

  Stream<Offset> get setOffsetStream => _setOffsetStream.stream;
 ///
  var offset = const Offset(0.5, 0);

  int activeIndex = 0;

  void getIndex(int index) {
    activeIndex = index;
    _indexStream.add(activeIndex);
  }
  void offsetPrevious() {
    offset = const Offset(-1, 0);
    _setOffsetStream.add(offset);
  }
  void offsetNext() {
    offset = const Offset(1, 0);
    _setOffsetStream.add(offset);
  }

  void previous() {
    activeIndex -= 1;
    _indexStream.add(activeIndex);
  }

  void next() {
    activeIndex += 1;
    _indexStream.add(activeIndex);
  }
}
final slideBloc = SlideStream();