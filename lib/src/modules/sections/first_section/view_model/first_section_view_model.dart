import 'package:stacked/stacked.dart';

class FirstSectionViewModel extends BaseViewModel {
  bool isHovering = true;

  void changeHoverState(bool value) {
    isHovering = value;
    notifyListeners();
  }

  void offHoverStateDelayed() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        isHovering = false;
        notifyListeners();
      },
    );
  }
}
