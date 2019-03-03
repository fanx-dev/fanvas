//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow
using concurrent
using fanvasMath

@Js
class DrawTextTest
{
  Void main()
  {
    view := DrawTextTestView()
    win := Toolkit.cur.build()
    win.add(view)

    win.show()
  }
}

@Js
class DrawTextTestView : View
{
  override NativeView? host

  new make()
  {
    Graphics g := p.graphics

    g.brush = Color.yellow
    g.fillRect(10,10,300,300)

    g.brush = Color.red
    g.fillRect(0,0,10,10)

    g.brush = Color.black
    //g.font = Font(12)
    x := 50
    y := 10
    g.drawText("Hello \nWorld", x, y)

    trans := Transform2D().rotate(0f, 0f, 0.5f)
    g.transform(trans)
    g.drawText("Hello \nWorld", x, y)

    trans = Transform2D().rotate(x.toFloat, y.toFloat, 0.5f)
    g.transform(trans)
    g.drawText("Hello \nWorld", x, y)

    g.dispose
  }

  BufImage? p := BufImage(Size(310,310))

  override Void onPaint(Graphics g) {
    g.drawImage(p, 10, 10)
  }
}

