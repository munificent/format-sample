import 'dart:async';

/// Этот миксин позволяет сделать реактивный репозиторий
mixin ReactRepositoryMixin<StreamEvent> {
  late final Stream<StreamEvent> stream = _streamController.stream.asBroadcastStream();
  late final StreamController<StreamEvent> _streamController = StreamController<StreamEvent>();

  /// Через этот метод, выполнять все запросы к Api
  ///
  /// Если передать [streamEvent], то после выполнения запроса, в поток будет прокинут event.
  Future<ResponseType> sendRequest<ResponseType>(
    Future<ResponseType> Function() request, {
    StreamEvent? streamEvent,
  }) async {
    final response = await request();
    if (streamEvent != null) {
      _streamController.sink.add(streamEvent);
      // _clearHashResponses();
    }
    return response;
  }

  /// Ручное обновление репозитория
  void notifityListeners(StreamEvent event) {
    _streamController.add(event);
  }
}
