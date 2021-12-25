void main()
{
  sound s;
  for(;s.playing;) {}
  while(s.playing) {}
  do {} while (s.playing);
  if(s.playing) {}
  s.playing ? 0 : 1;
  switch(s.count) {case 0:}
}
