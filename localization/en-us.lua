return {
    descriptions = {
        Joker = {
		
			j_caninf_spinda = {
				name = "Spinda",
				text = {
					"Sell this to {c:attention}double",
					"or {C:attention}halve{} {C:pink}Energize{} compatible",
					"values of your leftmost Joker",
				}
			},		
			
			j_caninf_marshadow = {
				  name = "Marshadow",
				  text = {
					"When Blind is selected, create",
					"a random {C:dark_edition}Negative{} Joker matching",
					"the rarity of your leftmost Joker.",
					"Created Joker is removed after {C:attention}1{} round."
				  }
				},
						
		
		
			j_caninf_whiscash = {
				name = "Whiscash",
				text = {
					"{C:purple}+#1# Foresight",
					"Retrigger all {C:attention}Foreseen{} cards {C:attention}#2#{} time",
					"if you have more than {C:attention}5{} {C:purple}Foresight{}."
				}
			},
			
			j_caninf_barboach = {
				name = "Barboach",
				text = {
					"{C:purple}+#1# Foresight",
					"Retrigger first {C:attention}Foreseen{} card {C:attention}#2#{} time",
					"{C:inactive,s:0.8}(Evolves with a {C:attention,s:0.8}Water Stone{C:inactive,s:0.8})",
				}
			},
			
			j_caninf_absol = {
				name = "Absol",
				text = {
					"{C:purple}+#1# Foresight",
					"{C:attention}Foreseen{} cards",
					" give {X:mult,C:white}X#2#{} Mult",
				}
			},
			
			j_caninf_mega_absol = {
			  name = "Mega Absol",
			  text = {
				"{C:purple}+#1# Foresight",
				"{C:attention}Foreseen{} cards",
				"give {X:mult,C:white}X#2#{} Mult",
				"plus {X:mult,C:white}X#4#{} Mult{} for each other",
				"{X:dark,C:white}Dark{} Joker you have.",
				"{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)",
			  }
			},
						

			j_caninf_scyther = {
                name = 'Scyther',      
                text = {
                    "When Blind is selected, destroy Joker",
                    "to the right and gain {C:mult}+#2#{} Mult",
                    "Gain {C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or {C:dark_edition}Polychrome{}",
                    "if it was {C:rare}Rare{} or higher",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                    "{C:inactive,s:0.8}(Evolves with a {C:metal,s:0.8}Metal{C:inactive,s:0.8} sticker or a {C:attention,s:0.8}Hard Stone{C:inactive,s:0.8})",
					}
			},
            j_caninf_scizor = {
                name = 'Scizor',
                text = {
                    "When Blind is selected, destroy Joker",
                    "to the right and gain {C:mult}+#4#{} Mult",
                    "Gain {C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or {C:dark_edition}Polychrome{}",
                    "if it was {C:red}Rare{} or higher",
                    "Those editions {C:attention}stack{} on this Joker",
                    "{C:inactive,s:0.8}(Matches destroyed Joker's edition if able){}",
                    "{C:inactive}(Currently {C:mult}+#1#{} {C:inactive}Mult, {C:chips}+#2#{} {C:inactive}Chips, {X:mult,C:white}X#3#{} {C:inactive}Mult)"
                } 
            },	
            j_caninf_kleavor = {
                name = 'Kleavor',      
                text = {
                    "When Blind is selected, destroy",
                    "Joker to the right and gain {C:mult}+#2#{} Mult",
                    "Add a {C:attention}Stone{} card to deck with",
                    "{C:dark_edition}Foil{}, {C:dark_edition}Holographic{}, or {C:dark_edition}Polychrome{} if",
                    "it was {C:green}Uncommon{} or higher",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
                } 
            },			
            j_caninf_mega_scizor = {
                name = "Mega Scizor",
				text = {
							"When Blind is selected, destroy",
							"{C:attention}all{} Jokers to the right and",
							"multiply this Joker's {X:mult,C:white}X{} Mult by {X:mult,C:white}X#4#{}" ,
							"for each Joker destroyed .",
							"{X:mult,C:white}X{} Mult increased to {X:mult,C:white}X#5#{} if the destroyed Joker was {C:dark_edition}Negative{}.",
							"{C:inactive, s:0.8}(After destroying 10 {C:dark_edition, s:0.8}Negative{}{C:inactive, s:0.8} Jokers, this Joker becomes {C:dark_edition, s:0.8}Negative{}.){}",
							"{C:inactive, s:0.8}(Currently {X:mult,C:white, s:0.8}X#3#{}{C:inactive, s:0.8, s:0.8} Mult)",
							"{C:inactive, s:0.8}(Total destroyed: #1#{}{C:inactive, s:0.8}, {C:dark_edition, s:0.8}Negative{}{C:inactive, s:0.8} destroyed: #2#){}"
						}
            }
        },
    }
}
