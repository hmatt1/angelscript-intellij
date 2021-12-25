void GENERIC_CommandDropItem( cClient @client )
{
	client.getEnt().health -= 1;
}
// 1. tmp1 = client.getEnt()
