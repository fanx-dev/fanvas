package fan.fanvasAndroid;

import android.app.Activity;
import android.os.Handler;
import android.os.Looper;
import android.util.DisplayMetrics;
import android.view.WindowManager;
import fan.concurrent.Actor;
import fan.fanvasWindow.Toolkit;
import fan.fanvasWindow.Window;

public class AndroidEnvPeer {
  public static AndroidEnvPeer make(AndroidEnv self)
  {
    AndroidEnvPeer peer = new AndroidEnvPeer();
    return peer;
  }

  public static boolean isMainThread() {
    return Looper.getMainLooper().getThread() == Thread.currentThread();
  }

  public static void init(Activity context)
  {
    Actor.locals().set("fanvasGraphics.env", AndGfxEnv.instance);
    Actor.locals().set("fanvasWindow.env", AndToolkit.getInstance(context));

    if (isMainThread()) {
      Toolkit.tryInitAsyncRunner();
    }
  }

  static class AndToolkit extends Toolkit
  {
    static AndToolkit instance = null;

    private Activity context;
    long dpi = 326;
    Handler handler;
    double density = 2.0f;

    private AndWindow curWindow = null;

    static AndToolkit getInstance(Activity context) {
      if (instance == null) instance = new AndToolkit(context);
      return instance;
    }

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
        density = metrics.density;
      }
      
      handler = new Handler();
    }

    @Override
    public Window window(fan.fanvasWindow.View view)
    {
      if (view != null) {
        curWindow = new AndWindow(context, view);
        curWindow.show(null);
      }
      return curWindow;
    }

    @Override
    public void callLater(long daly, final fan.sys.Func f)
    {
      handler.postDelayed(new Runnable() {
          public void run()
          {
            f.call();
          }
        }, daly);
    }

    @Override
    public String name() {
      return "Android";
    }

    @Override
    public long dpi() {
      return dpi;
    }
    
    @Override
    public double density() {
      return density;
    }
  }
}