void pickOrDrop(ClientData @client, int slot)
{
    Actor@ player;
    @player=@client.getActor(0);
    if(@player==null)
        return;//no player actor yet

    bool useSecondary;
    int itemInSlot=0;
    if(itemInSlot>=0){
        useSecondary=true;
    }
    else{
        Actor@ p2;
        @p2=@client.getActor(0);
        if(@p2!=null){
            return;
        }
    }
}
