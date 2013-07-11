function auto_submit_set(enabled) {
	console.log("Setting auto_submit");
	if (enabled) {
		window.autoSubmit = true
		$("#auto").text("Auto On")
		$("#auto").attr("class", "label label-success")
	} else {
		window.autoSubmit = false
		$("#auto").text("Auto Off")
		$("#auto").attr("class", "label label-important")
	}
}

function auto_submit() {
	return window.autoSubmit;
}

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
	
  $('form.auto-form [id$="inventory_object_token"].first').tokenInput('/point_of_sale/search', {
	tokenValue: 'id',
	preventDuplicates: true,
	tokenLimit: 1,
	theme: 'facebook',
	
	onResult: function(results) {
		if (!$('#token-input-inventory_object_inventory_object_token').is(":focus")) {
			$('form.auto-form [id$="inventory_object_token"].first').tokenInput("add", results[0])
		}
		return results
	},
	
	onAdd: function() {
		$("form.auto-form").submit()
	},
	
	onReady: function() {
		$('#token-input-inventory_object_inventory_object_token').focus()
	}
  })
  
  //auto focus first field
  console.log("focusing input.first")
  $("input.first").focus();
  //submit form on last field defocus (scanner sends tab after data)
  $("input.last").blur(function() {
	if (auto_submit()) {
		$("form.auto-form").delay(100).submit();
	}
  })
  
  //setup Auto label
  auto_submit_set(auto_submit());  
  
  $(document).keyup(function(e) {
	if (e.keyCode == 90) {
		console.log ("alt+z pressed changing auto_submit")
		auto_submit_set(!auto_submit());  	
	}
  })
})
