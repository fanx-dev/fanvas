//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   10 Aug 09  Brian Frank  Creation
//   2014-11-14 Jed Young Modify
//

using fgfxGraphics


**
** EdgePane is a container which lays out four children along
** the four edges and one child in the center.  The top and
** bottom edges are laid out with their preferred height.  Children
** on the left or right edges are laid out with with their preferred
** width.  Any remaining space is given to the center component.
**
@Js
class EdgePane : FrameLayout
{
  new make() {
    layoutParam.height = LayoutParam.matchParent
    layoutParam.width = LayoutParam.matchParent
  }
//////////////////////////////////////////////////////////////////////////
// Children
//////////////////////////////////////////////////////////////////////////

  **
  ** Top widget is laid out with preferred height.
  **
  Widget? top { set { remove(&top).add(it); &top = it } }

  **
  ** Bottom widget is laid out with preferred height.
  **
  Widget? bottom { set { remove(&bottom).add(it); &bottom = it } }

  **
  ** Left widget is laid out with preferred width.
  **
  Widget? left  { set { remove(&left).add(it); &left = it } }

  **
  ** Right widget is laid out with preferred width.
  **
  Widget? right { set { remove(&right).add(it); &right = it } }

  **
  ** Center widget gets any remaining space in the center.
  **
  Widget? center { set { remove(&center).add(it); &center = it } }

//////////////////////////////////////////////////////////////////////////
// Layout
//////////////////////////////////////////////////////////////////////////

  override Dimension prefContentSize(Int hintsWidth, Int hintsHeight, Dimension result)
  {
    result = pref(this.top, hintsWidth, hintsHeight, result)
    top_w := result.w
    top_h := result.h
    hintsHeight -= top_h

    result = pref(this.bottom, hintsWidth, hintsHeight, result)
    bottom_w := result.w
    bottom_h := result.h
    hintsHeight -= bottom_h

    result = pref(this.left, hintsWidth, hintsHeight, result)
    left_w := result.w
    left_h := result.h
    hintsWidth -= left_w

    result = pref(this.right, hintsWidth, hintsHeight, result)
    right_w := result.w
    right_h := result.h
    hintsWidth -= right_w

    center := pref(this.center, hintsWidth, hintsHeight, result)

    w := (left_w + center.w + right_w).max(top_w).max(bottom_w)
    h := top_h + bottom_h + (left_h.max(center.h).max(right_h))
    //echo("prefW$w, center.w$center.w")
    result.w = w
    result.h = h
    return result
  }

  private Dimension pref(Widget? w, Int hintsWidth, Int hintsHeight, Dimension result)
  {
    if (w == null) {
      return result.set(0, 0)
    }
    return w.prefBufferedSize(hintsWidth, hintsHeight, result)
  }

  override This doLayout(Dimension result)
  {
    //s := size
    x := padding.left; y := padding.top;
    w := getContentWidth; h := getContentHeight

    //echo("size$size")

    top := this.top
    if (top != null)
    {
      prefh := top.prefBufferedSize(w, -1, result).h
      top.bounds = Rect(x, y, w, prefh)
      top.doLayout(result)
      y += prefh; h -= prefh
    }

    bottom := this.bottom
    if (bottom != null)
    {
      prefh := bottom.prefBufferedSize(w, -1, result).h
      bottom.bounds = Rect(x, y+h-prefh, w, prefh)
      bottom.doLayout(result)
      h -= prefh
    }

    left := this.left
    if (left != null)
    {
      prefw := left.prefBufferedSize(-1, h, result).w
      left.bounds = Rect(x, y, prefw, h)
      left.doLayout(result)
      x += prefw; w -= prefw
    }

    right := this.right
    if (right != null)
    {
      prefw := right.prefBufferedSize(-1, h, result).w
      right.bounds = Rect(x+w-prefw, y, prefw, h)
      right.doLayout(result)
      w -= prefw
    }

    center := this.center
    if (center != null)
    {
      center.bounds = Rect(x, y, w, h)
      center.doLayout(result)
    }

    return this
  }

}