//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2012-07-15  Jed Young  Creation
//
using vaseGraphics

@Js
class StyleManager
{
  Str:Style idMap := [:]
  Str:Style styleClassMap
  Type:Style typeMap
  private Style defStyle

  new make()
  {
    typeMap =
    [
      Button# : RoundButtonStyle(),
      ImageView# : ImageStyle(),
      Label# : LabelStyle(),
      EditText# : EditTextStyle(),
      ToggleButton# : SwitchStyle(),
      RadioButton# : RadioButtonStyle(),
      ScrollBar# : ScrollBarStyle(),
      SliderBar# : SliderBarStyle(),
      ComboBox# : ComboBoxStyle(),
      Table# : TableStyle(),
      TreeView# : TreeStyle(),
      TextArea# : TextAreaStyle(),
      MenuItem# : MenuItemStyle(),
      Menu# :  MenuStyle(),
      Toast# : ToastStyle(),
      ProgressView# : ProgressViewStyle(),
      CardIndicator# : CardIndicatorStyle(),
      Spinner# : SpinnerStyle(),
      RectView# : RectViewStyle(),
      TextView# : TextViewStyle()
    ]
    defStyle = WidgetStyle()

    styleClassMap = [
        "buttonBase" : ButtonBaseStyle(),
        "menuItem" : MenuItemStyle(),
        "tableHeader" : TableHeaderStyle(),
        "pane" : PaneStyle(),
        "flatButton" : FlatButtonStyle(),
        "progressBar" : ProgressBarStyle(),
        "dialog" : PaneStyle(),
        "tabItem" : TabItemStyle(),
        "tabItemHighlight" : TabItemHighlightStyle(),
        "checkBox" : ToggleButtonStyle(),
        "h1" : LabelStyle { fontInfo.size = (fontInfo.size * 2.0).toInt },
        "h2" : LabelStyle { fontInfo.size = (fontInfo.size * 1.5).toInt },
        "h3" : LabelStyle { fontInfo.size = (fontInfo.size * 1.2).toInt },
        "h4" : LabelStyle { fontInfo.size = (fontInfo.size * 1.0).toInt },
        "h5" : LabelStyle { fontInfo.size = (fontInfo.size * 0.83).toInt },
        "h6" : LabelStyle { fontInfo.size = (fontInfo.size * 0.75).toInt },
    ]
  }

  private Style? findByType(Type type) {
    s := typeMap.get(type)
    if (s != null) {
      return s
    }
    if (type == Obj#) {
      return null
    }

    return findByType(type.base)
  }

  Style find(Widget widget)
  {
    s := idMap.get(widget.id)
    if (s != null) return s

    s = styleClassMap.get(widget.style)
    if (s != null) return s

    s = findByType(widget.typeof)
    if (s != null) return s

    return defStyle
  }
}