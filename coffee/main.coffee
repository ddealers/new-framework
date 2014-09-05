load = (url) ->
	cont = $('#cont')
	cont.empty()
	###
	url = url.replace './templates/', ''
	url = url.replace '.html', ''
	src = $('#'+url).html()
	cont.html src
	$('.list input[type=checkbox]').val('false')
	$('.list input[type=checkbox]').on 'change', ->
		cb = $(this)
		cb.val(cb.prop('checked'))
	$('button.eval').on 'click', (e) ->
		e.preventDefault()
		form = $(e.target).data('target')
		draw = $(e.target).data('draw')
		v = unitans[url]
		console.log form, draw, v
		if $('#'+form).hasClass 'score'
			evaluateScore form, draw, v
		else if $('#'+form).hasClass 'list'
			evaluateList form, draw, v
		else if $('#'+form).hasClass 'generic'
			evaluateGeneric form, draw, v
		else if $('#'+form).hasClass 'quiz'
			evaluateQuiz form, draw, v
		else if $('#'+form).hasClass 'zero'
			evaluateFromZero form, draw, v
		else
			evaluate form, draw, v

	###
	cont.load url, ->
		$('.list input[type=checkbox]').val('false')
		$('.list input[type=checkbox]').on 'change', ->
			cb = $(this)
			cb.val(cb.prop('checked'))
		$('button.eval').on 'click', (e) ->
			e.preventDefault()
			form = $(e.target).data('target')
			draw = $(e.target).data('draw')
			console.log form, draw
			if $('#'+form).hasClass 'score'
				evaluateScore form, draw
			else if $('#'+form).hasClass 'list'
				evaluateList form, draw
			else if $('#'+form).hasClass 'generic'
				evaluateGeneric form, draw
			else if $('#'+form).hasClass 'quiz'
				evaluateQuiz form, draw
			else if $('#'+form).hasClass 'zero'
				evaluateFromZero form, draw
			else
				evaluate form, draw
evaluateScore = (form, draw) ->
	score = 0
	draw = '.alert-box > div'
	answers = $('#'+form).serializeArray()
	for answer in answers
		score+=parseInt answer.value
	$(draw).empty()
	$(draw).append '<a href="#" class="close">x</a>'
	$(draw).append "<p>Score: #{score}</p>"
	$('.alert-box').fadeIn 500
evaluateGeneric =  (form, draw) ->
	draw = '.alert-box > div'
	$(draw).empty()
	$(draw).append '<a href="#" class="close">x</a>'
	console.log $('#'+form).data('generic')
	$(draw).html $('#'+form).data('generic')
	$('.alert-box').fadeIn 500
evaluateQuiz = (form, draw) ->
	draw = '.alert-box > div'
	$(draw).empty()
	$(draw).append '<a href="#" class="close">x</a>'
	$(draw).html 'If you answered 5 A\'s or more you are a Middle Youth-er. <br>If you answered 5 B\'s or more you are a Yuppie. <br>If you answered 5 C\'s or more you are a Yubbie. <br>If you answered 5 D\'s or more you are a home-loving family person. <br>If you answered less than 5 in any of A-D you are a unique individual who is impossible to label.'
	$('.alert-box').fadeIn 500

evaluateList = (form, draw) ->
	draw = '.alert-box > div'
	response = '<p>1. Correct</p>'
	list = v[$('#'+form).data('list')];
	for item of list
		checked = $('[name="'+item+'"]').prop('checked') ? on : off
		if not checked is list[item]
			response = '<p>1. Incorrect</p>'
	$(draw).empty()
	$(draw).append '<a href="#" class="close">x</a>'
	$(draw).append response
	$('.alert-box').fadeIn 500
evaluateFromZero = (form, draw) ->
	draw = '.alert-box > div'
	answers = $('#'+form).serializeArray()
	console.log answers
	$(draw).empty()
	$(draw).append '<a href="#" class="close">x</a>'
	$.each answers, (index, elem) ->
		answer = elem.value
		correct = v[elem.name]

		if Array.isArray correct
			c = off
			for key of correct
				if String(answer).toLowerCase() is String(correct[key]).toLowerCase()
					c = on
			if c
				$(draw).append '<p>' + index + '. Correct</p>'
			else
				$(draw).append '<p>' + index + '. Incorrect</p>'
		else
			console.log String(answer).toLowerCase(), String(correct).toLowerCase() 
			if String(answer).toLowerCase() is String(correct).toLowerCase()
				$(draw).append '<p>' + index + '. Correct</p>'
			else
				$(draw).append '<p>' + index + '. Incorrect</p>'
		$('.alert-box').fadeIn 500

evaluate = (form, draw) ->
	#draw = '#'+draw
	draw = '.alert-box > div'
	answers = $('#'+form).serializeArray()
	console.log answers
	$(draw).empty()
	$(draw).append '<a href="#" class="close">x</a>'
	$.each answers, (index, elem) ->
		answer = elem.value
		correct = v[elem.name]

		if Array.isArray correct
			c = off
			for key of correct
				if String(answer).toLowerCase() is String(correct[key]).toLowerCase()
					c = on
			if c
				$(draw).append '<p>' + (index + 1) + '. Correct</p>'
			else
				$(draw).append '<p>' + (index + 1) + '. Incorrect</p>'
		else
			console.log String(answer).toLowerCase(), String(correct).toLowerCase() 
			if String(answer).toLowerCase() is String(correct).toLowerCase()
				$(draw).append '<p>' + (index + 1) + '. Correct</p>'
			else
				$(draw).append '<p>' + (index + 1) + '. Incorrect</p>'
		$('.alert-box').fadeIn 500

$(document).ready ->
	load './templates/A0.html'
	$('#menu a').on 'click', (e) ->
		e.preventDefault()
		load './templates/' + $(@).attr('href')
	$('.close').on 'click', (e) ->
		e.preventDefault()
		$('.alert-box').fadeOut 500