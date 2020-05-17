//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-7-7  Jed Young  Creation
//

using vaseGraphics
using concurrent

**
** root view
**
@Js
mixin View
{
  **
  ** do paint at here
  **
  virtual Void onPaint(Graphics g) {}

  virtual Void onMotionEvent(MotionEvent e) {}

  virtual Void onKeyEvent(KeyEvent e) {}

  virtual Void onWindowEvent(WindowEvent e) {}

  //virtual Void onResize(Int w, Int h) {}

  virtual Bool onBack() { false }

  **
  ** get native host
  **
  abstract Window? host

  **
  ** get prefer size
  **
  virtual Size getPrefSize(Int hintsWidth, Int hintsHeight)  { Size(hintsWidth, hintsHeight) }
}

**
** native host view
**
@Js
mixin Window
{
  abstract View view()
  
  **
  ** request repaint
  **
  abstract Void repaint(Rect? dirty := null)

  **
  ** get current position
  **
  abstract Point pos()

  ** get window size
  abstract Size size()

  **
  ** return true if has focus
  **
  abstract Bool hasFocus()

  **
  ** request focus
  **
  abstract Void focus()

  **
  ** show text edit view
  **
  abstract Void textInput(TextInput edit)


  abstract Void fileDialog(Str accept, |Obj[]?| f, [Str:Obj]? options := null)
}

