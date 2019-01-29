import 'dart:async';

import 'package:mafia_app/store/main_store_event.dart';
import 'package:rxdart/subjects.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MainStore {
  IO.Socket _socket;
  final Subject<MainStoreEvent> _subject = new PublishSubject<MainStoreEvent>();

  _init() {
    if (_socket == null) {
      // TODO
      _socket = IO.io('http://localhost:9092', <String, dynamic>{
        'transports': ['websocket']
      });
      _socket.on('connect', (_) {
        _subject.add(MainStoreEvent(MainStoreEvent.CONNECTED));
      });
    }
  }

  StreamSubscription<MainStoreEvent> subscribe(void callback(MainStoreEvent event)) {
    StreamSubscription<MainStoreEvent> subscription = _subject.listen(callback);
    _init();
    return subscription;
  }

  disconnect() {
    if (_socket?.connected == true) {
      _socket.disconnect();
    }
  }
}

MainStore mainStore = MainStore();