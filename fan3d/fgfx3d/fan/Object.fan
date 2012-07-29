//
// Copyright (c) 2012, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-02-24  Jed Young  Creation
//

using fgfxMath
using fgfxOpenGl
using fgfxArray

@Js
class Object : Group
{
  Float[]? vertices
  private GlBuffer? triangleVertexPositionBuffer
  private Int vertexPositionAttribute
  private GlContext? gl

  Program? program

  Void init(GlContext? gl)
  {
    this.gl = gl
    triangleVertexPositionBuffer = gl.createBuffer
    gl.bindBuffer(GlEnum.arrayBuffer, triangleVertexPositionBuffer)
    arrayBuffer := ArrayBuffer.makeFloat(vertices)
    gl.bufferData(GlEnum.arrayBuffer, arrayBuffer, GlEnum.staticDraw)

    program.init(gl)
    program.useProgram
    vertexPositionAttribute = program.getAttribLocation("aVertexPosition")
    gl.enableVertexAttribArray(vertexPositionAttribute)
  }

  Void paint(GlContext gl)
  {
    gl.bindBuffer(GlEnum.arrayBuffer, triangleVertexPositionBuffer)
    gl.vertexAttribPointer(vertexPositionAttribute, 3, GlEnum.float, false, 0, 0)

    gl.drawArrays(GlEnum.triangles, 0, 3)
  }
}