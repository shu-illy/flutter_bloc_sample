import 'dart:async';

class CounterBloc {
  // フィールド
  final _actionController = StreamController<void>();
  Sink<void> get increment => _actionController.sink;

  final _countController = StreamController<int>();
  Stream<int> get count => _countController.stream;

  int _count = 0;

  // コンストラクタ
  CounterBloc() {
    _actionController.stream.listen((_) {
      _count++;
      _countController.sink.add(_count);
    });
  }

  // メソッド
  void dispose() {
    _actionController.close();
    _countController.close();
  }
}
