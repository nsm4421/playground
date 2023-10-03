abstract class ViewModuleEvent {
  const ViewModuleEvent();
}

class ViewModuleInitialized extends ViewModuleEvent {
  final int tabId;

  ViewModuleInitialized(this.tabId);
}
