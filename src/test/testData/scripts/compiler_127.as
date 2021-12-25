class Technique {
  string hitsound;
}
Technique@ getTechnique() {return @Technique();}
void main() {
  string t = getTechnique().hitsound;
}
