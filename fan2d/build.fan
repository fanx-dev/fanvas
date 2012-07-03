#! /usr/bin/env fan
//
// Copyright (c) 2009, Brian Frank and Andy Frank
// Licensed under the Academic Free License version 3.0
//
// History:
//   30 Apr 09  Brian Frank  Creation
//

using build

**
** Build: gfx
**
class Build : BuildPod
{
  new make()
  {
    podName  = "fan2d"
    summary  = "Graphics 2D API"
    srcDirs  = [`fan/`]
    depends  = ["sys 1.0", "concurrent 1.0", "fan3dMath 1.0"]
    javaDirs = Uri[,]
  }
}