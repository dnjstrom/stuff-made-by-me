# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

init_expanding_textarea = ->
	$(".expanding").expandingTextarea();

	# init infinite scrolling
	if $('.pagination').length
		$(window).scroll ->
			url = $('.pagination .next_page').attr('href')
			if url &&  $(window).scrollTop() > $(document).height() - $(window).height() - 50
				$('.pagination').text('Fetching more products...')
				$.getScript(url)
		$(window).scroll()

$(document).ready(init_expanding_textarea)
$(document).on('page:load', init_expanding_textarea)
