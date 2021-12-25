double get_gameTime() property { return 100; }
void advance(bool full) {
  nextThink = gameTime + ( 30.0 * (full ? 10.0 : 1.0) );
}
double nextThink;
