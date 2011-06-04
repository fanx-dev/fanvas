#! /usr/bin/env fan
//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-06-04  Jed Young  Creation
//

using build

**
** fan D:/code/Hg/fan3d/fogl/build.fan
**
class Build : BuildPod
{
  new make()
  {
    podName  = "fogl"
    summary  = "Fantom OpenGL Binding"
    depends  = ["sys 1.0"]
    srcDirs  = [`fan/`, `test/`]
    javaDirs = [`java/`]
    jsDirs   = [`js/`]
    //docSrc   = true
  }
}