/datum/team/pizzacreeps
	var/backstory = "Pizza Creep"

/datum/team/pizzacreeps/proc/update_objectives(initial = FALSE)
	objectives = list()
	var/datum/objective/O = new()
	O.team = src
	objectives += O

/datum/team/pizzacreeps/proc/assemble_fugitive_results()
	var/list/fugitives_counted = list()
	var/list/fugitives_dead = list()
	for(var/datum/antagonist/crazychef/A in GLOB.antagonists)
		if(!A.owner)
			continue
		fugitives_counted += A
		if(A.owner.current.stat == DEAD)
			fugitives_dead += A
	. = list(fugitives_counted, fugitives_dead) //okay, check out how cool this is.

/datum/team/pizzacreeps/proc/all_hunters_dead()
	var/dead_boys = 0
	for(var/I in members)
		var/datum/mind/hunter_mind = I
		if((hunter_mind.current.stat == DEAD)))
			dead_boys++
	return dead_boys >= members.len

/datum/team/pizzacreeps/proc/get_result()
	var/list/fugitive_results = assemble_fugitive_results()
	var/list/fugitives_counted = fugitive_results[1]
	var/list/fugitives_dead = fugitive_results[2]
	var/hunters_dead = all_hunters_dead()
	//this gets a little confusing so follow the comments if it helps
	if(!fugitives_counted.len)
		return 0

	if(hunters_dead)
		if(fugitives_dead.len == fugitives_counted.len)
			return 10
		else
			return 11
	
	if(fugitives_counted.len > 1)
		if(fugitives_dead.len == fugitives_counted.len)
			return 3;
		else if(fugitives_dead > 1)
			return 4;
		else return 5;

	if(fugitives_dead.len == fugitives_counted.len)
		return 2
	else
		return 1
	

/datum/team/pizzacreeps/roundend_report() //shows the number of fugitives, but not if they won in case there is no security
	if(!members.len)
		return

	var/list/result = list()

	result += "<div class='panel redborder'>...And <B>[members.len]</B> [backstory]s tried to hunt them down!"

	for(var/datum/mind/M in members)
		result += "<b>[printplayer(M)]</b>"

	switch(get_result())
		if(0)//use defines
			result += "<span class='neutraltext big'>Confusing [capitalize(backstory)] Loss!</span>"
			result += "<B>The [backstory]s managed to go to the wrong galaxy!</B>"
		if(1)
			result += "<span class='redtext big'>Major [capitalize(backstory)] Loss!</span>"
			result += "<B>The [backstory]s were unable to exact their revenge!</B>"
		if(2)
			result += "<span class='greentext big'>Major [capitalize(backstory)] Victory</span>"
			result += "<B>The [backstory]s exacted their revenge on the mad chef.</B>"
		if(3)
			result += "<span class='greentext big'>Major [capitalize(backstory)] Victory</span>"
			result += "<B>The [backstory]s exacted their revenge on the mad chef and his clones!</B>"
		if(4)
			result += "<span class='neutraltext big'>Lackluster [capitalize(backstory)] Loss</span>"
			result += "<B>The [backstory]s were unable to handle all chef clones! Good luck next time!</B>"
		if(5)
			result += "<span class='redtext big'>Major [capitalize(backstory)] Loss</span>"
			result += "<B>The [backstory]s were unable to handle a single chef clone! How?</B>"
		if(10)
			result += "<span class='neutraltext big'>Bloody Stalemate</span>"
			result += "<B>Both the pizza creeps and mad chef died! Pizza will never taste the same.</B>"
		if(11)
			result += "<span class='redtext big'>Major [capitalize(backstory)] Loss!</span>"
			result += "<B>The [backstory]s were killed and the mad chef is free to go forever!</B>"

	result += "</div>"

	return result.Join("<br>")
