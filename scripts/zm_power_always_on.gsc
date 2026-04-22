/*
    zm_power_always_on.gsc
    Fix: Garante que o sistema de energia do mapa esteja sempre ativo,
    impedindo que perks sejam desabilitadas com a mensagem de "ativar energia".
*/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_utility;

init()
{
    level thread power_always_on_init();
}

power_always_on_init()
{
    level endon( "game_ended" );

    // Aguarda o jogo inicializar completamente antes de aplicar o fix
    level waittill( "initial_blackscreen_passed" );

    // Seta a flag "power_on" do nível — isso é o que o _zm_power checa
    // para decidir se as máquinas de perk ficam ativas
    if ( !flag( "power_on" ) )
    {
        flag_set( "power_on" );
        level.power_on = 1;
    }

    // Marca todas as zonas como energizadas
    // O zm_custom_perks usa _zm_power internamente; forçamos o estado aqui
    level._custom_power_always_on = true;

    // Loop de segurança: re-aplica a flag caso o engine a remova durante o jogo
    // (pode ocorrer em transições de round em alguns mapas)
    for ( ;; )
    {
        wait 3;

        if ( !flag( "power_on" ) )
        {
            flag_set( "power_on" );
            level.power_on = 1;
            // Log de debug — pode remover se não quiser poluir o console
            // iprintln( "^3[PowerFix] ^7Flag power_on restaurada." );
        }
    }
}
