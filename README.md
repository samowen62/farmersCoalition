== README

This is the repository for fmmetrics@wisc made with ruby on rails.

##Important things to note
* The selected metrics are always stored as an array on the front end so metric[i] actually refers to metric i + 1.
* The boolean values of this array are determined by looking at two integers as a sequence of 37 bits.
* Run the server with <pre>$ rails s -p 80 &</pre> so that you can continue to operate on the server.
* Please be consistent and use rails migrations when adjusting the postgres database.

##Important Locations
* Views: Most are in app/views/users. app/views/pdf/gen_pdf.html.erb is generated byapp/controllers/pdf_controller.rb which uses Prawn for formatting.
* Controllers: app/controllers/users_controller.rb handles most of the preprocessing before a page loads. app/controllers/profile_controller.rb handles most POST requests.
* For styling changes please be consistent with SCSS and run compass with <pre>$ compass watch</pre> in app/assets to generate changes to app/assets/stylesheets/application.css.scss.
