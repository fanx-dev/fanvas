package fan.fgfxAndroid;

import fan.concurrent.Actor;
import fan.fgfxWtk.Toolkit;
import fan.fgfxWtk.View;
import fan.fgfxWtk.Window;
import android.content.Context;
import android.app.Activity;
import android.util.DisplayMetrics;
import android.view.WindowManager;

public class AndroidEnvPeer {
  public static AndroidEnvPeer make(AndroidEnv self)
  {
    AndroidEnvPeer peer = new AndroidEnvPeer();
    return peer;
  }

  public static void init(Activity context)
  {
    Actor.locals().set("fgfxGraphics.env", AndGfxEnv.instance);
    Actor.locals().set("fgfxWtk.env", new AndToolkit(context));
  }

  static class AndToolkit extends Toolkit
  {
    Activity context;
    long dpi = 326;

    public AndToolkit(Activity context)
    {
      this.context = context;

      DisplayMetrics metrics = new DisplayMetrics();
      WindowManager mWm = context.getWindowManager();
      if (mWm != null) {
        mWm.getDefaultDisplay().getMetrics(metrics);
        float dpi = (float) Math.ceil(Math.max(Math.max(metrics.xdpi, metrics.ydpi),
            metrics.densityDpi));
        this.dpi = (long)dpi;
      }
    }

    @Override
    public Window build() {
      return new AndWindow(context);
    }

    @Override
    public void callLater(long daly, final fan.sys.Func f)
    {
      context.runOnUiThread(
          new Runnable()
          {
            public void run()
            {
              f.call();
            }
          }
      );
    }

    @Override
    public String name() {
      return "Android";
    }

    @Override
    public long dpi() {
      return dpi;
    }
  }
}