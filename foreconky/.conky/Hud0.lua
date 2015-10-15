--==============================================================================
--                              conky_HUD.lua
--
--  author  : Jetsex
--  version : v2011062101
--  license : Distributed under the terms of GNU GPL version 2 or later
--
--==============================================================================

require 'cairo'

--------------------------------------------------------------------------------
--                                                                    gauge DATA
clock_h = {
    {
    name='time',                   arg='%H',                    max_value=12,
    x=910,                         y=105,
    graph_radius=58,
    graph_thickness=3,
    graph_unit_angle=30,           graph_unit_thickness=28,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.0,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.0,
    txt_radius=28,
    txt_weight=1,                  txt_size=36,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.0,
    graduation_radius=57,
    graduation_thickness=4,        graduation_mark_thickness=2,
    graduation_unit_angle=30,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
    },
}
-- MINUTES
clock_m = {
    {
    name='time',                   arg='%M',                    max_value=60,
    x=910,                         y=105,
    graph_radius=62,
    graph_thickness=2,
    graph_unit_angle=6,            graph_unit_thickness=6,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.0,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.0,
    txt_radius=37,
    txt_weight=1,                  txt_size=24.0,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.0,
    graduation_radius=62,
    graduation_thickness=0,        graduation_mark_thickness=2,
    graduation_unit_angle=30,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
    },
}
-- SECONDS
clock_s = {
    {
    name='time',                   arg='%S',                    max_value=60,
    x=910,                         y=105,
    graph_radius=52,
    graph_thickness=3,
    graph_unit_angle=6,            graph_unit_thickness=2,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.0,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.0,
    txt_radius=45,
    txt_weight=0,                  txt_size=15.0,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.0,
    graduation_radius=0,
    graduation_thickness=11,        graduation_mark_thickness=1,
    graduation_unit_angle=1,
    graduation_fg_colour=0x91FF98, graduation_fg_alpha=0.0,
    },
}
gauge = {
{
-- пример дуговидного индикатора с линейкой и надписями
    name='cpu',                    arg='cpu0',                  max_value=100,
-- здесь отображается тот параметр, который мы хотим мониторить. Название (например, cpu), значение (cpu0) и градуировка (100, т.е. 100%)
    x=978,                         y=63,
-- координаты в пространстве рисуемого объекта, а именно, в этой точке располагается центр дуги
    graph_radius=39,
-- радиус дуги индикатора
    graph_thickness=4,
-- высота линии индикатора - насколько толстая будет дуга
    graph_start_angle=300,
-- стартовый угол, от которого рисуется дуга
    graph_unit_angle=2.4,          graph_unit_thickness=2.4,
-- угол и толщина одного деления на индикаторе. От этого зависит, насколько дуга приближается к окружности.
    graph_bg_colour=0x000000,      graph_bg_alpha=0.5,
-- цвет и прозрачность фона дуги
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.8,
-- цвет и прозрачность делений на индикаторе
    hand_fg_colour=0x91FF98,       hand_fg_alpha=0.0,
    txt_radius=49,
--радиус окружности, по которой движется надпись - текст самого индикатора
    txt_weight=0,                  txt_size=15.0,
-- размер и толщина шрифта
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.0,
-- цвет и прозрачность шрифта
    graduation_radius=44,
-- радиус дуги линейки
    graduation_thickness=6,        graduation_mark_thickness=2,
-- высота и толщина линии на измерительной линейке
    graduation_unit_angle=2,
-- эта величина показывает, через какой угол будут располагаться линии разметки
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
-- цвет и прозрачность дуги
    caption='',
-- значение индикаторной линейки (например, км\ч)
    caption_weight=1,              caption_size=8.0,
-- параметри шрифта надписи
    caption_fg_colour=0x91FF98,    caption_fg_alpha=0.7,
-- цвет и прозрачность шрифта
},
{
-- а вот этот кусок дублирует предыдущий, но на самом деле это фикс уебанской градуировки с антиальясингом!
    name='cpu',                    arg='cpu0',                  max_value=100,

    x=978,                         y=63,
    graph_radius=44,
    graph_thickness=6,
    graph_start_angle=300,
    graph_unit_angle=2.4,          graph_unit_thickness=2.4,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.5,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.0,
-- ну вы поняли, второй индикатор выступает в роли градуирующей шкалы, только корректно выглядящей
    hand_fg_colour=0x91FF98,       hand_fg_alpha=0.0,
    txt_radius=49,
    txt_weight=0,                  txt_size=15.0,
-- размер и толщина шрифта, закономерно тут нули
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.8,
    graduation_radius=44,
    graduation_thickness=6,        graduation_mark_thickness=2,
    graduation_unit_angle=2,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
-- линейка тут уже нахуй не нужна
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0x91FF98,    caption_fg_alpha=0.0,
},
{
    name='cpu',                    arg='cpu1',                  max_value=100,
    x=978,                         y=63,
    graph_radius=34,
    graph_thickness=4,
    graph_start_angle=300,
    graph_unit_angle=2.4,          graph_unit_thickness=4,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.4,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.8,
    hand_fg_colour=0x91FF98,       hand_fg_alpha=0.0,
    txt_radius=20,
    txt_weight=0,                  txt_size=15.0,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.00,
    graduation_radius=29,
    graduation_thickness=6,        graduation_mark_thickness=3,
    graduation_unit_angle=2,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0x91FF98,    caption_fg_alpha=0.0,
},
{
    name='cpu',                    arg='cpu1',                  max_value=100,
    x=978,                         y=63,
    graph_radius=29,
    graph_thickness=6,
    graph_start_angle=300,
    graph_unit_angle=2.4,          graph_unit_thickness=4,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.4,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.0,
    hand_fg_colour=0x91FF98,       hand_fg_alpha=0.0,
    txt_radius=20,
    txt_weight=0,                  txt_size=15.0,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.70,
    graduation_radius=29,
    graduation_thickness=6,        graduation_mark_thickness=3,
    graduation_unit_angle=2,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0x91FF98,    caption_fg_alpha=0.0,
},
{
  name='memperc',                arg='',                      max_value=100,
    x=759,                          y=105,
    graph_radius=40,
    graph_thickness=4,
    graph_start_angle=139,
    graph_unit_angle=2.4,          graph_unit_thickness=2.5,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.5,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.8,
    hand_fg_colour=0x91FF98,       hand_fg_alpha=0.0,
    txt_radius=55,
    txt_weight=0,                  txt_size=15.0,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.0,
    graduation_radius=45,
    graduation_thickness=6,        graduation_mark_thickness=3,
    graduation_unit_angle=2,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
    caption='',
    caption_weight=1,              caption_size=36.0,
    caption_fg_colour=0x91FF98,    caption_fg_alpha=0.0,
},
{
  name='memperc',                arg='',                      max_value=100,
    x=759,                          y=105,
    graph_radius=45,
    graph_thickness=6,
    graph_start_angle=139,
    graph_unit_angle=2.4,          graph_unit_thickness=2.5,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.5,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.0,
    hand_fg_colour=0x91FF98,       hand_fg_alpha=0.0,
    txt_radius=55,
    txt_weight=0,                  txt_size=15.0,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.8,
    graduation_radius=45,
    graduation_thickness=6,        graduation_mark_thickness=3,
    graduation_unit_angle=2,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
    caption='',
    caption_weight=1,              caption_size=36.0,
    caption_fg_colour=0x91FF98,    caption_fg_alpha=0.0,
},
{
    name='fs_used_perc',           arg='/',                     max_value=100,
    x=832,                         y=90,
    graph_radius=45,
    graph_thickness=3,
    graph_start_angle=164,
    graph_unit_angle=2.37,            graph_unit_thickness=3,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.4,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.8,
    hand_fg_colour=0x91FF98,       hand_fg_alpha=0.0,
    txt_radius=32,
    txt_weight=0,                  txt_size=15.0,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.0,
    graduation_radius=40,
    graduation_thickness=7,        graduation_mark_thickness=2,
    graduation_unit_angle=2,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0,
},
{
    name='fs_used_perc',           arg='/',                     max_value=100,
    x=832,                         y=90,
    graph_radius=40,
    graph_thickness=7,
    graph_start_angle=164,
    graph_unit_angle=2.37,            graph_unit_thickness=3,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.4,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.0,
    hand_fg_colour=0x91FF98,       hand_fg_alpha=0.0,
    txt_radius=32,
    txt_weight=0,                  txt_size=15.0,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.8,
    graduation_radius=40,
    graduation_thickness=7,        graduation_mark_thickness=2,
    graduation_unit_angle=2,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
    caption='',
    caption_weight=1,              caption_size=8.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.0,
},
{
    name='fs_used_perc',           arg='/home/',                max_value=100,
    x=832,                         y=90,
    graph_radius=50,
    graph_thickness=4,
    graph_start_angle=164,
    graph_unit_angle=1.19,            graph_unit_thickness=2,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.5,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.8,
    hand_fg_colour=0x91FF98,       hand_fg_alpha=0.0,
    txt_radius=63,
    txt_weight=0,                  txt_size=15.0,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.0,
    graduation_radius=58,
    graduation_thickness=12,        graduation_mark_thickness=2,
    graduation_unit_angle=2,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
    caption='',
    caption_weight=1,              caption_size=48.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.0,
},
{
    name='fs_used_perc',           arg='/home/',                max_value=100,
    x=832,                         y=90,
    graph_radius=58,
    graph_thickness=12,
    graph_start_angle=164,
    graph_unit_angle=1.19,            graph_unit_thickness=2,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.5,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.0,
    hand_fg_colour=0x91FF98,       hand_fg_alpha=0.0,
    txt_radius=63,
    txt_weight=0,                  txt_size=15.0,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.8,
    graduation_radius=58,
    graduation_thickness=12,        graduation_mark_thickness=2,
    graduation_unit_angle=2,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
    caption='',
    caption_weight=1,              caption_size=48.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.0,
},
{
    name='fs_used_perc',           arg='/tmp',                max_value=100,
    x=832,                         y=90,
    graph_radius=50,
    graph_thickness=4,
    graph_start_angle=285,
    graph_unit_angle=1.165,            graph_unit_thickness=2,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.5,
    graph_fg_colour=0x91FF98,      graph_fg_alpha=0.8,
    hand_fg_colour=0x91FF98,       hand_fg_alpha=0.0,
    txt_radius=63,
    txt_weight=0,                  txt_size=15.0,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.8,
    graduation_radius=58,
    graduation_thickness=12,        graduation_mark_thickness=1,
    --graduation_start_angle=285
    graduation_unit_angle=1,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
    caption='',
    caption_weight=1,              caption_size=48.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.3,
},
{
    name='fs_used_perc',           arg='/tmp',                max_value=100,
    x=832,                         y=90,
    graph_radius=58,
    graph_thickness=12,
    graph_start_angle=285,
    graph_unit_angle=1.165,            graph_unit_thickness=2,
    graph_bg_colour=0x000000,      graph_bg_alpha=0.5,
    graph_fg_colour=0x000000,      graph_fg_alpha=0.0,
    hand_fg_colour=0x000000,       hand_fg_alpha=0.0,
    txt_radius=63,
    txt_weight=0,                  txt_size=15.0,
    txt_fg_colour=0x91ff98,        txt_fg_alpha=0.0,
    graduation_radius=58,
    graduation_thickness=1,        graduation_mark_thickness=1,
    --graduation_start_angle=285
    graduation_unit_angle=1,
    graduation_fg_colour=0x000000, graduation_fg_alpha=0.0,
    caption='',
    caption_weight=1,              caption_size=48.0,
    caption_fg_colour=0xFFFFFF,    caption_fg_alpha=0.0,
},
}

-------------------------------------------------------------------------------
--                                                                 rgb_to_r_g_b
-- converts color in hexa to decimal
--
function rgb_to_r_g_b(colour, alpha)
    return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

-------------------------------------------------------------------------------
--                                                            angle_to_position
-- convert degree to rad and rotate (0 degree is top/north)
--
function angle_to_position(start_angle, current_angle)
    local pos = current_angle + start_angle
    return ( ( pos * (2 * math.pi / 360) ) - (math.pi / 2) )
end

-------------------------------------------------------------------------------
--                                                              draw_gauge_ring
-- displays gauges
--
function draw_gauge_ring(display, data, value)
    local max_value = data['max_value']
    local x, y = data['x'], data['y']
    local graph_radius = data['graph_radius']
    local graph_thickness, graph_unit_thickness = data['graph_thickness'], data['graph_unit_thickness']
    local graph_start_angle = data['graph_start_angle']
    local graph_unit_angle = data['graph_unit_angle']
    local graph_bg_colour, graph_bg_alpha = data['graph_bg_colour'], data['graph_bg_alpha']
    local graph_fg_colour, graph_fg_alpha = data['graph_fg_colour'], data['graph_fg_alpha']
    local hand_fg_colour, hand_fg_alpha = data['hand_fg_colour'], data['hand_fg_alpha']
    local graph_end_angle = (max_value * graph_unit_angle) % 360

    -- background ring
    cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, 0), angle_to_position(graph_start_angle, graph_end_angle))
    cairo_set_source_rgba(display, rgb_to_r_g_b(graph_bg_colour, graph_bg_alpha))
    cairo_set_line_width(display, graph_thickness)
    cairo_stroke(display)

    -- arc of value
    local val = value % (max_value + 1)
    local start_arc = 0
    local stop_arc = 0
    local i = 1
    while i <= val do
        start_arc = (graph_unit_angle * i) - graph_unit_thickness
        stop_arc = (graph_unit_angle * i)
        cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
        cairo_set_source_rgba(display, rgb_to_r_g_b(graph_fg_colour, graph_fg_alpha))
        cairo_stroke(display)
        i = i + 1
    end
    local angle = start_arc

    -- hand
    start_arc = (graph_unit_angle * val) - (graph_unit_thickness * 2)
    stop_arc = (graph_unit_angle * val)
    cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
    cairo_set_source_rgba(display, rgb_to_r_g_b(hand_fg_colour, hand_fg_alpha))
    cairo_stroke(display)

    -- graduations marks
    local graduation_radius = data['graduation_radius']
    local graduation_thickness, graduation_mark_thickness = data['graduation_thickness'], data['graduation_mark_thickness']
    local graduation_unit_angle = data['graduation_unit_angle']
    local graduation_fg_colour, graduation_fg_alpha = data['graduation_fg_colour'], data['graduation_fg_alpha']
    if graduation_radius > 0 and graduation_thickness > 0 and graduation_unit_angle > 0 then
        local nb_graduation = graph_end_angle / graduation_unit_angle
        local i = 0
        while i < nb_graduation do
            cairo_set_line_width(display, graduation_thickness)
            start_arc = (graduation_unit_angle * i) - (graduation_mark_thickness / 2)
            stop_arc = (graduation_unit_angle * i) + (graduation_mark_thickness / 2)
            cairo_arc(display, x, y, graduation_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
            cairo_set_source_rgba(display,rgb_to_r_g_b(graduation_fg_colour,graduation_fg_alpha))
            cairo_stroke(display)
            cairo_set_line_width(display, graph_thickness)
            i = i + 1
        end
    end

    -- text
    local txt_radius = data['txt_radius']
    local txt_weight, txt_size = data['txt_weight'], data['txt_size']
    local txt_fg_colour, txt_fg_alpha = data['txt_fg_colour'], data['txt_fg_alpha']
    local movex = txt_radius * math.cos(angle_to_position(graph_start_angle, angle))
    local movey = txt_radius * math.sin(angle_to_position(graph_start_angle, angle))
    cairo_select_font_face (display, "ds-digital", CAIRO_FONT_SLANT_NORMAL, txt_weight)
    cairo_set_font_size (display, txt_size)
    cairo_set_source_rgba (display, rgb_to_r_g_b(txt_fg_colour, txt_fg_alpha))
    cairo_move_to (display, x + movex - (txt_size / 2), y + movey + 3)
    cairo_show_text (display, value)
    cairo_stroke (display)

    -- caption
    local caption = data['caption']
    local caption_weight, caption_size = data['caption_weight'], data['caption_size']
    local caption_fg_colour, caption_fg_alpha = data['caption_fg_colour'], data['caption_fg_alpha']
    local tox = graph_radius * (math.cos((graph_start_angle * 2 * math.pi / 360)-(math.pi/2)))
    local toy = graph_radius * (math.sin((graph_start_angle * 2 * math.pi / 360)-(math.pi/2)))
    cairo_select_font_face (display, "ds-digital", CAIRO_FONT_SLANT_NORMAL, caption_weight);
    cairo_set_font_size (display, caption_size)
    cairo_set_source_rgba (display, rgb_to_r_g_b(caption_fg_colour, caption_fg_alpha))
    cairo_move_to (display, x + tox + 5, y + toy + 1)
    -- bad hack but not enough time !
    if graph_start_angle < 105 then
        cairo_move_to (display, x + tox - 30, y + toy + 1)
    end
    cairo_show_text (display, caption)
    cairo_stroke (display)
end

-------------------------------------------------------------------------------
--                                                               go_gauge_rings
-- loads data and displays gauges
--
function go_gauge_rings(display)
    local function load_gauge_rings(display, data)
        local str, value = '', 0
        str = string.format('${%s %s}',data['name'], data['arg'])
        str = conky_parse(str)
        value = tonumber(str)
        draw_gauge_ring(display, data, value)
    end
    
    for i in pairs(gauge) do
        load_gauge_rings(display, gauge[i])
    end
end

-------------------------------------------------------------------------------
--                                                                         MAIN
function conky_main()
    if conky_window == nil then 
        return
    end


    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local display = cairo_create(cs)
    
    local updates = conky_parse('${updates}')
    update_num = tonumber(updates)
    
    if update_num > 5 then
        go_gauge_rings(display)
    end
    
    cairo_surface_destroy(cs)
    cairo_destroy(display)
end
-------------------------------------------------------------------------------
--                                                              draw_clock_ring
-- displays clock
--
function draw_clock_ring(display, data, value)
    local max_value = data['max_value']
    local x, y = data['x'], data['y']
    local graph_radius = data['graph_radius']
    local graph_thickness, graph_unit_thickness = data['graph_thickness'], data['graph_unit_thickness']
    local graph_unit_angle = data['graph_unit_angle']
    local graph_bg_colour, graph_bg_alpha = data['graph_bg_colour'], data['graph_bg_alpha']
    local graph_fg_colour, graph_fg_alpha = data['graph_fg_colour'], data['graph_fg_alpha']

    -- background ring
    cairo_arc(display, x, y, graph_radius, 0, 2 * math.pi)
    cairo_set_source_rgba(display, rgb_to_r_g_b(graph_bg_colour, graph_bg_alpha))
    cairo_set_line_width(display, graph_thickness)
    cairo_stroke(display)

    -- arc of value
    local val = (value % max_value)
    local i = 1
    while i <= val do
        cairo_arc(display, x, y, graph_radius,(  ((graph_unit_angle * i) - graph_unit_thickness)*(2*math.pi/360)  )-(math.pi/2),((graph_unit_angle * i) * (2*math.pi/360))-(math.pi/2))
        cairo_set_source_rgba(display,rgb_to_r_g_b(graph_fg_colour,graph_fg_alpha))
        cairo_stroke(display)
        i = i + 1
    end
    local angle = (graph_unit_angle * i) - graph_unit_thickness

    -- graduations marks
    local graduation_radius = data['graduation_radius']
    local graduation_thickness, graduation_mark_thickness = data['graduation_thickness'], data['graduation_mark_thickness']
    local graduation_unit_angle = data['graduation_unit_angle']
    local graduation_fg_colour, graduation_fg_alpha = data['graduation_fg_colour'], data['graduation_fg_alpha']
    if graduation_radius > 0 and graduation_thickness > 0 and graduation_unit_angle > 0 then
        local nb_graduation = 360 / graduation_unit_angle
        local i = 1
        while i <= nb_graduation do
            cairo_set_line_width(display, graduation_thickness)
            cairo_arc(display, x, y, graduation_radius, (((graduation_unit_angle * i)-(graduation_mark_thickness/2))*(2*math.pi/360))-(math.pi/2),(((graduation_unit_angle * i)+(graduation_mark_thickness/2))*(2*math.pi/360))-(math.pi/2))
            cairo_set_source_rgba(display,rgb_to_r_g_b(graduation_fg_colour,graduation_fg_alpha))
            cairo_stroke(display)
            cairo_set_line_width(display, graph_thickness)
            i = i + 1
        end
    end

    -- text
    local txt_radius = data['txt_radius']
    local txt_weight, txt_size = data['txt_weight'], data['txt_size']
    local txt_fg_colour, txt_fg_alpha = data['txt_fg_colour'], data['txt_fg_alpha']
    local movex = txt_radius * (math.cos((angle * 2 * math.pi / 360)-(math.pi/2)))
    local movey = txt_radius * (math.sin((angle * 2 * math.pi / 360)-(math.pi/2)))
    cairo_select_font_face (display, "ds-digital", CAIRO_FONT_SLANT_NORMAL, txt_weight);
    cairo_set_font_size (display, txt_size);
    cairo_set_source_rgba (display, rgb_to_r_g_b(txt_fg_colour, txt_fg_alpha));
    cairo_move_to (display, x + movex - (txt_size / 2), y + movey + 3);
    cairo_show_text (display, value);
    cairo_stroke (display);
end

-------------------------------------------------------------------------------
--                                                              draw_gauge_ring
-- displays gauges
--
function draw_gauge_ring(display, data, value)
    local max_value = data['max_value']
    local x, y = data['x'], data['y']
    local graph_radius = data['graph_radius']
    local graph_thickness, graph_unit_thickness = data['graph_thickness'], data['graph_unit_thickness']
    local graph_start_angle = data['graph_start_angle']
    local graph_unit_angle = data['graph_unit_angle']
    local graph_bg_colour, graph_bg_alpha = data['graph_bg_colour'], data['graph_bg_alpha']
    local graph_fg_colour, graph_fg_alpha = data['graph_fg_colour'], data['graph_fg_alpha']
    local hand_fg_colour, hand_fg_alpha = data['hand_fg_colour'], data['hand_fg_alpha']
    local graph_end_angle = (max_value * graph_unit_angle) % 360

    -- background ring
    cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, 0), angle_to_position(graph_start_angle, graph_end_angle))
    cairo_set_source_rgba(display, rgb_to_r_g_b(graph_bg_colour, graph_bg_alpha))
    cairo_set_line_width(display, graph_thickness)
    cairo_stroke(display)

    -- arc of value
    local val = value % (max_value + 1)
    local start_arc = 0
    local stop_arc = 0
    local i = 1
    while i <= val do
        start_arc = (graph_unit_angle * i) - graph_unit_thickness
        stop_arc = (graph_unit_angle * i)
        cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
        cairo_set_source_rgba(display, rgb_to_r_g_b(graph_fg_colour, graph_fg_alpha))
        cairo_stroke(display)
        i = i + 1
    end
    local angle = start_arc

    -- hand
    start_arc = (graph_unit_angle * val) - (graph_unit_thickness * 2)
    stop_arc = (graph_unit_angle * val)
    cairo_arc(display, x, y, graph_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
    cairo_set_source_rgba(display, rgb_to_r_g_b(hand_fg_colour, hand_fg_alpha))
    cairo_stroke(display)

    -- graduations marks
    local graduation_radius = data['graduation_radius']
    local graduation_thickness, graduation_mark_thickness = data['graduation_thickness'], data['graduation_mark_thickness']
    local graduation_unit_angle = data['graduation_unit_angle']
    local graduation_fg_colour, graduation_fg_alpha = data['graduation_fg_colour'], data['graduation_fg_alpha']
    if graduation_radius > 0 and graduation_thickness > 0 and graduation_unit_angle > 0 then
        local nb_graduation = graph_end_angle / graduation_unit_angle
        local i = 0
        while i < nb_graduation do
            cairo_set_line_width(display, graduation_thickness)
            start_arc = (graduation_unit_angle * i) - (graduation_mark_thickness / 2)
            stop_arc = (graduation_unit_angle * i) + (graduation_mark_thickness / 2)
            cairo_arc(display, x, y, graduation_radius, angle_to_position(graph_start_angle, start_arc), angle_to_position(graph_start_angle, stop_arc))
            cairo_set_source_rgba(display,rgb_to_r_g_b(graduation_fg_colour,graduation_fg_alpha))
            cairo_stroke(display)
            cairo_set_line_width(display, graph_thickness)
            i = i + 1
        end
    end

    -- text
    local txt_radius = data['txt_radius']
    local txt_weight, txt_size = data['txt_weight'], data['txt_size']
    local txt_fg_colour, txt_fg_alpha = data['txt_fg_colour'], data['txt_fg_alpha']
    local movex = txt_radius * math.cos(angle_to_position(graph_start_angle, angle))
    local movey = txt_radius * math.sin(angle_to_position(graph_start_angle, angle))
    cairo_select_font_face (display, "ds-digital", CAIRO_FONT_SLANT_NORMAL, txt_weight)
    cairo_set_font_size (display, txt_size)
    cairo_set_source_rgba (display, rgb_to_r_g_b(txt_fg_colour, txt_fg_alpha))
    cairo_move_to (display, x + movex - (txt_size / 2), y + movey + 3)
    cairo_show_text (display, value)
    cairo_stroke (display)

    -- caption
    local caption = data['caption']
    local caption_weight, caption_size = data['caption_weight'], data['caption_size']
    local caption_fg_colour, caption_fg_alpha = data['caption_fg_colour'], data['caption_fg_alpha']
    local tox = graph_radius * (math.cos((graph_start_angle * 2 * math.pi / 360)-(math.pi/2)))
    local toy = graph_radius * (math.sin((graph_start_angle * 2 * math.pi / 360)-(math.pi/2)))
    cairo_select_font_face (display, "ds-digital", CAIRO_FONT_SLANT_NORMAL, caption_weight);
    cairo_set_font_size (display, caption_size)
    cairo_set_source_rgba (display, rgb_to_r_g_b(caption_fg_colour, caption_fg_alpha))
    cairo_move_to (display, x + tox + 5, y + toy + 1)
    -- bad hack but not enough time !
    if graph_start_angle < 105 then
        cairo_move_to (display, x + tox - 30, y + toy + 1)
    end
    cairo_show_text (display, caption)
    cairo_stroke (display)
end

-------------------------------------------------------------------------------
--                                                               go_clock_rings
-- loads data and displays clock
--
function go_clock_rings(display)
    local function load_clock_rings(display, data)
        local str, value = '', 0
        str = string.format('${%s %s}',data['name'], data['arg'])
        str = conky_parse(str)
        value = tonumber(str)
        draw_clock_ring(display, data, value)
    end
    
    for i in pairs(clock_h) do
        load_clock_rings(display, clock_h[i])
    end
    for i in pairs(clock_m) do
        load_clock_rings(display, clock_m[i])
    end
    for i in pairs(clock_s) do
        load_clock_rings(display, clock_s[i])
    end
end

-------------------------------------------------------------------------------
--                                                               go_gauge_rings
-- loads data and displays gauges
--
function go_gauge_rings(display)
    local function load_gauge_rings(display, data)
        local str, value = '', 0
        str = string.format('${%s %s}',data['name'], data['arg'])
        str = conky_parse(str)
        value = tonumber(str)
        draw_gauge_ring(display, data, value)
    end
    
    for i in pairs(gauge) do
        load_gauge_rings(display, gauge[i])
    end
end

-------------------------------------------------------------------------------
--                                                                         MAIN
function conky_main()
    if conky_window == nil then 
        return
    end

    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    local display = cairo_create(cs)
    
    local updates = conky_parse('${updates}')
    update_num = tonumber(updates)
    
    if update_num > 5 then
        go_clock_rings(display)
        go_gauge_rings(display)
    end
    
    cairo_surface_destroy(cs)
    cairo_destroy(display)
end

		--point A 
		local angle_a
	
		if t.cap == "p" then 
			angle_a = int_delta
			if t.inverse_arc and type_arc ~="bg" then
				angle_a = angle-int_angle-int_delta
			end
			if not(t.inverse_arc) and type_arc =="bg" then
				angle_a = int_delta+int_angle
			end
		else --t.cap=="r"
			angle_a = ext_delta
			if t.inverse_arc and type_arc~="bg" then
				angle_a = angle-ext_angle-ext_delta
			end
			if not(t.inverse_arc) and type_arc=="bg" then
				angle_a = ext_delta+ext_angle
			end
		end
		local ax,ay = ri*math.cos(angle_a),ri*math.sin(angle_a)


		--point B
		local angle_b = ext_delta
		if t.cap == "p" then 
			if t.inverse_arc and type_arc ~="bg" then
				angle_b = angle-ext_angle-ext_delta
			end
			if not(t.inverse_arc) and type_arc=="bg" then
				angle_b = ext_delta+ext_angle
			end
		else
			if t.inverse_arc and type_arc ~="bg" then
				angle_b = angle-ext_angle-ext_delta
			end
			if not(t.inverse_arc) and type_arc=="bg" then
				angle_b = ext_delta+ext_angle
			end
		end
		local bx,by = re*math.cos(angle_b),re*math.sin(angle_b)

		-- EXTERNAL ARC B --> C
		local b0,b1
		if t.inverse_arc then
			if type_arc=="bg" then
				b0,b1= ext_delta, angle-ext_delta-ext_angle
			else
				b0,b1= angle-ext_angle-ext_delta, angle-ext_delta
			end
		else
			if type_arc=="bg" then
				b0,b1= ext_delta+ext_angle, angle-ext_delta
			else
				b0,b1= ext_delta, ext_angle+ext_delta
			end
		end
		
		---POINT D
		local angle_c, angle_d
		if t.cap == "p" then 
			angle_d = angle-int_delta
			if t.inverse_arc and type_arc=="bg" then
				angle_d = angle-int_delta-int_angle	
			end
			if not(t.inverse_arc) and type_arc~="bg" then
				angle_d=int_delta+int_angle
			end
		else
			angle_d = angle-ext_delta
			if t.inverse_arc and type_arc=="bg" then
				angle_d =angle-ext_delta-ext_angle
			end
			if not(t.inverse_arc) and type_arc~="bg" then
				angle_d = ext_angle+ext_delta
			end
		end
		local dx,dy = ri*math.cos(angle_d),ri*math.sin(angle_d)
		
		-- INTERNAL ARC D --> A
		local d0,d1
		if t.cap=="p" then	
			if t.inverse_arc then	
				if type_arc=="bg" then
					d0,d1= angle-int_delta-int_angle,int_delta
				else
					d0,d1= angle-int_delta, angle- int_angle-int_delta
				end
			else
				if type_arc=="bg" then
					d0,d1= angle-int_delta, int_delta+int_angle
				else
					d0,d1= int_delta+int_angle, int_delta
				end
			end
		else
			if t.inverse_arc then	
				if type_arc=="bg" then	
					d0,d1= angle-ext_delta-ext_angle,ext_delta
				else
					d0,d1= angle-ext_delta, angle- ext_angle-ext_delta
				end
			else
				if type_arc=="bg" then	
					d0,d1= angle-ext_delta,ext_delta+ext_angle
				else	
					d0,d1= ext_angle+ext_delta, ext_delta
				end
			end			
		end
			
