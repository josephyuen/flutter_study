import 'package:flutter/material.dart';
import 'package:flutter_study/common/style/GSYStyle.dart';

/// 带图标的输入框
class GSYInputWidget extends StatefulWidget {
  final bool obscureText;

  final String hintText;

  final IconData iconData;

  final ValueChanged<String> onChanged;

  final TextStyle textStyle;

  final int maxlength;

  final TextEditingController controller;

  GSYInputWidget({Key key, this.hintText, this.iconData, this.onChanged,this.maxlength:12, this.textStyle, this.controller, this.obscureText = false}) : super(key: key);

  @override
  _GSYInputWidgetState createState() => new _GSYInputWidgetState();
}

/// State for [GSYInputWidget] widgets.
class _GSYInputWidgetState extends State<GSYInputWidget> {

  _GSYInputWidgetState() : super();

  @override
  Widget build(BuildContext context) {
    return new TextField(
      cursorColor: Theme.of(context).primaryColor,
      controller: widget.controller,
      onChanged: widget.onChanged,
      cursorRadius: new Radius.circular(2.0),
      obscureText: widget.obscureText,
      maxLength: widget.maxlength,
      decoration: new InputDecoration(
        labelText: widget.hintText,
        icon: widget.iconData == null ? null : new Icon(widget.iconData),
      ),
    );
  }
}
