//code to make scanner use easier
$(function() {
  //auto focus first field
  $("input.first").focus()
  //submit form on last field defocus (scanner sends tab after data)
  $("input.last").blur(function() {
    $("form.auto-form").submit()
  })
})
