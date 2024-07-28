--- STEAMODDED HEADER
--- MOD_NAME: DVD
--- MOD_ID: DVD
--- MOD_AUTHOR: [stupxd aka stupid]
--- MOD_DESCRIPTION: Add DVD logo
--- PRIORITY: 69
--- BADGE_COLOR: FFD700
--- DISPLAY_NAME: DVD
--- VERSION: 1.0

----------------------------------------------
------------MOD CODE -------------------------

local config = SMODS.current_mod.config

local last_key_press = 0

function display_dvd()
    if not config.enabled then
        return false
    end

    return G.TIMERS.REAL - last_key_press > config.stop_delay
end

SMODS.current_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {r = 0.1, align = "cm", padding = 0.1, colour = G.C.BLACK, minw = 8, minh = 4}, nodes = {
        {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
            {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = localize('DVD_enabled'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT }},
            }},
            {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = config, ref_value = "enabled" },
            }},
        }},
        {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
            {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = localize('DVD_key_press_stop'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT }},
            }},
            {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = config, ref_value = "stop_on_key_press" },
            }},
        }},
        {n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
            {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = localize('DVD_mouse_move_stop'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT }},
            }},
            {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_toggle{ col = true, label = "", scale = 0.85, w = 0, shadow = true, ref_table = config, ref_value = "stop_on_mouse_move" },
            }},
        }},
        {n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
            {n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_slider({label = localize('DVD_stop_delay'), w = 5, h = 0.4, ref_table = config, ref_value = 'stop_delay', min = 0, max = 100}),
            }},
        }},

        
    }}
end


SMODS.Shader {
    key = 'dvd',
    path = 'dvd.fs'
}

local love_mousemoved = love.mousemoved
function love.mousemoved( x, y, dx, dy, istouch )
    if config.stop_on_mouse_move then
        last_key_press = G.TIMERS.REAL
    end

    return love_mousemoved(x, y, dx, dy, istouch)
end

local controller_L_cursor_press = Controller.L_cursor_press
function Controller:L_cursor_press(x, y)
    if config.stop_on_key_press then
        last_key_press = G.TIMERS.REAL
    end

    return controller_L_cursor_press(self, x, y)
end

local controller_key_press_update = Controller.key_press_update
function Controller:key_press_update(key, dt)
    if config.stop_on_key_press then
        last_key_press = G.TIMERS.REAL
    end

    return controller_key_press_update(self, key, dt)
end

local controller_queue_R_cursor_press = Controller.queue_R_cursor_press

function Controller:queue_R_cursor_press(x, y)
    if config.stop_on_key_press then
        last_key_press = G.TIMERS.REAL
    end

    return controller_queue_R_cursor_press(self, x, y)
end

----------------------------------------------
------------MOD CODE END----------------------
