local eznpcs = require('scripts/libs/eznpcs/eznpcs')
local ezmemory = require('scripts/libs/ezmemory')
local ezmystery = require('scripts/libs/ezmystery')
--local ezfarms = require('scripts/libs/ezfarms')
local ezweather = require('scripts/libs/ezweather')
local ezwarps = require('scripts/libs/ezwarps/main')

local plugins = {ezweather,eznpcs,ezmemory,ezmystery,ezwarps}

local sfx = {
    hurt='/server/assets/sfx/hurt.ogg',
    item_get='/server/assets/sfx/item_get.ogg',
    recover='/server/assets/sfx/recover.ogg',
    card_error='/server/assets/sfx/card_error.ogg'
}

eznpcs.load_npcs()

--Pass handlers on to all the libraries we are using
function handle_tile_interaction(player_id, x, y, z, button)
    for i,plugin in ipairs(plugins)do
        if plugin.handle_tile_interaction then
            plugin.handle_tile_interaction(player_id, x, y, z, button)
        end
    end
end

function handle_post_selection(player_id, post_id)
    for i,plugin in ipairs(plugins)do
        if plugin.handle_post_selection then
            plugin.handle_post_selection(player_id, post_id)
        end
    end
end

function handle_board_close(player_id)
    for i,plugin in ipairs(plugins)do
        if plugin.handle_board_close then
            plugin.handle_board_close(player_id)
        end
    end
end

function handle_player_join(player_id)
    for i,plugin in ipairs(plugins)do
        if plugin.handle_player_join then
            plugin.handle_player_join(player_id)
        end
    end
    --Provide assets for custom events
    for name,path in pairs(sfx) do
        Net.provide_asset_for_player(player_id, path)
    end
end

function handle_actor_interaction(player_id, actor_id)
    for i,plugin in ipairs(plugins)do
        if plugin.handle_actor_interaction then
            plugin.handle_actor_interaction(player_id,actor_id)
        end
    end
end

function tick(delta_time)
    for i,plugin in ipairs(plugins)do
        if plugin.on_tick then
            plugin.on_tick(delta_time)
        end
    end
end

function handle_player_disconnect(player_id)
    for i,plugin in ipairs(plugins)do
        if plugin.handle_player_disconnect then
            plugin.handle_player_disconnect(player_id)
        end
    end
end
function handle_object_interaction(player_id, object_id)
    for i,plugin in ipairs(plugins)do
        if plugin.handle_object_interaction then
            plugin.handle_object_interaction(player_id,object_id)
        end
    end
end
function handle_player_transfer(player_id)
    for i,plugin in ipairs(plugins)do
        if plugin.handle_player_transfer then
            plugin.handle_player_transfer(player_id)
        end
    end
end
function handle_textbox_response(player_id, response)
    for i,plugin in ipairs(plugins)do
        if plugin.handle_textbox_response then
            plugin.handle_textbox_response(player_id,response)
        end
    end
end

--custom events, remove them if you dont want them.
local event3 = {
    name="RickRolled",
    action=function (npc,player_id,dialogue,relay_object)
        Net.initiate_encounter(player_id, "/server/assets/ultimate_warrior.zip")
    end
}
eznpcs.add_event(event3)
