package fan.vaseAndroid;

import fan.sys.Func;

import android.graphics.Paint;
import android.graphics.Typeface;
import fan.vaseGraphics.Font;

public class AndFont extends Font {

  Paint p = null;

  public static Font makeFont(Func func)
  {
    Font f = new AndFont();
    //func.enterCtor(f);
    func.call(f);
    //func.exitCtor();
    return f;
  }

  public Paint getPaint() {
    if (p == null) {
      p = new Paint();
      Typeface tf = AndUtil.toAndFont(this);
      p.setTypeface(tf);
      p.setTextSize(this.size);
    }
    return p;
  }

  @Override
  public long ascent() {
    return (long) -getPaint().ascent();
  }

  @Override
  public long descent() {
    return (long) getPaint().descent();
  }

  @Override
  public long height() {
    Paint.FontMetricsInt metrics = getPaint().getFontMetricsInt();
    return metrics.bottom - metrics.top;
  }

  @Override
  public long leading() {
    Paint.FontMetricsInt metrics = getPaint().getFontMetricsInt();
    return metrics.leading;
  }

  @Override
  public long width(String s) {
    return (long) getPaint().measureText(s);
  }

  @Override
  public void dispose() {
  }
}