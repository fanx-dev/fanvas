//
// Copyright (c) 2011, chunquedong
// Licensed under the Academic Free License version 3.0
//
// History:
//   2011-08-14  Jed Young  Creation
//

package fan.gfx2Imp;

import java.util.Stack;

import fan.sys.FanObj;
import fan.sys.ArgErr;

import fan.fgfxArray.*;
import fan.fgfxMath.*;
import fan.gfx.*;
import fan.gfx2.*;
import fan.fwt.FwtGraphics;


import org.eclipse.swt.SWT;
import org.eclipse.swt.graphics.GC;
import org.eclipse.swt.graphics.Pattern;
import org.eclipse.swt.graphics.Rectangle;
import org.eclipse.swt.graphics.Transform;
import org.eclipse.swt.widgets.Display;
import org.eclipse.swt.events.PaintEvent;
import org.eclipse.swt.graphics.Region;

public class FwtGraphics2 extends FwtGraphics implements Graphics2
{
  GC gc;

  public FwtGraphics2(PaintEvent e)
  {
    this(e.gc, e.x, e.y, e.width, e.height);
  }

  public FwtGraphics2(GC gc, int x, int y, int w, int h)
  {
    super(gc, x, y, w, h);
    this.gc = gc;
  }

  public FwtGraphics2 drawImage2(Image2 image, long x, long y)
  {
    Image2Imp p = (Image2Imp)image;
    gc.drawImage(p.getImage(), (int)x, (int)y);
    return this;
  }
  public FwtGraphics2 copyImage2(Image2 image, Rect s, Rect d)
  {
    Image2Imp p = (Image2Imp)image;
    gc.drawImage(p.getImage(),
      (int)s.x, (int)s.y, (int)s.w, (int)s.h,
      (int)d.x, (int)d.y, (int)d.w, (int)d.h);
    return this;
  }

  public FwtGraphics2 drawPath(fan.gfx2.Path path)
  {
    org.eclipse.swt.graphics.Path p = toSwtPath(path);
    gc.drawPath(p);
    p.dispose();
    return this;
  }
  public FwtGraphics2 fillPath(fan.gfx2.Path path)
  {
    org.eclipse.swt.graphics.Path p = toSwtPath(path);
    gc.fillPath(p);
    p.dispose();
    return this;
  }

  public FwtGraphics2 drawPolyline2(Array p)
  {
    gc.drawPolyline((int[])p.peer.getValue());
    return this;
  }
  public FwtGraphics2 fillPolygon2(Array p)
  {
    gc.fillPolygon((int[])p.peer.getValue());
    return this;
  }

  public FwtGraphics2 setTransform(fan.fgfxMath.Transform2D trans)
  {
    Transform t = toSwtTransform(trans);
    gc.setTransform(t);
    t.dispose();
    return this;
  }

  @Override
  public void transform(Transform2D trans) {
    Transform t = toSwtTransform(trans);
    gc.setTransform(t);
    t.dispose();
  }

  @Override
  public Transform2D transform() {
    Transform t = new Transform(FwtEnv2.getDisplay());
    gc.getTransform(t);
    Transform2D trans = toTransform(t);
    t.dispose();
    return trans;
  }

  public FwtGraphics2 clipPath(Path path)
  {
    if (!gc.isClipped())
    {
      org.eclipse.swt.graphics.Path p = toSwtPath(path);
      gc.setClipping(p);
      p.dispose();
      return this;
    }

    Region region  = new Region();
    gc.getClipping(region);

    gc.setClipping(toSwtPath(path));
    Region region2  = new Region();
    gc.getClipping(region2);

    region.intersect(region2);
    gc.setClipping(region);
    return this;
  }

  public Image2 image()
  {
    return new Image2Imp(gc.getGCData().image);
  }

  /**
   * auto free resource
   */
  @Override
  protected void finalize()
  {
    if (!gc.isDisposed()) gc.dispose();
  }


//////////////////////////////////////////////////////////////////////////
// Util
//////////////////////////////////////////////////////////////////////////

  static public org.eclipse.swt.graphics.Path toSwtPath(fan.gfx2.Path path)
  {
    int size = (int)path.steps().size();
    org.eclipse.swt.graphics.Path swtPath = new org.eclipse.swt.graphics.Path(FwtEnv2.getDisplay());
    for (int i =0; i < size; ++i)
    {
      PathStep step = (PathStep)path.steps().get(i);

      if (step instanceof PathMoveTo)
      {
        PathMoveTo s = (PathMoveTo)step;
        swtPath.moveTo((float)s.x, (float)s.y);
      }
      else if (step instanceof PathLineTo)
      {
        PathLineTo s = (PathLineTo)step;
        swtPath.lineTo((float)s.x, (float)s.y);
      }
      else if (step instanceof PathQuadTo)
      {
        PathQuadTo s = (PathQuadTo)step;
        swtPath.quadTo((float)s.cx, (float)s.cy, (float)s.x, (float)s.y);
      }
      else if (step instanceof PathCubicTo)
      {
        PathCubicTo s = (PathCubicTo)step;
        swtPath.cubicTo((float)s.cx1, (float)s.cy1, (float)s.cx2, (float)s.cy2, (float)s.x, (float)s.y);
      }
      else if (step instanceof PathClose)
      {
        swtPath.close();
      }
      else
      {
        throw fan.sys.Err.make("unreachable");
      }
    }
    return swtPath;
  }

  static public Transform toSwtTransform(Transform2D trans)
  {
    return new Transform(FwtEnv2.getDisplay(),
       (float)trans.get(0,0),
       (float)trans.get(0,1),
       (float)trans.get(1,0),
       (float)trans.get(1,1),
       (float)trans.get(2,0),
       (float)trans.get(2,1)
       );
  }

  static public Transform2D toTransform(Transform trans) {
    float[] elem = new float[6];
    trans.getElements(elem);
    Transform2D t = Transform2D.make();
    t.set(0,0, elem[0]);
    t.set(0,1, elem[1]);
    t.set(1,0, elem[2]);
    t.set(1,1, elem[3]);
    t.set(2,0, elem[4]);
    t.set(2,1, elem[5]);
    return t;
  }
}