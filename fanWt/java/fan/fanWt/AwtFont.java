package fan.fanWt;

import fan.fan2d.*;

public class AwtFont extends Font {

  private java.awt.Font nfont = null;
  private java.awt.FontMetrics fontMetrics = null;
  
  public java.awt.Font getNFont() {
  	if (nfont == null) {
  		nfont = AwtUtil.toFont(this);
  	}
  	return nfont;
  }
  
  
  public java.awt.FontMetrics getFontMetrics() {
  	if (fontMetrics == null) {
  		fontMetrics = AwtUtil.scratchG().getFontMetrics(getNFont());
  	}
  	return fontMetrics;
  }
  
  
	@Override
  public long ascent() {
    return getFontMetrics().getAscent();
  }

	@Override
  public long descent() {
    return getFontMetrics().getDescent();
  }

	@Override
  public void dispose() {
  }

	@Override
  public long height() {
    return getFontMetrics().getHeight();
  }

	@Override
  public long leading() {
    return getFontMetrics().getLeading();
  }

	@Override
  public long width(String s) {
    return getFontMetrics().stringWidth(s);
  }

}