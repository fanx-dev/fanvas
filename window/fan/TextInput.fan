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
mixin TextInput
{
  abstract TextInputPeer? host

  const static Int inputTypeText := 1
  const static Int inputTypeIntNumber := 2
  const static Int inputTypeFloatNumber := 3
  const static Int inputTypePassword := 4
  const static Int inputTypeMultiLine := 5
/*
  abstract Point getPos()
  abstract Size getSize()

  abstract Int inputType()
  abstract Bool singleLine()
  abstract Bool editable()

  abstract Color textColor()
  abstract Color backgroundColor()
  abstract Font font()
  
  abstract Str text()
*/
  abstract Int getInputType()

  abstract Str textChange(Str text)
  abstract Void keyAction(Str text)

  abstract Void onKeyEvent(KeyEvent e)
}

@Js
mixin TextInputPeer
{
  abstract Void close()

  abstract Void setPos(Int x, Int y, Int w, Int h)
  abstract Void setStyle(Font font, Color textColor, Color backgroundColor)
  abstract Void setText(Str text)
  abstract Void setType(Int multiLine, Bool editable)
  abstract Void focus()

  abstract Void select(Int start, Int end)
  abstract Int caretPos()
}
