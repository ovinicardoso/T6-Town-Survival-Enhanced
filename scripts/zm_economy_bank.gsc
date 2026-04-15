#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_score;

init()
{
    level thread watch_chat_commands();
    level thread on_player_connected();
    level thread auto_save_loop();
}

// ──────────────────────────────────────────────────────
//  PERSISTÊNCIA
// ──────────────────────────────────────────────────────

get_bank_dvar( player )
{
    return "bank_" + player.guid;
}

load_bank_balance( player )
{
    dvar = get_bank_dvar( player );
    raw  = getDvar( dvar );
    
    if ( isDefined( raw ) && raw != "" )
    {
        val = int( raw );
        
        if ( val > 0 )
        {
            player.bank_balance = val;
            player iprintln( "^2[Bank]^7 Saldo restaurado: ^3" + player.bank_balance + "^7 pts." );
            return;
        }
    }

    player.bank_balance = 0;
}

log_save( player )
{
    if ( !isDefined( player ) || !isDefined( player.bank_balance ) )
        return;
        
    logprint( "[BANK_SAVE] " + player.guid + "," + player.bank_balance + "\n" );
    setDvar( get_bank_dvar( player ), player.bank_balance );
}

auto_save_loop()
{
    level endon( "game_ended" );

    for(;;)
    {
        wait 60;
        players = get_players();
        for ( i = 0; i < players.size; i++ )
        {
            log_save( players[i] );
        }
    }
}

// ──────────────────────────────────────────────────────
//  EVENTOS
// ──────────────────────────────────────────────────────

on_player_connected()
{
    level endon( "game_ended" );
    
    for(;;)
    {
        level waittill( "connected", player );

        load_bank_balance( player );
        player thread on_player_disconnect();
    }
}

on_player_disconnect()
{
    self waittill( "disconnect" );
    log_save( self );
}

// ──────────────────────────────────────────────────────
//  COMANDOS DE CHAT
// ──────────────────────────────────────────────────────

watch_chat_commands()
{
    level endon( "game_ended" );
    
    for(;;)
    {
        level waittill( "say", message, player );
        
        if ( !isDefined( player ) )
            continue;
            
        if ( getSubStr( message, 0, 1 ) == "\x15" )
        {
            message = getSubStr( message, 1 );
        }
        
        args = strtok( message, " " );
        
        if ( args.size == 0 )
            continue;
            
        cmd = tolower( args[0] );

        if ( cmd == ".help" )
        {
            player iprintln( "^2[Bank]^7 Cmds: ^3.b ^7(saldo), ^3.d <qnt|all>^7, ^3.w <qnt|all>^7, ^3.p <alvo> <qnt>" );
        }
        else if ( cmd == ".b" )
        {
            player iprintln( "^2[Bank]^7 Pontos: ^2" + player.score + "^7 | Banco: ^3" + player.bank_balance );
        }
        else if ( cmd == ".p" )
        {
            player handle_pay( args );
        }
        else if ( cmd == ".d" )
        {
            player handle_deposit( args );
        }
        else if ( cmd == ".w" )
        {
            player handle_withdraw( args );
        }
    }
}

// ──────────────────────────────────────────────────────
//  DEPOSITAR
// ──────────────────────────────────────────────────────

handle_deposit( args )
{
    if ( args.size < 2 )
    {
        self iprintln( "^1[Erro]^7 Uso correto: ^3.d <valor ou all>" );
        return;
    }

    amount = 0;

    if ( tolower( args[1] ) == "all" )
    {
        amount = self.score;
    }
    else
    {
        amount = int( args[1] );
    }

    if ( amount <= 0 )
    {
        self iprintln( "^1[Erro]^7 Valor invalido ou voce nao possui pontos em maos." );
        return;
    }

    if ( self.score < amount )
    {
        self iprintln( "^1[Erro]^7 Voce nao tem pontos suficientes." );
        return;
    }

    self minus_to_player_score( amount );
    self.bank_balance += amount;
    log_save( self );
    self iprintln( "^2[Bank]^7 Deposito: ^3" + amount + "^7. Saldo: ^3" + self.bank_balance );
}

// ──────────────────────────────────────────────────────
//  SACAR
// ──────────────────────────────────────────────────────

handle_withdraw( args )
{
    if ( args.size < 2 )
    {
        self iprintln( "^1[Erro]^7 Uso correto: ^3.w <valor ou all>" );
        return;
    }

    amount = 0;

    if ( tolower( args[1] ) == "all" )
    {
        amount = self.bank_balance;
    }
    else
    {
        amount = int( args[1] );
    }

    if ( amount <= 0 )
    {
        self iprintln( "^1[Erro]^7 Valor invalido ou o seu banco esta vazio." );
        return;
    }

    if ( self.bank_balance < amount )
    {
        self iprintln( "^1[Erro]^7 Saldo insuficiente no banco." );
        return;
    }

    self.bank_balance -= amount;
    self add_to_player_score( amount );
    log_save( self );
    self iprintln( "^2[Bank]^7 Saque: ^3" + amount + "^7. Saldo: ^3" + self.bank_balance );
}

// ──────────────────────────────────────────────────────
//  TRANSFERÊNCIA
// ──────────────────────────────────────────────────────

handle_pay( args )
{
    if ( args.size < 3 )
    {
        self iprintln( "^1[Erro]^7 Uso correto: ^3.p <jogador> <valor>" );
        return;
    }

    target_name = tolower( args[1] );
    amount = int( args[2] );
    
    if ( amount <= 0 )
    {
        self iprintln( "^1[Erro]^7 O valor deve ser um numero maior que 0." );
        return;
    }

    if ( self.score < amount )
    {
        self iprintln( "^1[Erro]^7 Voce nao tem pontos suficientes em maos." );
        return;
    }

    target_player = self find_player_by_name( target_name );
    
    if ( !isDefined( target_player ) )
        return;
        
    if ( target_player == self )
    {
        self iprintln( "^1[Erro]^7 Voce nao pode transferir para si mesmo." );
        return;
    }

    self minus_to_player_score( amount );
    target_player add_to_player_score( amount );
    self iprintln( "^2[Bank]^7 Voce enviou ^3" + amount + "^7 pontos para ^5" + target_player.name );
    target_player iprintln( "^2[Bank]^7 Voce recebeu ^3" + amount + "^7 pontos de ^5" + self.name );
}

// ──────────────────────────────────────────────────────
//  UTILITÁRIO
// ──────────────────────────────────────────────────────

find_player_by_name( target_name )
{
    if ( target_name == "me" ) return self;
    
    matches = [];
    players = get_players();

    for ( i = 0; i < players.size; i++ )
    {
        player = players[i];
        
        if ( isSubStr( tolower( player.name ), target_name ) )
        {
            matches[ matches.size ] = player;
        }
    }

    if ( matches.size == 0 )
    {
        self iprintln( "^1[Erro]^7 Nenhum jogador encontrado com esse nome." );
        return undefined;
    }
    else if ( matches.size > 1 )
    {
        self iprintln( "^1[Erro]^7 Mais de um jogador corresponde. Seja mais especifico." );
        return undefined;
    }

    return matches[0]; 
}