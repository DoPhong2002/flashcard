import 'dart:async';
import 'dart:ui';

class IndexStream {
  static final _stream = IndexStream._internal();

  factory IndexStream() => _stream;

  IndexStream._internal();

  final _setOffsetStream = StreamController<Offset>.broadcast();

  Stream<Offset> get setOffsetStream => _setOffsetStream.stream;

  var offset = const Offset(0.5, 0);

  void offsetPrevious() {
    offset = const Offset(-1, 0);
    _setOffsetStream.add(offset);
  }

  void offsetNext() {
    offset = const Offset(1, 0);
    _setOffsetStream.add(offset);
  }
}

final offsetStream = IndexStream();
