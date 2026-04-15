init()
{
    level thread onplayerconnect(); 
}

onplayerconnect()
{
    for(;;)
    {
        level waittill("connected", player); 
        player thread onplayerspawned(); 
    }
}

onplayerspawned()
{
    self endon("disconnect"); 
    for(;;)
    {
        self waittill("spawned_player"); 
        
        // Define a névoa como 0 (desativada)
        self setclientdvar("r_fog", "0"); 
        
        // Exibe a mensagem de confirmação no chat do jogador
        self iprintln("^7Fog ^1Removed"); 
    }
}