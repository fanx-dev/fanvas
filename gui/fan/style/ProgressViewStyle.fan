//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

@Js
class ProgressViewStyle : WidgetStyle {
  override Void doPaint(Widget widget, Graphics g) {
    ProgressView p := widget
    Int w := widget.contentWidth
    Int h := widget.contentHeight
    top := widget.paddingTop
    left := widget.paddingLeft

    width := dpToPixel(10f)
    g.brush = outlineColor
    g.pen = Pen { it.width = width }

    Int i := p.proVal.toInt
    for (; i<=360; i+=30) {
      g.drawArc(top, left, w, h, i, 5)
    }

    p.proVal += 1.0
    if (p.proVal > 30f) {
      p.proVal -= 30f
    }
  }
}