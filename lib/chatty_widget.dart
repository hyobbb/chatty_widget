library chatty_widget;

import 'package:chatty_widget/chatbox_clipper.dart';
import 'package:chatty_widget/chatbox_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum BoxLocation {
  Top,
  Bottom,
}

class ChattyWidget extends StatefulWidget {
  final Widget child;

  //chat box location, default: Top
  final BoxLocation chatBoxLocation;

  //chat box show duration
  final Duration duration;

  //message in chat box
  final String text;

  //textStyle of message in chat box
  final TextStyle? textStyle;

  //color of chat box
  final Color? textBoxColor;

  //maximum chat box width
  final double chatBoxWidth;

  final double chatBoxTailSize;

  final double contentsPadding;

  //no stroke by default
  final double chatBoxStrokeWidth;

  final Color chatBoxStrokeColor;

  //additional callback function to execute on tap
  final VoidCallback? onTap;

  ChattyWidget({
    required this.child,
    this.chatBoxLocation = BoxLocation.Top,
    this.duration = const Duration(seconds: 3),
    required this.text,
    this.textStyle,
    this.textBoxColor = const Color(0xFFFFFFFF),
    this.chatBoxWidth = 200.0,
    this.chatBoxTailSize = 5.0,
    this.contentsPadding = 10.0,
    this.chatBoxStrokeWidth = 0.0,
    this.chatBoxStrokeColor = const Color(0xFF000000),
    this.onTap,
  });

  @override
  _ChattyWidgetState createState() => _ChattyWidgetState();
}

class _ChattyWidgetState extends State<ChattyWidget> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? overlayEntry;
  Alignment targetAnchor = Alignment.topCenter;
  Alignment followerAnchor = Alignment.bottomCenter;

  @override
  void initState() {
    if (widget.chatBoxLocation == BoxLocation.Top) {
      targetAnchor = Alignment.topCenter;
      followerAnchor = Alignment.bottomCenter;
    } else {
      targetAnchor = Alignment.bottomCenter;
      followerAnchor = Alignment.topCenter;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: InkWell(
        onTap: () async {
          if(widget.onTap != null){
            widget.onTap!();
          }

          _showValueIndicator();
          await Future.delayed(widget.duration);
          overlayEntry?.remove();
          overlayEntry = null;
        },
        child: widget.child,
      ),
    );
  }

  void _showValueIndicator() {
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(
        builder: (BuildContext context) {
          return Positioned(
              top: 0.0,
              left: 0.0,
              child: CompositedTransformFollower(
                link: _layerLink,
                followerAnchor: followerAnchor,
                targetAnchor: targetAnchor,
                child: Material(
                  type: MaterialType.transparency,
                  child: ClipPath(
                    clipper: ChatBoxClipper(
                        boxLocation: widget.chatBoxLocation,
                        tailSize: widget.chatBoxTailSize),
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.textBoxColor,
                      ),
                      constraints:
                          BoxConstraints(maxWidth: widget.chatBoxWidth),
                      alignment: Alignment.center,
                      child: CustomPaint(
                        painter: ChatBoxBorderPainter(
                            boxLocation: widget.chatBoxLocation,
                            tailSize: widget.chatBoxTailSize,
                            strokeWidth: widget.chatBoxStrokeWidth,
                            strokeColor: widget.chatBoxStrokeColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              widget.contentsPadding,
                              (widget.chatBoxLocation == BoxLocation.Top)
                                  ? widget.contentsPadding
                                  : widget.contentsPadding +
                                      widget.chatBoxTailSize,
                              widget.chatBoxTailSize,
                              (widget.chatBoxLocation == BoxLocation.Top)
                                  ? widget.contentsPadding +
                                      widget.chatBoxTailSize
                                  : widget.contentsPadding),
                          child: Text(widget.text, style: widget.textStyle),
                        ),
                      ),
                    ),
                  ),
                ),
              ));
        },
      );
      Overlay.of(context)?.insert(overlayEntry!);
    }
  }
}
