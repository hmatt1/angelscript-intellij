uint8 search_no(uint8[]@ cmd, uint16 len, uint8[] @rcv)
{
	if (@rcv == null) assert(false);
		return(255);
}
void main()
{
	uint8[] cmd = { 0x02, 0x95, 0x45, 0x42, 0x32 };
	uint8[] rcv;
	uint16 len = 8;
	search_no(cmd, cmd.length(), rcv);
	search_no(cmd, GET_LEN2(cmd), rcv);
	len = GET_LEN(cmd);
	search_no(cmd, len, rcv);

	search_no(cmd, GET_LEN(cmd), rcv);
}
uint16 GET_LEN(uint8[]@ cmd)
{
	return cmd[0]+3;
}
uint16 GET_LEN2(uint8[] cmd)
{
	return cmd[0]+3;
}
