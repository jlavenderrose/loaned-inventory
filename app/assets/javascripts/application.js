// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.ui.all
//= require jquery_ujs
//= require jquery.tokeninput
//= require autocomplete-rails
//= require twitter/bootstrap
//= require_tree .
$(function () {
  tokens = {crossDomain: false, preventDuplicates: true, theme: 'facebook'}
  token = {crossDomain: false, preventDuplicates: true, tokenLimit: 1, theme: 'facebook'}
  $('[id$="inventory_object_tokens"]').tokenInput('/inventory_objects.json', tokens);
  $('[id$="loanee_tokens"]').tokenInput('/loanees.json', tokens);
  $('[id$="inventory_object_token"]').tokenInput('/inventory_objects.json', token);
  $('form:not(.auto-form) [id$="loanee_token"]').tokenInput('/loanees.json', token);
  
  $('#pos_token').tokenInput('/point_of_sale/search', {
		tokenValue: 'tid',
		preventDuplicates: true,
		tokenLimit: 1,
		theme: 'facebook',
		hintText: 'POS Lookup',
		
		onResult: function(results) {
			if (!$("#pos_token").is(":focus")) {
				$("#pos_token").tokenInput("add", results[0])
				$("#pos_form").submit()
			}
			return results
		},
		
		onReady: function() {
			$("#token-input-pos_token").focus()
		}
  })
});
