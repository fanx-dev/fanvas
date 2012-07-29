#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-06-04  Jed Young  Creation
//

using build

class Build : BuildPod
{
  new make()
  {
    podName  = "fgfxWtk"
    summary  = "Window toolkit"
    depends  = ["sys 1.0", "fgfx2d 1.0", "concurrent 1.0", "fgfxMath 1.0"]
    srcDirs  = [`fan/`, `fan/event/`]
    javaDirs = [`java/`]
    jsDirs   = [`js/`]
    //docSrc   = true
  }
}