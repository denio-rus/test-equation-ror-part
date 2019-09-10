document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('#type-switch'); 
  var reset = document.querySelector('#reset-btn')

  if (control) {
      control.addEventListener('click', formLinkHandler)
    }
  if (reset) {
      reset.addEventListener('click', clearForms)
    }
})

function formLinkHandler(event) {
  event.preventDefault();
 
  var link = document.querySelector('#type-switch');
  var quadraticForm = document.querySelector('.form-quadratic');
  var linearForm = document.querySelector('.form-linear');

  if (quadraticForm.classList.contains('hide')) {
    linearForm.classList.add('hide');
    quadraticForm.classList.remove('hide');
    link.textContent = 'Quadratic'
  } else {
    linearForm.classList.remove('hide');
    quadraticForm.classList.add('hide');
    link.textContent = 'Linear'
  }
}

function clearForms(event) {
  event.preventDefault();
  $('.field').val('');
  $('.equation-roots').html('');
};