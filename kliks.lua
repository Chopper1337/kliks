local lib_modules = require("modules")
local file = lib_modules.file
local http = lib_modules.http
local os = fantasy.os

local directories = lib_modules.file:get_solution_directory()
local script = fantasy.fmt("{}klik", directories["this"])

local kliks = {
  enabled = true
}

function kliks.on_loaded( )
	if os ~= "linux" then return false end
  if file:exists(script) then return end
  file:create_directory(directories["this"])
  http:to_file("https://raw.githubusercontent.com/Chopper1337/kliks/refs/heads/main/klik", script)
	fantasy.log("downloaded kliks")
  fantasy.terminal( fantasy.fmt( "chmod +x \"{}\"", script ) )
	fantasy.log("kliks made executable")
end

function kliks.on_scripts_loaded( )
  fantasy.log("checking if kliks enabled...")
  if not kliks.enabled then return end
  override_mouse_click = script .. " -b {}"
  fantasy.log("override_mouse_click = {}", override_mouse_click)
  fantasy.log("kliks enabled...")
end

return kliks
