shared class Alignment {
  Alignment(int lt, float lp, int lx,
 		     int tt, float tp, int tx,
		     int rt, float rp, int rx,
		     int bt, float bp, int bx)
  {
    assert(lt == AS_Left);
    assert(tt == AS_Bottom);
    assert(rt == AS_Right);
    assert(bt == AS_Bottom);
    assert(lp == 3.14f);
    assert(tp == 1.43f);
    assert(rp == 4.13f);
    assert(bp == 4.34f);
    assert(lx == 42);
    assert(tx == 53);
    assert(rx == 64);
    assert(bx == 75);
  }
  AlignedPoint left;
//	"  AlignedPoint right;
//	"  AlignedPoint top;
//	"  AlignedPoint bottom;
//	"  double aspectRatio;
//	"  double aspectHorizAlign;
//	"  double aspectVertAlign;
}
shared class AlignedPoint {
//	"  int type;
//	"  float percent;
//	"  int pixels;
//	"  int size;

  AlignedPoint() {
//	"    type = AS_Left;
//	"    pixels = 0;
//	"    percent = 0;
//	"    size = 0;
  }
}
shared enum AlignmentSide
{
  AS_Left, AS_Right, AS_Top = AS_Left, AS_Bottom = AS_Right
}
class Fault {
  Alignment @get_alignment() property {return A;}
  void set_alignment(Alignment@ value) property {@A = value;}
  Fault() {
    a = 3.14f;
    b = 1.43f;
    c = 4.13f;
    d = 4.34f;
    @alignment = Alignment(
                    AS_Left,   a + 0.0f, 42,
                    AS_Bottom, b + 0.0f, 53,
                    AS_Right,  c + 0.0f, 64,
                    AS_Bottom, d + 0.0f, 75);
  }
  Alignment @A;
  float a; float b; float c; float d;
}
