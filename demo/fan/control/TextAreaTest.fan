//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//
using vaseGui

@Js
class TextAreaTest : BasePage
{
  protected override Widget view() {
    TextArea {
      model = DefTextAreaModel(
                               """//
                                  // Copyright (c) 2011, chunquedong
                                  // Licensed under the Academic Free License version 3.0
                                  //



                                  // History:
                                  //   2011-7-4  Jed Young  Creation
                                  //""")
    }
  }
}