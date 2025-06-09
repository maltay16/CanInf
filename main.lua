SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
}):register()

SMODS.Atlas({
    key = "Megas_CI",
    path = "Megas_CI.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "pokedex_1",
    path = "pokedex_1.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "pokedex_8",
    path = "pokedex_8.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "shiny_Megas_CI",
    path = "shiny_Megas_CI.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "shiny_pokedex_1",
    path = "shiny_pokedex_1.png",
    px = 71,
    py = 95
}):register()

SMODS.Atlas({
    key = "shiny_pokedex_8",
    path = "shiny_pokedex_8.png",
    px = 71,
    py = 95
}):register()



SMODS.Atlas({
  key = "pokedex_2",
  path = "pokedex_2.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "shiny_pokedex_2",
  path = "shiny_pokedex_2.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "pokedex_3",
  path = "pokedex_3.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "shiny_pokedex_3",
  path = "shiny_pokedex_3.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "pokedex_4",
  path = "pokedex_4.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas({
  key = "shiny_pokedex_4",
  path = "shiny_pokedex_4.png",
  px = 71,
  py = 95
}):register()


table.insert(family, {"scyther", "kleavor" ,"scizor","mega_scizor"})
table.insert(family, {"barboach", "whiscash"})
table.insert(family, {"absol", "mega_absol"})


maltay_config = SMODS.current_mod.config
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end




if lovely and lovely.log then
    lovely.log(" Lovely is working")
else
    print("Lovely not loaded yet")
end

-- Get mod path and load other files
mod_dir = ''..SMODS.current_mod.path
if (SMODS.Mods["Pokermon"] or {}).can_load then
    pokermon_config = SMODS.Mods["Pokermon"].config
end

print("DEBUG")

--Load pokemon file
local pfiles = NFS.getDirectoryItems(mod_dir.."pokemon")
if (SMODS.Mods["Pokermon"] or {}).can_load and SMODS.Mods["Pokermon"] then
  for _, file in ipairs(pfiles) do
    sendDebugMessage ("The file is: "..file)
    local pokemon, load_error = SMODS.load_file("pokemon/"..file)
    if load_error then
      sendDebugMessage ("The error is: "..load_error)
    else
      local curr_pokemon = pokemon()
      if curr_pokemon.init then curr_pokemon:init() end
      
      if curr_pokemon.list and #curr_pokemon.list > 0 then
        for i, item in ipairs(curr_pokemon.list) do
          if (pokermon_config.jokers_only and not item.joblacklist) or not pokermon_config.jokers_only  then
            item.discovered = true
            if not item.key then
              item.key = item.name
            end
            if not pokermon_config.no_evos and not item.custom_pool_func then
              item.in_pool = function(self)
                return pokemon_in_pool(self)
              end
            end
            if not item.config then
              item.config = {}
            end
            if item.ptype then
              if item.config and item.config.extra then
                item.config.extra.ptype = item.ptype
              elseif item.config then
                item.config.extra = {ptype = item.ptype}
              end
            end
            if item.item_req then
              if item.config and item.config.extra then
                item.config.extra.item_req = item.item_req
              elseif item.config then
                item.config.extra = {item_req = item.item_req}
              end
            end
            if item.evo_list then
              if item.config and item.config.extra then
                item.config.extra.evo_list = item.evo_list
              elseif item.config then
                item.config.extra = {item_req = item.evo_list}
              end
            end
            if pokermon_config.jokers_only and item.rarity == "poke_safari" then
              item.rarity = 3
            end
            item.discovered = not pokermon_config.pokemon_discovery 
            SMODS.Joker(item)
          end
        end
      end
    end
  end
end 

print("DEBUG: main.lua loaded")

--doesnt work right now, ill figure it out later.
--local function replace_specific_jokers_with_random()
