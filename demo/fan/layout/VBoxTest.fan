//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//
using vaseGui

**
** VBox
**
class VBoxTest : BasePage
{
  protected override Widget view() {
    VBox
    {
      margin = Insets(50)
      Button
      {
        text = "btn1"
        layout.offsetX = 800
        layout.offsetY = 500
        layout.width = Layout.wrapContent
      },
      Button
      {
        text = "btn2"
        layout.width = 600
      },
      Button
      {
        text = "btn3"
        layout.width = Layout.wrapContent
        layout.hAlign = Align.center
      },

    }
  }
}
