//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-7-4  Jed Young  Creation
//

using concurrent
using fanvasGraphics
using fanvasWindow
using fanvasGui

**
** Win Test
**
@Js
class WidgetTest : BaseTestWin
{
  protected override Widget build() {
    LinearLayout
    {
      padding = Insets(100)
      spacing = 30f
      Button { id = "button"; text = "Hello Button" },
      ComboBox {
        it.items = ["comboBox1","comboBox2","comboBox3","comboBox4"]
        selectedIndex = 0
      },
      Label { id = "label"; text = "Label"; },
      ImageView { id = "image";  uri = (`fan://icons/x64/check.png`) },
      TextField { hint = "hint" },
      Switch { text = "switch" },
      ToggleButton { text = "checkBox" },
      RadioButton { text = "radio1" },
      RadioButton { text = "radio2" },
      ImageButton { id = "imageButton"; uri = `fan://icons/x64/sync.png` }
    }
  }

  protected override Void init(RootView root) {

    label := root.findById("label")
    a := TweenAnimation() {
      AlphaAnimChannel {},
//      ScaleAnimChannel {},
      TransAnimChannel {},
    }
    a.run(label)

    Button btn := root.findById("button")
    btn.onAction.add
    {
      Toast { it.text = "hello world" }.show(root)
    }

    ButtonBase btn2 := root.findById("imageButton")
    btn2.onAction.add
    {
      Toast { it.text = "hello world" }.show(root)
    }
  }

  override Void main() { super.main }

}