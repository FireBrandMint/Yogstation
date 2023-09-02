#define PEPPINO "crazychef"
#define NOISE "noid"
#define PIZHEAD "pizzamask"

/datum/antagonist/madchef
	name = "Mad Chef"
	roundend_category = "pizza creeps"
	antagpanel_category = ""
	show_in_antagpanel = FALSE
	antag_hud_name = "peppino"

/datum/antagonist/madchef/apply_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	RegisterSignal(current_mob, COMSIG_LIVING_LIFE, PROC_REF(life_tick))

/datum/antagonist/bloodsucker/remove_innate_effects(mob/living/mob_override)
	. = ..()
	var/mob/living/current_mob = mob_override || owner.current
	UnregisterSignal(current_mob, COMSIG_LIVING_LIFE)

/datum/antagonist/madchef/proc/life_tick(mob/living/source, seconds_per_tick, times_fired)

