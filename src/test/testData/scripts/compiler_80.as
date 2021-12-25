class SBuilding
{
	void ReleasePeople()
	{
		SPoint cellij;
		if( GetRoadOrFreeCellInAround(cellij) ) {}
	}
	bool GetRoadOrFreeCellInAround(SPoint&out cellij)
	{
		return false;
	}
}
shared class SPoint
{
	SPoint@ opAssign(const SPoint&in assign)
	{
		return this;
	}
}
