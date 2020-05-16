//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   10 Aug 09  Brian Frank  Creation
//   2014-11-14 Jed Young Modify
//

using vaseGraphics
using vaseWindow

**
** A Point
**
@Js
class Coord {
  Float x
  Float y

  ** Construct with x, y.
  new make(Float x, Float y) { this.x = x; this.y = y }

  This set(Float x, Float y) {
    this.x = x
    this.y = y
    return this
  }

  ** Parse from string.  If invalid and checked is
  ** true then throw ParseErr otherwise return null.
  static Coord? fromStr(Str s, Bool checked := true)
  {
    try
    {
      comma := s.index(",")
      return make(s[0..<comma].trim.toFloat, s[comma+1..-1].trim.toFloat)
    }
    catch {}
    if (checked) throw ParseErr("Invalid Point: $s")
    return null
  }

  ** Return 'x+tx, y+ty'
  Coord translate(Coord t) { make(x+t.x, y+t.y) }

  ** Return hash of x and y.
  override Int hash() { x.bits.xor(y.bits.shiftl(16)) }

  ** Return if obj is same Point value.
  override Bool equals(Obj? obj)
  {
    that := obj as Coord
    if (that == null) return false
    return this.x == that.x && this.y == that.y
  }

  ** Return '"x,y"'
  override Str toStr() { "$x,$y" }
}

**
** Insets represent a number of pixels around the edge of a rectangle.
**
@Js
@Serializable { simple = true }
const class Insets
{
  ** Default instance 0, 0, 0, 0.
  const static Insets defVal := Insets(0, 0, 0, 0)

  **
  ** Construct with top, and optional right, bottom, left.  If one side
  ** is not specified, it is reflected from the opposite side:
  **
  **   Insets(5)     => Insets(5,5,5,5)
  **   Insets(5,6)   => Insets(5,6,5,6)
  **   Insets(5,6,7) => Insets(5,6,7,6)
  **
  new make(Int top, Int? right := null, Int? bottom := null, Int? left := null)
  {
    if (right == null) right = top
    if (bottom == null) bottom = top
    if (left == null) left = right
    this.top = top
    this.right = right
    this.bottom = bottom
    this.left = left
  }

  ** Parse from string (see `toStr`).  If invalid and checked
  ** is true then throw ParseErr otherwise return null.  Supported
  ** formats are:
  **   - "len"
  **   - "top,right,bottom,left"
  static Insets? fromStr(Str s, Bool checked := true)
  {
    try
    {
      c1 := s.index(",")
      if (c1 == null) { len := s.toInt; return make(len, len, len, len) }
      c2 := s.index(",", c1+1)
      c3 := s.index(",", c2+1)
      return make(s[0..<c1].trim.toInt, s[c1+1..<c2].trim.toInt,
                  s[c2+1..<c3].trim.toInt, s[c3+1..-1].trim.toInt)
    }
    catch {}
    if (checked) throw ParseErr("Invalid Insets: $s")
    return null
  }

  ** If all four sides are equal return '"len"'
  ** otherwise return '"top,right,bottom,left"'.
  override Str toStr()
  {
    if (top == right && top == bottom && top == left)
      return top.toStr
    else
      return "$top,$right,$bottom,$left"
  }

  ** Return hash of top, right, bottom, left.
  override Int hash()
  {
    top.xor(right.shiftl(8)).xor(bottom.shiftl(16)).xor(left.shiftl(24))
  }

  ** Return if obj is same Insets value.
  override Bool equals(Obj? obj)
  {
    that := obj as Insets
    if (that == null) return false
    return this.top == that.top && this.right == that.right &&
           this.bottom == that.bottom && this.left == that.left
  }

  ** Return right+left, top+bottom
  Size toSize() { Size(right+left, top+bottom) }

  ** Top side spacing
  const Int top

  ** Right side spacing
  const Int right

  ** Bottom side spacing
  const Int bottom

  ** Left side spacing
  const Int left
}

@Js
enum class Direction {
  top,
  right,
  down,
  left
}
