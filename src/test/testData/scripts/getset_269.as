class sound
{
  int get_pitch() property { return 1; }
  void set_pitch(int p) property {}
}
void main()
{
  sound[] sounds(1) ;
  sounds[0].pitch = int(sounds[0].pitch)/2;
}
