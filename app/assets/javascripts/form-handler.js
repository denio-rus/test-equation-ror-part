document.addEventListener('turbolinks:load', function() {
  var control = document.querySelector('#type-switch'); 
  
  if (control) {
      control.addEventListener('click', formLinkHandler)
    }
  
  // var errors = document.querySelector('.resource-errors')
  // if (errors) {
  //   var resourceId = errors.dataset.resourceId;
  //   formInlineHandler(resourceId);
  // }
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