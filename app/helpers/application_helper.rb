load '../static/DomainHelper.rb'

module ApplicationHelper
	def tableless_page(*args)
		if args.size == 3
			tableless_page_private(args[0], "", args[1], args[2])
		else
			tableless_page_private(args[0], "/" + args[1], args[2], args[3])
		end
	end

	# =========================================================================
	private #methods
	# =========================================================================

	def navbar_items
		[
			['Posts', 'posts'],
		]
	end

	def current_navbar
	'Posts'
	end

	def current_header
	'Posts On Rails'
	end

	def left_menu_items
		[
			['Posts', '/posts'],
		]
	end

	def left_menu(url_root)
		rValue = '<ul>'
		left_menu_items.each {|x| rValue += '<li><a href="' + url_root + (x[1]) + '">' + (x[0]) + '</a></li>' }
		rValue += '</ul>'
	end

	def header(right_text, right_link)
		site=''
		navbar_items.each {|x| site += x[0] == current_navbar ? x[1] : ''}
		rValue ='
	  <div class="header">
	    <div class="left-header"><image class="ruby-icon" src="/static/images/rails.gif"></image></div>
	    <div class="machine-header"><ul>'
	    DomainHelper.machine_menu_items.each {|x| rValue += '<li><a href="http:/' + x[1] + '/' + site + '">' + x[0] + '</a></li>' }
		rValue += '
	    </ul></div>
	    <div class="centre-header"><h1>' + current_header + '</h1></div>
	    <div class="right-header"><a href="' + right_link + '">' + right_text + '</a></div>
	  </div>
	  <div class="tab-header">
		<ul id="navbar">'

		navbar_items.each {|x| rValue += x[0] == current_navbar ?
			('<li><a class="current">' + x[0] + '</a></li>') :
			('<li><a href="http://' + ENV['SERVER_NAME'] + '/' + x[1] + '">' + (x[0]) + '</a></li>') }

		rValue += '
		</ul>
	  </div>
	'
	end

	def footer
		l = 'Rails'
	    if Rails::env == 'development'
	      l = link_to 'Rails', controller: 'rails/info', action: 'properties'
		end
		'
		  <div class="footer">
			<div class="left-footer">Copyright &copy;' + Time.now.year.to_s + ' Derek Knight</div>
			<div class="right-footer">Powered by Ruby on ' + l + ' (' + Rails::env + '). [Ruby ' + RUBY_VERSION + ', Rails ' + Rails::VERSION::STRING + ']</div>
		  </div>
		'
	end

	def tableless_page_private(right_text, right_link, error_message, yield_data)
	url_root = 	'http://' + request.host_with_port + Rails::configuration.action_controller.relative_url_root
	header(right_text, url_root+right_link) +
	'
	  <div class="page-content">
		<div class="left-menu">
		  ' + left_menu(url_root) + '
		</div>
		<div class="right-content">
		  <br/>
		  <div class="error-content">
			<p style="color: green">' + (error_message.nil? ? "" : error_message) + '</p>
		  </div>
		  <br/>
		  <div class="page-data">
			' + yield_data + '
		  </div>
		</div>
	  </div>

	  ' + footer
	end
end
