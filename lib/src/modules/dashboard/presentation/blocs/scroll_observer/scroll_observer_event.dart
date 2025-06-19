import 'package:sidharth/src/common/model/delegate/freezed_widget_delegate.dart';

class ScrollObserverEvent {
  const ScrollObserverEvent();
}

class UpdateScrollMetrics extends ScrollObserverEvent {
  const UpdateScrollMetrics(this.position);

  final double position;
}

class SetCurrentDelegate extends ScrollObserverEvent {
  const SetCurrentDelegate({
    required this.lerp,
    required this.index,
    required this.delegate,
  });

  final int index;
  final double lerp;
  final FreezedWidgetDelegate delegate;
}
