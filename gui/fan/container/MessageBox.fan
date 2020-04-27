//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-10-06  Jed Young  Creation
//

using vaseGraphics
using vaseWindow

**
** MessageBox
**
@Js
class MessageBox : VBox
{
  Label label { private set }

  new make()
  {
    label = Label {
      it.id = "messageBox_msg"
      it.text = "messageBox"
      it.useRenderCache = false
      it.margin = Insets(20)
    }
    btn := Button {
      it.id = "messageBox_ok"
      onAction.add {
        /*
        a := TweenAnimation() {
          AlphaAnimChannel { from = 1f; to = 0f },
        }
        a.whenDone.add |->|{ hide }
        a.run(this)
        */
        this.moveOutAnim(Direction.down).start
        //this.shrinkAnim(200).start
      };
      it.text = "OK"
      it.layout.width = Layout.matchParent
      it.useRenderCache = false
    }

    this.add(label)
    this.add(btn)
    this.layout.hAlign = Align.center
    this.layout.vAlign = Align.center

//    this.layout.posX.with { it.Align = 0.5f; anchor = 0.5f; offset = 0f }
//    this.layout.posY.with { it.parent = 0.5f; anchor = 0.5f; offset = 0f }

    this.layout.width = Layout.wrapContent//dpToPixel(500f)
    padding = Insets(50)
  }

  Void show(Widget w)
  {
    root := w.getRootView
    overlayer := root.topOverlayer
    overlayer.add(this)
    this.focus
    root.modal = 2
    overlayer.relayout
    /*
    a := TweenAnimation() {
      AlphaAnimChannel {},
      TransAnimChannel {},
    }
    a.run(this)
    */
    this.moveInAnim(Direction.down).start
    //this.expandAnim(200).start
  }
  /*
  Void hide()
  {
    WidgetGroup? p := parent
    if (p == null) return

    if (this.hasFocus) {
      p.getRootView.focusIt(null)
    }
    p.remove(this)
    p.repaint
    p.getRootView.modal = false
  }
  */
}