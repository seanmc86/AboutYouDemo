import 'package:AboutYouDemo/Styles/Constants.dart';
import 'package:AboutYouDemo/Styles/Dimensions.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  SubmitButton({@required this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: Dimensions.stylePaddingM),
                                        child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: FlatButton(
                                              child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  child: Text(
                                                    title,
                                                    textAlign: TextAlign.center,
                                                  )),
                                              color: Constants.materialBlack,
                                              splashColor:
                                                  Constants.materialWhite,
                                              textColor: Constants
                                                  .mColorThemePrimary[50],
                                              onPressed: onPressed
                                            ))));
  }

}