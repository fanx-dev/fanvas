//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2015-12-5  Jed Young  Creation
//
using vaseGui

@Js
class TreeTest : BasePage
{
  protected override Widget view() {
    TreeView { model = MyTreeModel() }
  }
}

@Js
class MyTreeModel : TreeModel
{
  override Obj[] roots()
  {
    ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  }
  override Str text(Obj node) { node.toStr }
  override Bool hasChildren(Obj node) { true }
  override Obj[] children(Obj node) { ["aaa", "bbb", "ccc", "ddd", "eee", "fff"] }
}