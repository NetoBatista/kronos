abstract class IStateSharedState {
  bool isLoading = false;
  String error = '';
  String info = '';

  void stateIsLoading();
}

class StateSharedState extends IStateSharedState {
  @override
  void stateIsLoading() {
    isLoading = true;
    error = '';
    info = '';
  }
}
