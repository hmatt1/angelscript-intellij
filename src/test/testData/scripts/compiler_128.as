double round(double d, int i) {return double(int64(d*1000+0.5))/1000;}
//		"string input_box(string &in, string &in) {return '';}
//		"int string_to_number(string) {return 0;}
void main()
{
//"  show_game_window('Golden Ratio');

  double numberA=0, numberB=1;
  double sum_of_ratios=0;
  int sequence_length=1475;

  for(int i=0; i<sequence_length; i++)
  {
    double temp=numberB;
    numberB=numberA+numberB;
    numberA=temp;

//		"    print('A:'+numberA+', B:'+numberB+'\n');
    sum_of_ratios+=round(numberB/numberA, 3);
//		"    print(sum_of_ratios+'\n');
  } // end for.

  double average_of_ratios=sum_of_ratios/sequence_length;
  average_of_ratios=round(average_of_ratios, 3);
//			"  assert(average_of_ratios == 1.618);
  print('The average of first '+sequence_length+' ratios of Fibonacci number is: '+average_of_ratios+'.\n');
//"  alert('Average', 'The average of first '+sequence_length+' ratios of Fibonacci number is: '+average_of_ratios+'.');
//"  exit();
}
