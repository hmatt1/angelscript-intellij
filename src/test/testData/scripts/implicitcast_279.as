class TransitionManager {
  void MoveTo(DisplayObject @o) {}
}
TransitionManager mgr;
MovieClip movie;
void OnLoad()
{
  mgr.MoveTo(movie);
  mgr.MoveTo(@movie);
}
