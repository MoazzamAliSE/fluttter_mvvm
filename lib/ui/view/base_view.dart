import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mvvm/locator.dart';
import 'package:flutter_mvvm/viewmodel/base_viewmodel.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget? widget) builder;

  final Function(T)? onModelReady;
  final Function(T)? onModelDestroy;

  const BaseView({
    Key? key,
    required this.builder,
    this.onModelReady,
    this.onModelDestroy,
  }) : super(key: key);
  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
  // @override
  // State<BaseView> createState() => _BaseViewState();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  T model = locator<T>();
  @override
  void initState() {
    widget.onModelReady?.call(model);
    super.initState();
  }

  @override
  void dispose() {
    widget.onModelDestroy?.call(model);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
