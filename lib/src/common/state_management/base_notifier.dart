import 'package:flutter/foundation.dart'
    show
        ChangeNotifier,
        describeIdentity,
        kFlutterMemoryAllocationsEnabled,
        mustCallSuper,
        protected;

class BaseNotifier<S extends Object?> extends ChangeNotifier {
  BaseNotifier(S state) : _state = state {
    if (kFlutterMemoryAllocationsEnabled) {
      ChangeNotifier.maybeDispatchObjectCreation(this);
    }
  }

  S _state;

  S get state => _state;

  @protected
  @mustCallSuper
  void setState(S newState, {bool forced = false, bool notify = true}) {
    if (_state == newState && !forced) return;
    _state = newState;
    if (notify) super.notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($_state)';

  @override
  @protected
  @Deprecated('Use setState instead of notifyListeners')
  void notifyListeners() {
    super.notifyListeners();
  }
}
