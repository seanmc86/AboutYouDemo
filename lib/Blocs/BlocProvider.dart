import 'package:flutter/material.dart';

Type _typeOf<T>() => T;

// ### Force all our Blocs to implement this so that dispose is ensured
abstract class BlocBase {
  void dispose();
}

// ### Need to use Stateful to get access to dispose, to clean up resources
class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }): super(key: key);

  final Widget child;
  final T bloc;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  // ### ancestorInheritedElementForWidgetOfExactType is O(1), while ancestorWidgetOfExactType is O(n)
  // This means this method will be more effective in long run as our widget tree grows
  static T of<T extends BlocBase>(BuildContext context){
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider = 
            context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>>{
  @override
  void dispose(){
    widget.bloc?.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context){
    return _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}