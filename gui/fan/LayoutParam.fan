//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2014-11-14  Jed Young  Creation
//

using fanvasGraphics
using fanvasWindow

**
** Number with unit
**
@Js
@Serializable { simple = true }
const class Scalar {
  const static Scalar defVal := Scalar()

  ** device independent pixel base 320 dpi
  static const Str dp := "dp"

  ** pixel
  static const Str px := "px"

  ** percent of width
  static const Str pw := "pw"

  ** percent of height
  static const Str ph := "ph"

  ** centimeter
  static const Str cm := "cm"

  ** inch
  static const Str in := "in"

  ** the unit of value
  const Str unit

  ** current vaule
  const Float value

  new make(Float val := 0f, Str unit := dp) {
    value = val
    this.unit = unit
  }

  static new fromStr(Str str) {
    i := str.index(".")
    val := str[0..<i].toFloat
    unit := str[i+1..-1]
    return Scalar(val, unit)
  }

  override Str toStr() {
    "${value}.$unit"
  }

  **
  ** convert to pixel size
  **
  Int getPixel(Widget? parent) {
    Float result := 0f
    switch (unit) {
      case dp:
      result = (DisplayMetrics.dpToPixel(value).toFloat)

      case px:
      result = value

      case pw:
      result = (value *parent.getContentWidth / 100f)

      case ph:
      result = (value *parent.getContentHeight / 100f)

      case cm:
      result = (value * 0.3937008f * DisplayMetrics.dpi)

      case in:
      result = (value * DisplayMetrics.dpi)

      default:
      throw UnsupportedErr("unknow unit")
    }

    return result.round.toInt
  }
}

**
** Tell parent how to layout this widget
** The parent may ignore the param
**
@Js
@Serializable
class LayoutParam {

  **
  ** fill parent or others define by layout pane
  **
  static const Int matchParent := -1

  **
  ** preferred size by prefSize()
  **
  static const Int wrapContent := -2

  **
  ** out side bounder
  **
  Insets margin := Insets.defVal

  **
  ** width of widget
  **
  Int width := matchParent

  **
  ** height of widget
  **
  Int height := wrapContent

  **
  ** layout weight compare to sibling widget
  **
  Float weight := 0f


  **
  ** align center horizontal or vertical
  **
  static const Int alignCenter := Int.minVal

  **
  ** align bootom or right
  **
  static const Int alignEnd := alignCenter-1

  **
  ** x position of widget.
  ** center for align center horizontal
  ** positive for left side. negative for right side
  **
  Int posX := 0

  **
  ** y position of widget.
  ** center for align center vertical
  ** positive for top side. negative for bottom side
  **
  Int posY := 0

}