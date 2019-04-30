import 'package:flutter/material.dart';

/**
 * Creator: joseph
 * Date: 2019-04-30 11:02
 * FuncDesc:
 * copyright  ©2019-2030 Technology Corporation. All rights reserved.
 */

class ClickEffectImage extends StatelessWidget{

  final String assetsImgPath;
  final Function() onClick;
  final double width;
  final double height;

  ClickEffectImage({Key key,this.assetsImgPath,this.onClick,this.width,this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink.image(
        image: AssetImage(assetsImgPath),
        fit: BoxFit.fitWidth,
        width: width,
        height: height,
        alignment: Alignment.center,
        child: InkWell(
          onTap: onClick,
        ),

      ),
    );
  }




}