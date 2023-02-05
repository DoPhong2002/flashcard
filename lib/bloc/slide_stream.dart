import 'dart:async';

class SlideStream {
  static final _stream = SlideStream._internal();

  factory SlideStream() => _stream;

  SlideStream._internal();

  /// index
  final _indexStream = StreamController<int>.broadcast();

  Stream<int> get indexStream => _indexStream.stream;

  int activeIndex = 0;

  void getIndex(int index) {
    activeIndex = index;
    _indexStream.add(activeIndex);
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
