function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end


local scyther={
  name = "scyther", 
  poke_custom_prefix = "caninf",
  pos = {x = 5, y = 9},
  config = {extra = {mult = 0, mult_mod = 4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.e_foil
    info_queue[#info_queue+1] = G.P_CENTERS.e_holo
    info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
    info_queue[#info_queue+1] = G.P_CENTERS.c_poke_hardstone
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}}
  end,
  rarity = 2, 
  cost = 6, 
  item_req = "hardstone",
  stage = "Basic",
  ptype = "Grass",
  atlas = "pokedex_1",
  perishable_compat = false,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not card.getting_sliced and not context.blueprint then
      local my_pos = nil
      for i = 1, #G.jokers.cards do
          if G.jokers.cards[i] == card then my_pos = i; break end
      end
      if my_pos and G.jokers.cards[my_pos+1] and not card.getting_sliced and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced then 
          local sliced_card = G.jokers.cards[my_pos+1]
          sliced_card.getting_sliced = true
          if (sliced_card.config.center.rarity ~= 1) and (sliced_card.config.center.rarity ~= 2) and not card.edition then
            local edition = poll_edition('wheel_of_fortune', nil, true, true)
            card:set_edition(edition, true)
          end
          
          G.GAME.joker_buffer = G.GAME.joker_buffer - 1
          G.E_MANAGER:add_event(Event({func = function()
              G.GAME.joker_buffer = 0
              card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
              card:juice_up(0.8, 0.8)
              sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
              play_sound('slice1', 0.96+math.random()*0.08)
          return true end }))
          card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, colour = G.C.RED, no_juice = true})
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
            mult_mod = card.ability.extra.mult
        }
      end
    end
    local evo = nil
    evo = type_evo(self, card, context, "j_caninf_scizor", "metal")
    if not evo then
      evo = item_evo(self, card, context, "j_caninf_kleavor")
    end
    if evo then return evo end
  end
}
local scizor={
  name = "scizor", 
  poke_custom_prefix = "caninf",
  pos = {x = 0, y = 6},
  config = {extra = {mult = 0, scizor_chips = 0, scizor_Xmult = 1, mult_mod = 4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.e_foil
    info_queue[#info_queue+1] = G.P_CENTERS.e_holo
    info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
    local emult = 0 
    local echips = 0 
    local eXmult = 1
    if center.edition and center.edition.holo then
      emult = center.edition.mult or 0
    end
    if center.edition and center.edition.foil then
      echips = center.edition.chips or 0
    end
    if center.edition and center.edition.polychrome then
     eXmult = center.edition.x_mult or 1
    end
    return {vars = {center.ability.extra.mult + emult, center.ability.extra.scizor_chips + echips, center.ability.extra.scizor_Xmult * eXmult, center.ability.extra.mult_mod}}
  end,
  rarity = "poke_safari", 
  cost = 10, 
  stage = "One",
  ptype = "Metal",
  atlas = "pokedex_2",
  perishable_compat = false,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not card.getting_sliced and not context.blueprint then
      local my_pos = nil
      for i = 1, #G.jokers.cards do
          if G.jokers.cards[i] == card then my_pos = i; break end
      end
      if my_pos and G.jokers.cards[my_pos+1] and not card.getting_sliced and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced then 
          local sliced_card = G.jokers.cards[my_pos+1]
          sliced_card.getting_sliced = true
          if (sliced_card.config.center.rarity ~= 1 and sliced_card.config.center.rarity ~=2) then
            if card.edition then
              if card.edition.chips then
                card.ability.extra.scizor_chips = card.ability.extra.scizor_chips + card.edition.chips
              end
              if card.edition.mult then
                card.ability.extra.mult = card.ability.extra.mult + card.edition.mult
              end
              if card.edition.x_mult then
                card.ability.extra.scizor_Xmult = card.ability.extra.scizor_Xmult * card.edition.x_mult
              end
            end
            local edition = nil
            if sliced_card.edition and (sliced_card.edition.foil or sliced_card.edition.holo or sliced_card.edition.polychrome) then
              edition = sliced_card.edition
            else
              edition = poll_edition('wheel_of_fortune', nil, true, true)
            end
            card:set_edition(edition, true)
          end
          
          card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
          
          G.GAME.joker_buffer = G.GAME.joker_buffer - 1
          G.E_MANAGER:add_event(Event({func = function()
              G.GAME.joker_buffer = 0
              card:juice_up(0.8, 0.8)
              sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
              play_sound('slice1', 0.96+math.random()*0.08)
          return true end }))
          card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("k_upgrade_ex"), colour = G.C.RED, no_juice = true})
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
          message = localize("poke_x_scissor_ex"),
          colour = G.ARGS.LOC_COLOURS.metal,
          mult_mod = card.ability.extra.mult,
          chip_mod = card.ability.extra.scizor_chips,
          Xmult_mod = card.ability.extra.scizor_Xmult
        }
      end
    end
  end,
  megas={"mega_scizor"}
}
local kleavor={
  name = "kleavor", 
  poke_custom_prefix = "caninf",
  pos = {x = 1, y = 8},
  config = {extra = {mult = 0, mult_mod = 4}},
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = G.P_CENTERS.e_foil
    info_queue[#info_queue+1] = G.P_CENTERS.e_holo
    info_queue[#info_queue+1] = G.P_CENTERS.e_polychrome
    info_queue[#info_queue+1] = G.P_CENTERS.m_stone
    return {vars = {center.ability.extra.mult, center.ability.extra.mult_mod}}
  end,
  rarity = "poke_safari", 
  cost = 8,
  stage = "One",
  ptype = "Earth",
  atlas = "pokedex_8",
  perishable_compat = false,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind and not card.getting_sliced and not context.blueprint then
      local my_pos = nil
      for i = 1, #G.jokers.cards do
          if G.jokers.cards[i] == card then my_pos = i; break end
      end
      if my_pos and G.jokers.cards[my_pos+1] and not card.getting_sliced and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced then 
          local sliced_card = G.jokers.cards[my_pos+1]
          sliced_card.getting_sliced = true
          if (sliced_card.config.center.rarity ~= 1) then
            local edition = poll_edition('aura', nil, true, true)
            local _card = create_playing_card({
                            front = pseudorandom_element(G.P_CARDS, pseudoseed('kleavor')), 
                            center = G.P_CENTERS.m_stone}, G.deck, nil, nil, {G.C.SECONDARY_SET.Enhanced})
            _card:set_edition(edition, true)
          end
          
          G.GAME.joker_buffer = G.GAME.joker_buffer - 1
          G.E_MANAGER:add_event(Event({func = function()
              G.GAME.joker_buffer = 0
              card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
              card:juice_up(0.8, 0.8)
              sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
              play_sound('slice1', 0.96+math.random()*0.08)
          return true end }))
          card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, colour = G.C.RED, no_juice = true})
      end
    end
    if context.cardarea == G.jokers and context.scoring_hand then
      if context.joker_main then
        return {
            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}, 
            mult_mod = card.ability.extra.mult
        }
      end
    end
  end,
  }

local mega_scizor = {
    name = "mega_scizor",
    poke_custom_prefix = "caninf",
    atlas = "Megas_CI",
	pos = {x = 4, y = 2},
    soul_pos = {x = 5, y = 2},

    rarity = "poke_mega", 
    cost = 12, 
    stage = "Mega", 
    ptype = "Grass",

    eternal_compat = false,
    blueprint_compat = false,

	config = {
		extra = {
			sliced_total = 0,
			sliced_negative = 0,
			sliced_normal = 0,
			Xmult = 1,
			Xmult_multi = 1.25,
			has_transformed = false
		}
	},

	loc_vars = function(self, info_queue, center)
		type_tooltip(self, info_queue, center)


		local sliced_negative = center.ability.sliced_negative or 0
		local sliced_normal = center.ability.sliced_normal or 0
		local Xmult_multi = center.ability.extra.Xmult_multi or 1.25
		local Xmult_multi_neg = Xmult_multi * 1.4
		center.ability.extra.Xmult_multi_neg = Xmult_multi_neg
		local Xmult = (1 * (Xmult_multi ^ sliced_normal)) * (Xmult_multi_neg ^ sliced_negative)
		
		return {
			vars = {
				center.ability.extra.sliced_total,
				center.ability.extra.sliced_negative,
				center.ability.extra.Xmult,
				center.ability.extra.Xmult_multi,
				center.ability.extra.Xmult_multi_neg
			}
		}
	end,

	calculate = function(self, card, context)
		local extra = card.ability.extra

		-- Extract values from `extra`
		local sliced_negative = extra.sliced_negative or 0
		local sliced_normal = extra.sliced_normal or 0
		local Xmult_multi = extra.Xmult_multi or 1.25
		local Xmult_multi_neg = Xmult_multi * 1.4
		local Xmult = (1 * (Xmult_multi ^ sliced_normal)) * (Xmult_multi_neg ^ sliced_negative)

		-- Update extra.Xmult so it's available for UI/debug
		extra.Xmult = Xmult

		-- Return scoring multiplier if relevant
		if context.cardarea == G.jokers and context.scoring_hand then
			if context.joker_main then
				return {
					message = localize{type = 'variable', key = 'a_xmult', vars = {extra.Xmult}}, 
					colour = G.C.XMULT,
					Xmult_mod = card.ability.extra.Xmult
				}
			end
		end

		-- Define family members once
		local family_keys = {
			j_caninf_scyther = true,
			j_caninf_scizor = true,
			j_caninf_mega_scizor = true,
			j_caninf_kleavor = true
		}

		if context.setting_blind and not context.blueprint then
			local my_pos = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					my_pos = i
					break
				end
			end

			if my_pos then
				for j = my_pos + 1, #G.jokers.cards do
					local target = G.jokers.cards[j]
					if target
						and not target.ability.eternal
						and not target.getting_sliced
						--not slicing family workers currently bugged, low priority
						and target.key ~= "scyther"
						and target.key ~= "scizor"
						and target.key ~= "mega_scizor"
						and target.key ~= "kleavor"
					then
						target.getting_sliced = true

						if target.edition and target.edition.negative then
							extra.sliced_negative = extra.sliced_negative + 1
						else
							extra.sliced_normal = extra.sliced_normal + 1
						end

						extra.sliced_total = extra.sliced_total + 1

						G.E_MANAGER:add_event(Event({
							func = function()
								target:start_dissolve({HEX("57ecab")}, nil, 1.6)
								play_sound('slice1', 0.96 + math.random() * 0.08)
								return true
							end
						}))

						card_eval_status_text(card, 'extra', nil, nil, nil, {
							message = localize("k_upgrade_ex"),
							colour = G.C.RED,
							no_juice = true
						})
					end
				end
			end
		end

		if extra.sliced_negative >= 10
			and (not card.edition or not card.edition.negative)
			and not extra.has_transformed
		then
			extra.has_transformed = true
			card:set_edition({ negative = true }, true)
		end
	end,

}


local barboach = {
  name = "barboach",
  poke_custom_prefix = "caninf",
  pos = {x = 7, y = 8},

  config = {extra = {scry = 1, retriggers = 1}},

  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
	info_queue[#info_queue + 1] = G.P_CENTERS.c_poke_waterstone
    info_queue[#info_queue + 1] = {set = 'Other', key = 'scry_cards'}
    return {
      vars = {
        center.ability.extra.scry,
        center.ability.extra.retriggers,
      }
    }
  end,

  rarity = 1,
  cost = 4,
  item_req = "waterstone",
  stage = "Basic",
  ptype = "Water",
  atlas = "pokedex_3",
  blueprint_compat = true,
  eternal_compat = true,

  calculate = function(self, card, context)

	if context.repetition
	  and context.cardarea == G.scry_view 
	  and context.other_card == G.scry_view.cards[1] 
	  and not context.other_card.debuff then

	  return {
		message = localize('k_again_ex'),
		message_card = context.other_card,
		repetitions = card.ability.extra.retriggers,
		card = card
	  }
	end

	return item_evo(self, card, context, "j_caninf_whiscash")
  end,

  add_to_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = (G.GAME.scry_amount or 0) + card.ability.extra.scry
  end,

  remove_from_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = math.max(0, (G.GAME.scry_amount or 0) - card.ability.extra.scry)
  end,
}




local whiscash = {
  name = "whiscash",
  poke_custom_prefix = "caninf",
  pos = {x = 8, y = 8},

  config = {extra = {scry = 1, retriggers = 1}}, -- Now includes retriggers
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'scry_cards'}
    return {
      vars = {
        center.ability.extra.scry,
        center.ability.extra.retriggers
      }
    }
  end,

  rarity = "poke_safari",
  cost = 7,
  stage = "One",
  ptype = "Water",
  atlas = "pokedex_3",
  blueprint_compat = true,
  eternal_compat = true,

  calculate = function(self, card, context)


    if context.repetition and (next(context.card_effects[1]) or #context.card_effects > 1) and context.cardarea == G.scry_view and not context.other_card.debuff and (G.GAME.scry_amount or 0) > 5 then

      -- You can show a message or visual cue for the retrigger here
			return {
			message = localize('k_again_ex'),  -- localized message like "Again!"
			message_card = context.other_card,
			repetitions = card.ability.extra.retriggers,                 -- signal one repetition count
			card = card
		}

    end
  end,

  add_to_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = (G.GAME.scry_amount or 0) + card.ability.extra.scry
  end,

  remove_from_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = math.max(0, (G.GAME.scry_amount or 0) - card.ability.extra.scry)
  end,
 } 
  
local absol = {
  name = "absol",
  poke_custom_prefix = "caninf",
  pos = {x = 0, y = 11},

  config = {
    extra = { scry = 2, Xmult = 1.5}
  },

  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'scry_cards'}
    return {
      vars = {
        center.ability.extra.scry,
        center.ability.extra.Xmult
      }
    }
  end,

  rarity = 3,
  cost = 10,
  stage = "Basic",
  ptype = "Dark",
  atlas = "pokedex_3",
  blueprint_compat = true,
  eternal_compat = true,

  calculate = function(self, card, context)
	  if not context.end_of_round and context.scoring_hand then
		if context.individual and context.cardarea == G.scry_view and not context.other_card.debuff then
		  return {
			Xmult = card.ability.extra.Xmult,
			card = card
		  }
		end
	  end
  end,
  
  add_to_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = (G.GAME.scry_amount or 0) + card.ability.extra.scry
  end,

  remove_from_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = math.max(0, (G.GAME.scry_amount or 0) - card.ability.extra.scry)
  end,
  megas={"mega_absol"}
}

local mega_absol = {
  name = "mega_absol",
  poke_custom_prefix = "caninf",
  pos = {x = 2, y = 4},
  soul_pos = {x = 3, y = 4},

  config = {
    extra = { scry = 2, scry_plus= 0, Xmult = 1.5 , Xmult_multi=0.25 }
  },

  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue + 1] = {set = 'Other', key = 'scry_cards'}

    local base_scry = center.ability.extra.scry or 0
    local scry_plus = self:count_other_dark_jokers(center) or 0
	local bonus_mult =  center.ability.extra.Xmult_multi*scry_plus

    return {
      vars = {
        base_scry,                          -- #1 base scry
        center.ability.extra.Xmult,  -- #2 multiplier
        bonus_mult,                      -- #3 other dark jokers count
		center.ability.extra.Xmult_multi
		
      }
    }
  end,

  rarity = "poke_mega",
  cost = 12,
  stage = "Mega",
  ptype = "Dark",
  atlas = "Megas_CI",
  blueprint_compat = true,
  eternal_compat = false,

  count_other_dark_jokers = function(self, exclude_card)
    local count = 0
    local all_dark_jokers = find_pokemon_type("Dark")
    for _, j in ipairs(all_dark_jokers) do
      if j ~= exclude_card then
        count = count + 1
      end
    end
    return count
  end,

  calculate = function(self, card, context)
	  if not context.end_of_round and context.scoring_hand then
		if context.individual and context.cardarea == G.scry_view and not context.other_card.debuff then
		  local bonus_count = self:count_other_dark_jokers(card)
		  return {
			Xmult = card.ability.extra.Xmult + (bonus_count * card.ability.extra.Xmult_multi),
			card = card
		  }
		end
	  end
	end,

  add_to_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = (G.GAME.scry_amount or 0) + card.ability.extra.scry
  end,

  remove_from_deck = function(self, card, from_debuff)
    G.GAME.scry_amount = math.max(0, (G.GAME.scry_amount or 0) - card.ability.extra.scry)
  end,


}


local spinda = {
  name = "spinda",
  poke_custom_prefix = "caninf",
  pos = {x = 5, y = 7},

  config = {
    extra = {}
  },
  loc_vars = function(self, info_queue, center)
    type_tooltip(self, info_queue, center)
    info_queue[#info_queue+1] = {set = 'Other', key = 'energize'}
    return {vars = {}}
  end,
  rarity = 2,
  cost = 5,
  stage = "Basic",
  ptype = "Normal",
  atlas = "pokedex_3",
  blueprint_compat = true,
  eternal_compat = false,

  calculate = function(self, card, context)
	  local function box_muller()
		  local u1 = math.random()
		  local u2 = math.random()
		  local z0 = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)
		  return z0
		end

	  local function clamp(x, min_val, max_val)
		  if x < min_val then return min_val end
		  if x > max_val then return max_val end
		  return x
		end

	--  function random_multiplier()
		  -- 50% chance pick left or right peak
		 -- local center = math.random() < 0.5 and 0.75 or 1.25
	--	   Stddev controls spread around peaks
	--	  local stddev = 0.15
	--	  local sample = center + stddev * box_muller()
	--	  sample = clamp(sample, 0.1, 10)
	--	  return sample
	--	end
		local function random_multiplier(value)
		  if math.random() < 0.5 then
			return value / 2
		  else
			return value * 2
		  end
		end

	  if context.selling_self and not context.blueprint then
		local leftmost = G.jokers.cards[1]
		if leftmost and leftmost ~= card then
		  local ability = leftmost.ability
		  local keys = {
			"mult", "mult1", "mult2", "mult_mod", "mult_mod2",
			"Xmult", "Xmult1", "Xmult2", "Xmult_multi", "Xmult_multi2",
			"Xmult_mod", "chips", "money", "money2", "money_mod"
		  }

--		  for _, key in ipairs(keys) do
--			if card and card.config and card.config.extra and card.config.extra[key]
--			   and type(card.config.extra[key]) == "number" and card.config.extra[key] > 0 then
--			  card.config.extra[key] = random_multiplier()
--			elseif ability and ability.extra and ability.extra[key]
--			   and type(ability.extra[key]) == "number" and ability.extra[key] > 0 then
--			  ability.extra[key] = random_multiplier()
--			end
--		  end

		for _, key in ipairs(keys) do
		  if card and card.config and card.config.extra and card.config.extra[key] and type(card.config.extra[key]) == "number" and card.config.extra[key] > 0 then
			card.config.extra[key] = random_multiplier(card.config.extra[key])
		  elseif ability and ability.extra and ability.extra[key] and type(ability.extra[key]) == "number" and ability.extra[key] > 0 then
			ability.extra[key] = random_multiplier(ability.extra[key])
		  end
		end

		if leftmost.show_status_text then
			leftmost:show_status_text("Spinda effect triggered! Multipliers randomly changed.")
		  end
		end
	  end
  end,
}

-- Weak-keyed registry for all spawned jokers by marshadow instance
local spawned_jokers_registry = setmetatable({}, { __mode = "k" })

local marshadow = {
    name = "marshadow",
    poke_custom_prefix = "caninf",
    atlas = "pokedex_7",
    pos = {x = 5, y = 8},
    soul_pos = {x = 6, y = 8},

    rarity = 4, -- Legendary
    cost = 20,
    stage = "Legendary",
    ptype = "Fighting",

    eternal_compat = false,
    blueprint_compat = true,

    -- Register a joker for this marshadow instance
    register_spawned_joker = function(self, joker)
        if not spawned_jokers_registry[self] then
            spawned_jokers_registry[self] = {}
        end
        table.insert(spawned_jokers_registry[self], joker)
    end,

    -- Get all spawned jokers for this marshadow instance
    get_spawned_jokers = function(self)
        return spawned_jokers_registry[self] or {}
    end,

    -- Clear all spawned jokers tracked for this marshadow instance
    clear_spawned_jokers = function(self)
        spawned_jokers_registry[self] = nil
    end,

    loc_vars = function(self, info_queue, center)
        type_tooltip(self, info_queue, center)
        info_queue[#info_queue+1] = G.P_CENTERS.e_negative
        return {vars = {}}
    end,

    calculate = function(self, card, context)
        -- No internal storage of spawned jokers here! Always use registry.
		if G.jokers.cards[1] == card then return end
        -- Spawn a new shadow Joker when setting a blind
        if context.setting_blind then
            local leftmost = G.jokers.cards[1]
            if not leftmost or not leftmost.config or not leftmost.config.center then return end
            local rarity = leftmost.config.center.rarity
            if not rarity then return end

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    local _card = create_random_poke_joker("marshadow", nil, rarity)
                    local edition = {negative = true}
                    _card:set_eternal(false)
                    _card.ability.perishable = true
                    _card.ability.perish_tally = 2
                    _card:set_edition(edition, true)
                    _card._is_temp_marshadow = true

                    if not _card.ability.extra then _card.ability.extra = {} end
                    _card.ability.extra.rounds = 1

                    _card:add_to_deck()
                    G.jokers:emplace(_card)

                    -- Register joker externally
                    self:register_spawned_joker(_card)

                    card_eval_status_text(card, "extra", nil, nil, nil, {
                        message = "Shadow!",
                        colour = G.C.BLACK
                    })

                    return true
                end
            }))
        end

        -- Decrement rounds of all spawned jokers when setting blind
        if context.setting_blind then
            local jokers = self:get_spawned_jokers()
            for i = #jokers, 1, -1 do
                local joker = jokers[i]
                if joker and joker.ability and joker.ability.extra then
                    joker.ability.extra.rounds = (joker.ability.extra.rounds or 1) - 1
                end
            end
        end

        -- Remove jokers whose rounds expired at end of round
        if context.end_of_round then
            local jokers = self:get_spawned_jokers()
            for i = #jokers, 1, -1 do
                local joker = jokers[i]
                local rounds = joker and joker.ability and joker.ability.extra and joker.ability.extra.rounds or 1
                if rounds <= 0 and joker and not joker.ability.eternal then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if joker then
                                remove(self, joker, context)
                            end
                            return true
                        end
                    }))

                    -- Remove from registry
                    table.remove(jokers, i)
                end
            end

            -- If no more jokers, clear registry for this marshadow
            local remaining = self:get_spawned_jokers()
            if #remaining == 0 then
                self:clear_spawned_jokers()
            end
        end
    end,
}





-- Export the joker
local list = {
    scyther, scizor , kleavor , mega_scizor,  barboach, whiscash, absol, mega_absol, spinda, marshadow
}

return {name = "Maltay's CanInf", list = list}

