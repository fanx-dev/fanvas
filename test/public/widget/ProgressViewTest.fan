//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//

using vaseGui

@Js
class ProgressViewTest : BaseTestWin
{
  protected override Widget build() {
    VBox
    {
      it.id = "mainView"
      it.margin = Insets(100)
      ProgressView {
        it.id = "ProgressView"
      },
      ProgressView {
        it.style = "progressBar"
        it.value = 0.3 
      },
    }
  }
}