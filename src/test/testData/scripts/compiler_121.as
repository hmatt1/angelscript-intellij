enum wf_type
{
  sawtooth=1,
  square=2,
  sine=3
}
class tone_synth
{
  void set_waveform_type(wf_type i) property {}
}
void main ()
{
  tone_synth t;
  t.waveform_type = sine;
}
