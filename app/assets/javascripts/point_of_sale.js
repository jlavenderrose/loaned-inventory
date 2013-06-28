//code to make scanner use easier
$(function() {
  $('form.auto-form [id$="loanee_token"]').tokenInput('/loanees.json',
		{ crossDomain: false,
		preventDuplicates: true,
		tokenLimit: 1,
		theme: 'facebook',
		prePopulate: $($('form.auto-form [id$="loanee_token"]')[1]).data("pre"),
		onResult: function (results) {
			if (!$('form.auto-form [id$="loanee_token"]').is(":focus")) {
				//if we don't have focus then we've been tabbed by, set value to first object
				//I present, the world's dumbest jQuery selector
				$($('form.auto-form [id$="loanee_token"]')[1]).tokenInput("add", results[0])
			}
      return results
		},
    onReady: function () {
      $('form.auto-form [id$="loanee_token"]').focus();
    }
	})
  
  //auto focus first field
  $("input.first").focus()
  //submit form on last field defocus (scanner sends tab after data)
  $("input.last").blur(function() {
    $("form.auto-form").delay(100).submit();
  })
})
