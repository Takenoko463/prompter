# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "prompts", to:"prompts.js"
pin "jquery", to: "jquery.min.js"
pin "jquery_ujs", to: "jquery_ujs.js"
pin "categories", to:"categories.js"
pin "@fortawesome/fontawesome-free", to: "https://ga.jspm.io/npm:@fortawesome/fontawesome-free@6.5.2/js/all.js"
pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "popper", to: "popper.js", preload: true
pin "prompt_form", to:"prompt_form.js"
pin "modal", to:"modal.js"