--[[
Ring Meters by londonali1010 (2009)

This script draws percentage meters as rings. It is fully customisable; all options are described in the script.

IMPORTANT: if you are using the 'cpu' function, it will cause a segmentation fault if it tries to draw a ring straight away. The if statement near the end of the script uses a delay to make sure that this doesn't happen. It calculates the length of the delay by the number of updates since Conky started. Generally, a value of 5s is long enough, so if you update Conky every 1s, use update_num > 5 in that if statement (the default). If you only update Conky every 2s, you should change it to update_num > 3; conversely if you update Conky every 0.5s, you should use update_num > 10. ALSO, if you change your Conky, is it best to use "killall conky; conky" to update it, otherwise the update_num will not be reset and you will get an error.

To call this script in Conky, use the following (assuming that you save this script to ~/scripts/rings.lua):
	lua_load ~/scripts/rings-v1.2.1.lua
	lua_draw_hook_pre ring_stats
	
Changelog:
+ v1.2.1 -- Fixed minor bug that caused script to crash if conky_parse() returns a nil value (20.10.2009)
+ v1.2 -- Added option for the ending angle of the rings (07.10.2009)
+ v1.1 -- Added options for the starting angle of the rings, and added the "max" variable, to allow for variables that output a numerical value rather than a percentage (29.09.2009)
+ v1.0 -- Original release (28.09.2009)
]]
-- corner_r=20
-- Set the colour and transparency (alpha) of your background.
bg_colour='00000000'
bgrnd_alpha=0.8

-- cairo_pattern_t *pat;
require 'cairo'

settings_table = {
    
    {
        name='cpu',
        arg='cpu0',
        max=100,
        bg_colour=0x1aeeeeee,
        bg_alpha=0.1,
        fg_colour=0xe6a6a6cc,
        fg_alpha=0.9,
        x=100, y=175,
        radius=70,
        thickness=20,
        start_angle=90,
        end_angle=360
    },
    {
        name='memperc',
        arg='',
        max=100,
        -- fg_colour=0x1ae0e0e0,
        fg_alpha=0.8,
        fg_colour=0xe6a6a6cc,
        bg_colour=0x40e0e0e0,
        bg_alpha=0.2,
        x=100, y=175,
        radius=50,
        thickness=16,
        start_angle=90,
        end_angle=360
    },
    {
        name='cpu',
        arg='cpu1',
        max=100,
        fg_colour=0xff6a839d,
        fg_alpha=0.95,
        bg_colour=0xe6383838,
        bg_alpha=0.6,
        -- fg_colour=0x1FFFFFF,
        -- fg_alpha=0.8,
        x=200, y=145,
        radius=95,
        thickness=15,
        start_angle=90,
        end_angle=204
    },
    {
        name='cpu',
        arg='cpu2',
        max=100,
        fg_colour=0xff596f85,
        fg_alpha=0.95,
        bg_colour=0xe6383838,
        bg_alpha=0.52,
        -- fg_colour=0x1FFFFFF,
        -- fg_alpha=0.8,
        x=200, y=145,
        radius=80,
        thickness=12,
        start_angle=90,
        end_angle=204
    },
    {
        name='cpu',
        arg='cpu3',
        max=100,
        fg_colour=0xff48596b,
        fg_alpha=0.95,
        bg_colour=0xe6383838,
        bg_alpha=0.4,
        -- fg_colour=0x1FFFFFF,i
        -- fg_alpha=0.8,
        x=200, y=145,
        radius=67,
        thickness=11,
        start_angle=90,
        end_angle=204
    },
    {
        name='cpu',
        arg='cpu4',
        max=100,
        bg_colour=0xe6383838,
        bg_alpha=0.1,
        fg_colour=0xff455566,
        fg_alpha=0.95,
        -- fg_colour=0x1FFFFFF,
        -- fg_alpha=0.8,
        x=200, y=145,
        radius=54,
        thickness=10,
        start_angle=90,
        end_angle=204
    },
    --     {
    --     name='swapperc',
    --     arg='',
    --     max=100,
    --     bg_colour=0x0e0e0e0,
    --     bg_alpha=0.4,
    --     fg_colour=0x1FFFFFF,
    --     fg_alpha=0.8,
    --     x=315, y=120,
    --     radius=35,
    --     thickness=10,
    --     start_angle=90,
    --     end_angle=360
    -- },
    {
        name='fs_used_perc',
        arg='/',
        max=100,
        bg_colour=0xd9e0e0e0,
        bg_alpha=0.3,
        fg_colour=0xe6a6a6cc,
        fg_alpha=0.7,
        x=100, y=175,
        radius=32,
        thickness=15,
        start_angle=90,
        end_angle=360
    },
    -- {
    --     name='fs_used_perc',
    --     arg='/home',
    --     max=100,
    --     bg_colour=0x0e0e0e0,
    --     bg_alpha=0.6,
    --     fg_colour=0x1FFFFFF,
    --     fg_alpha=0.8,
    --     x=220, y=340,
    --     radius=25,
    --     thickness=10,
    --     start_angle=0,
    --     end_angle=270
    -- },
    -- {
    --     name='fs_used_perc',
    --     arg='/media/usb0',
    --     max=100,
    --     bg_colour=0x0e0e0e0,
    --     bg_alpha=0.4,
    --     fg_colour=0x1FFFFFF,
    --     fg_alpha=0.8,
    --     x=220, y=340,
    --     radius=15,
    --     thickness=5,
    --     start_angle=0,
    --     end_angle=270
    -- },
    {
        name='downspeedf',
        arg='wlan0',
        max=1300,
        bg_colour=0x0e0e0e0,
        bg_alpha=0.1,
        fg_colour=0xff1f68a1,
        fg_alpha=0.8,
        x=365, y=330,
        radius=60,
        thickness=20,
        start_angle=0,
        end_angle=270
    },
    {
        name='upspeedf',
        arg='wlan0',
        max=100,
        bg_colour=0x0e0e0e0,
        bg_alpha=0.2,
        fg_colour=0xffffffff,
        fg_alpha=0.95,
        x=365, y=330,
        radius=40,
        thickness=15,
        start_angle=0,
        end_angle=270
    },
    -- {
    --     name='time',
    --     arg='%S',
    --     max=60,
    --     bg_colour=0x0e0e0e0,
    --     bg_alpha=0.5,
    --     fg_colour=0x1FFFFFF,
    --     fg_alpha=0.8,
    --     x=160, y=415,
    --     radius=30,
    --     thickness=12,
    --     start_angle=180,
    --     end_angle=450
    -- },
    --  {
    --     name='time',
    --     arg='%M',
    --     max=60,
    --     bg_colour=0x0e0e0e0,
    --     bg_alpha=0.6,
    --     fg_colour=0x1FFFFFF,
    --     fg_alpha=0.8,
    --     x=160, y=415,
    --     radius=18,
    --     thickness=8,
    --     start_angle=180,
    --     end_angle=450
    -- },
    -- {
    --     name='time',
    --     arg='%H',
    --     max=24,
    --     bg_colour=0x0FFFFFF,
    --     bg_alpha=0.4,
    --     fg_colour=0x1e0e0e0,
    --     fg_alpha=0.8,
    --     x=160, y=415,
    --     radius=10,
    --     thickness=4,
    --     start_angle=180,
    --     end_angle=450
    -- },
       {
        name='battery_percent',
        arg='BAT1',
        max=100,
        bg_colour=0x0FFFFFF,
        bg_alpha=0.05,
        fg_colour=0xe6a6a6cc,
        fg_alpha=0.8,
        x=100, y=175,
        radius=16,
        thickness=10,
        start_angle=90,
        end_angle=360
    },
    -- {
    --     name='',
    --     arg='',
    --     max=100,
    --     bg_colour=0x0e0e0e0,
    --     bg_alpha=0.6,
    --     fg_colour=0x1FFFFFF,
    --     fg_alpha=0.6,
    --     x=190, y=505,
    --     radius=3,
    --     thickness=13,
    --     start_angle=0,
    --     end_angle=360
    -- },
}

-- require 'cairo'

function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
	local w,h=conky_window.width,conky_window.height
	
	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']
    local fgG = pt['fg_gradient']
    local bgG = pt['bg_gradient']

	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)

	-- Draw background ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)
	
	-- Draw indicator ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
    
    if fgG == nil then
	    cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	    cairo_stroke(cr)		
    else

        pat = cairo_pattern_create_linear(0.0, 0.0, 0.0, 256.0);
        cairo_pattern_add_color_stop_rgba(pat, 1, rgb_to_r_g_b(fgc,fga));
        cairo_pattern_add_color_stop_rgba(pat, 0, rgb_to_r_g_b(fgG,fga));
        cairo_set_source(cr, pat);
        cairo_stroke(cr);
        -- cairo_pattern_destory(pat);
    end

end

function conky_ring_stats()
	local function setup_rings(cr,pt)
		local str=''
		local value=0
		
		str=string.format('${%s %s}',pt['name'],pt['arg'])
		str=conky_parse(str)
		
		value=tonumber(str)
		if value == nil then value = 0 end
		pct=value/pt['max']
		
        -- drawBg()
		draw_ring(cr,pct,pt)
	end

    local corner_r = 20
	if conky_window==nil then return end

    local w=conky_window.width
    local h=conky_window.height

	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, w, h)
	
	local cr=cairo_create(cs)	

	
	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)
	

    cairo_move_to(cr,corner_r,0)
    cairo_line_to(cr,w-corner_r,0)
    cairo_curve_to(cr,w,0,w,0,w,corner_r)
    cairo_line_to(cr,w,h-corner_r)
    cairo_curve_to(cr,w,h,w,h,w-corner_r,h)
    cairo_line_to(cr,corner_r,h)
    cairo_curve_to(cr,0,h,0,h,0,h-corner_r)
    cairo_line_to(cr,0,corner_r)
    cairo_curve_to(cr,0,0,0,0,corner_r,0)
    cairo_close_path(cr)

    cairo_set_source_rgba(cr,rgb_to_r_g_b(bg_colour,bgrnd_alpha))
    cairo_fill(cr)



	if update_num>5 then
		for i in pairs(settings_table) do
			setup_rings(cr,settings_table[i])
		end
	end


   cairo_surface_destroy(cs)
  cairo_destroy(cr)
end

function drawBg()
    if conky_window==nil then return end
    local w=conky_window.width
    local h=conky_window.height
    local cs=cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, w, h)
    cr=cairo_create(cs)

    cairo_move_to(cr,corner_r,0)
    cairo_line_to(cr,w-corner_r,0)
    cairo_curve_to(cr,w,0,w,0,w,corner_r)
    cairo_line_to(cr,w,h-corner_r)
    cairo_curve_to(cr,w,h,w,h,w-corner_r,h)
    cairo_line_to(cr,corner_r,h)
    cairo_curve_to(cr,0,h,0,h,0,h-corner_r)
    cairo_line_to(cr,0,corner_r)
    cairo_curve_to(cr,0,0,0,0,corner_r,0)
    cairo_close_path(cr)

    cairo_set_source_rgba(cr,rgb_to_r_g_b(bg_colour,bgrnd_alpha))
    cairo_fill(cr)
    cairo_surface_destroy(cs)

end
