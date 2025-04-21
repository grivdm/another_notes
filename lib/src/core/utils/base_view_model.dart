import 'package:flutter/widgets.dart';

abstract class BaseViewModel<W extends Widget> extends ChangeNotifier {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  void initState(BuildContext context);

  void init(BuildContext context) {
    if (!_isInitialized) {
      initState(context);
      _isInitialized = true;
    }
    if (context.widget is W) _widget = context.widget as W;
    _context = context;
  }

  W? _widget;
  W? get widget => _widget;

  BuildContext? _context;
  BuildContext? get context => _context;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
