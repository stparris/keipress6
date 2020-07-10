# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or whered alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.where([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.where(name: 'Luke', movie: movies.first)

require 'faker'

def hashed_password(password, salt)
  string_to_hash = password + "whippet" + salt
  return Digest::SHA1.hexdigest(string_to_hash)
end

def walter_text
"<h2>Walter White Says</h2>
<p>A business big enough that it could be listed on the NASDAQ goes belly up. Disappears! It ceases to exist without me. No, you clearly don't know who you're talking to, so let me clue you in. I am not in danger, Skyler. I AM the danger! A guy opens his door and gets shot and you think that of me? No. I am the one who knocks!
</p>
<p>Did he speak to you? Would you just answer? What things? What people? A month ago, Gus was trying to kill both of us. And now, he pulls you out of the lab and employs you as... what... a, an assistant gunman? A tough guy? Does that make any sense to you? He says he sees something in you. What kind of game is he playing. Does he think you're that naïve? He can't truly think that you'd forget... let alone Gale, let alone Victor... and all the horror that goes along with all of that.
</p>
<p>It's enough. This is still the best way. You go after him with a gun, you'll never get out of it alive. But with this... you slip it into his food or drink, there shouldn't be any taste or smell... thirty-six hours later... poof. A man his age, working as hard as he does... no one will be surprised. Mike can have his suspicions, but that's all they'll be. Please, one homicidal maniac at a time.
</p>
<p>Look, I'll give you Jesse Pinkman, OK? Like you said, he's the problem, he's always been the problem and without him, we would... and he's in town, alright? He's not in Virginia or wherever the hell you're looking for him. He's right here in Albuquerque and I can take you to him, I'll take you right to him. What do you say?
</p>
"
end

def pinkman_text
"<h2>Jesse Pinkman Says</h2>
<p>Where's my money... bitch? WHERE'S my money. Where's my. Where's MY money, bitch? Huh? Bitch? Where's my money, bitch? Oh that's good... where's my money. Where's my money, bitch. Bitch, where's my money. I will mess you... up. That how you wanna play this?  Huh, Your call, your funeral Jack. Hey, do not mess with me I will bury you cause I'm crazy. You know, yeah... mucho loco. Do not... test me.</p>
<p>Where's my money, bitch?! I ain't gonna keep asking nice. Yo, alright? I want my money and my dope. Come on! What, what! What do you wanna say? Shut up! Shut... up! </p>
<p>What business? The business you put me on, asshole! What, you already forgot? THIS business. Huh? That uh jog your memory, son of a bitch? Hey, you said... you said handle it, so you know what, I handled it. Didn't mean to kill somebody? Well, too late you know cause, dude's dead. Way dead. Oh, and hey, hey. Here's your money. Yeah, forty-six hundred and sixty bucks. Your half. Spend it in good health, you miserable son of bitch. </p>
<p>I didn't say I killed him. Dude's wife crushed his head with an ATM machine. Crushed his head... with an ATM machine... right in front of me. I mean, crushed it like... Oh my god, the sound... it's still in my ears. You know and the the blood, like everywhere. Like there was so much you would not believe. Man will you just please give me... just give me my weed alright? It helps with my nausea.</p>
"
end

def goodman_text
"<h2>Saul Goodman Says</h2>
<p>Better safe than sorry. That's my motto. Yeah, you do seem to have a little 'shit creek' action going. You know, FYI, you can buy a paddle. Did you not plan for this contingency? I mean the Starship Enterprise had a self-destruct button. I'm just saying.</p>
<p>Look, let's start with some tough love, alright? Ready for this? Here it goes: you two suck at peddling meth. Period. Good! 'Oh boo-hoo, I won't cook meth anymore!' You're a crybaby! Who needs you?! Hey, I'm unplugging the website, so no more money laundering! How do you like that?!</p>
<p>Great, perfect you know... this is just. I told her you were my A Team. Oh, hello Mrs. White, the good news is the IRS has been paid off, the bad news is... ach, Jesus!</p>
<p>What am I eighth grade hall monitor? Current whereabouts? Let me tell you something, Mike. There are rules to this lawyer thing. Attorney client privilege, that's a big one. That's something I provide for you! If I give up Pinkman, then you're gonna be asking, old Saul gives 'em up pretty easy what's to keep him from giving me up? You see, so then, where's the trust?</p>
"
end

def mike_text
"<h2>Mike Ehrmantraut Says</h2>
<p>Goodbye, Walter.  I don't owe you a damn thing.  All of this -- falling apart like this -- is on YOU.  We had a good thing, you stupid son of a bitch!  We had Fring.  We had a lab.  We had everything we needed and it all ran like clockwork.  You could've shut your mouth, cooked, and made as much money as you ever needed.  It was perfect.  But no!  You just had to blow it up.  YOU!  And your pride and your ego.  You just had to be the man.  If you'd done your job, known your place, we'd all be fine right now.
</p>
<p>Any other drugs in the house? Think hard; your freedom depends on it. What about guns, you got any guns in the house? Here's your story - You woke up, you found her, that's all you know. Say it. Say it, please. I woke up I found her that's all I know. Say it. I woke up I found her, that's all I know. Again. Again. Again.
</p>
<p>Once you call it in, the people who show up with be with the office of medical investigations. it's primarily who you'll talk to. Police officers may arrive they may not, depends on how busy a morning they're having. Typically ODs are not a high priority call. There's nothing here to incriminate you, so I'd be amazed if you got placed under arrest. However, if you do, you say nothing. You tell them you just want your lawyer. And you call Saul Goodman.
</p>
<p>And do I need to state the obvious? I was not here. You put on a long sleeve shirt and cover those track marks on your arm. Count down from twenty, and then you dial. Hang tough, you're in the home stretch.
</p>
"
end

# Theme color palattes

#grayscale
grayscale = Palette.where(name: 'grayscale').first_or_create
i = 1
['ffffff',
'f2f2f2',
'f4f4f4',
'f8f8f8',
'eeeeee',
'e6e6e6',
'd9d9d9',
'cccccc',
'bfbfbf',
'b3b3b3',
'a6a6a6',
'999999',
'8c8c8c',
'808080',
'737373',
'666666',
'595959',
'4d4d4d',
'404040',
'333333',
'262626',
'1a1a1a',
'0d0d0d',
'343a40',
'000000'].each do |color|
	PaletteColor.where(palette_id: grayscale.id, name: "grayscale#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end


#teal

teal = Palette.where(name: 'teal').first_or_create
i = 1
['E7F3F3',
'D0E7E7',
'B9DCDC',
'A2D0D0',
'8BC5C5',
'A8EDD4',
'73B9B9',
'5CAEAE',
'45A2A2',
'2E9797',
'178B8B',
'008080',
'007575',
'006969',
'005E5E',
'005252',
'004646',
'002F2F',
'002323'].each do |color|
	PaletteColor.where(palette_id: teal.id, name: "teal#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end



# nebulous
nebulous = Palette.where(name: 'nebulous').first_or_create
i = 1
['EEE7EA',
'DED0D6',
'CDB9C1',
'BDA2AD',
'AC8B99',
'9C7384',
'8B5C70',
'7B455C',
'6A2E47',
'5A1733',
'4A001F',
'44001D',
'3D001A',
'360017',
'300014',
'290011',
'22000F',
'1B000C',
'150009',
'0E0006',
'070003'].each do |color|
	PaletteColor.where(palette_id: nebulous.id, name: "nebulous#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end

# ocean
ocean = Palette.where(name: 'ocean').first_or_create
i = 1
['e6f7ff',
'cceeff',
'b3e6ff',
'99ddff',
'80d4ff',
'66ccff',
'4dc3ff',
'33bbff',
'1ab2ff',
'00aaff',
'0099e6',
'0088ca',
'0077b3',
'006699',
'005580',
'004466',
'00334d',
'002233',
'00111a'].each do |color|
	PaletteColor.where(palette_id: ocean.id, name: "ocean#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end

#darkred
darkred = Palette.where(name: 'darkred').first_or_create
i = 1
['ffece6',
'ffd9cc',
'ffc6b3',
'ffb399',
'ff9f80',
'ff8c66',
'ff794d',
'ff6633',
'ff531a',
'ff4000',
'e63900',
'cc3300',
'b32d00',
'992600',
'802000',
'661a00',
'4d1300',
'330d00',
'1a0600'].each do |color|
	PaletteColor.where(palette_id: darkred.id, name: "darkred#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end

# sunny
sunny = Palette.where(name: 'sunny').first_or_create
i = 1
['ffffe6',
'ffffcc',
'ffffb3',
'ffff99',
'ffff80',
'ffff66',
'ffff4d',
'ffff33',
'ffff1a',
'ffff00',
'e6e600',
'cccc00',
'b3b300',
'999900',
'808000',
'666600',
'4d4d00',
'333300',
'1a1a00'].each do |color|
	PaletteColor.where(palette_id: sunny.id, name: "sunny#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end

# oranges
oranges = Palette.where(name: 'oranges').first_or_create
i = 1
['fff6e6',
'ffedcc',
'ffe4b3',
'ffdb99',
'ffd280',
'ffc966',
'ffc14d',
'ffb833',
'ffaf1a',
'ffa500',
'e69500',
'cc8500',
'b37400',
'996300',
'805300',
'664200',
'4d3200',
'332100',
'1a1100'].each do |color|
	PaletteColor.where(palette_id: oranges.id, name: "oranges#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end

#greens
greens = Palette.where(name: 'greens').first_or_create
i = 1
['e6ffe6',
'ccffcc',
'b3ffb3',
'99ff99',
'80ff80',
'66ff66',
'4dff4d',
'33ff33',
'1aff1a',
'1aff1a',
'00ff00',
'00e600',
'00cc00',
'00ff00',
'00e600',
'00cc00',
'00b300',
'009900',
'008000',
'006600',
'004d00',
'003300',
'001a00'].each do |color|
	PaletteColor.where(palette_id: greens.id, name: "greens#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end

#blues
blues = Palette.where(name: 'blues').first_or_create
i = 1
['e6e6ff',
'ccccff',
'b3b3ff',
'9999ff',
'8080ff',
'6666ff',
'4d4dff',
'3333ff',
'1a1aff',
'0000ff',
'0000e6',
'0000cc',
'0000b3',
'000099',
'000080',
'000066',
'00004d',
'000033',
'00001a'].each do |color|
	PaletteColor.where(palette_id: blues.id, name: "blues#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end

#lavenders
lavenders = Palette.where(name: 'lavenders').first_or_create
i = 1
['eaeafb',
'e6e6fa',
'd4d4f7',
'bfbff2',
'aaaaee',
'9595ea',
'7f7fe6',
'6a6ae2',
'5555dd',
'3f3fd9',
'2a2ad5',
'2626c0',
'2222aa',
'1d1d95',
'191980',
'15156a',
'111155',
'0d0d40',
'08082b',
'040415'].each do |color|
	PaletteColor.where(palette_id: lavenders.id, name: "lavenders#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end

#beiges
beiges = Palette.where(name: 'beiges').first_or_create
i = 1
['f9f9eb',
'f5f5dc',
'f4f4d7',
'eeeec3',
'e9e9af',
'e3e39c',
'dddd88',
'd8d874',
'd2d260',
'cdcd4c',
'c7c738',
'b3b332',
'9f9f2d',
'8b8b27',
'777722',
'63631c',
'505016',
'3c3c11',
'28280b',
'141406'].each do |color|
	PaletteColor.where(palette_id: beiges.id, name: "beiges#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end

#cocoa
cocoa = Palette.where(name: 'cocoa').first_or_create
i = 1
['fff2e6',
'ffe6cc',
'ffd9b3',
'ffcc99',
'ffbf80',
'ffb366',
'ffa64d',
'ff9933',
'ff8c1a',
'ff8000',
'e67300',
'cc6600',
'b35900',
'994d00',
'804000',
'663300',
'4d2600',
'331a00',
'1a0d00'].each do |color|
	PaletteColor.where(palette_id: cocoa.id, name: "cocoa#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end

#pinks
pinks = Palette.where(name: 'pinks').first_or_create
i = 1
['ffe6ea',
'ffccd5',
'ffc0cb',
'ffb3bf',
'ff99aa',
'ff8095',
'ff6680',
'ff4d6a',
'ff3355',
'ff1a40',
'ff002b',
'e60026',
'cc0022',
'b3001e',
'99001a',
'800015',
'660011',
'4d000d',
'330009',
'1a0004'].each do |color|
	PaletteColor.where(palette_id: pinks.id, name: "pinks#{i < 10 ? '0'+i.to_s : i}",value: color).first_or_create
	i += 1
end


brand = 'Kei Press <icon class="icon-sun-inv"></icon>'

admin = SuperAdmin.where(email: 'admin@keipress.com',first_name: 'Super',last_name: 'Admin',role: 1).first_or_create
salt = admin.id.to_s + rand.to_s
admin.hashed_password = hashed_password('admin', salt)
admin.salt = salt
admin.save

admin = SuperAdmin.where(email: 'vincent@keipress.com',first_name: 'Vincent',last_name: 'Van Gough',role: 1).first_or_create
salt = admin.id.to_s + rand.to_s
admin.hashed_password = hashed_password('admin', salt)
admin.salt = salt
admin.save

ISO3166::Country.all.each do |c|
	country = Country.where(
    name: c.name,
    iso3: c.alpha3,
    iso: c.alpha2,
    iso_name: c.name.upcase,
    numcode: c.number,
    state_required: c.states.any? ? true : false,
    post_code_required: c.postal_code,
    eu: c.in_eu? ? true : false
  ).first_or_create
	if c.states.any?
		c.states.each_key do |s|
			State.where(
				name: c.states[s].name,
				abbr: s,
				country_id: country.id
			).first_or_create
		end
	end


end
sites = []
site = Site.where(
				name: 'Local Host',
				description: 'A simple content management system based on Ruby on Rails with PosgreSQL and Twitter Bootstrap.',
				country_id: Country.find_by(iso: "US").id,
				favicon: 'keipress',
				time_zone: 'America/Los_Angeles').first_or_create
domain = Domain.where(name: 'localhost', site_id: site.id).first_or_create
admin.sites << site
sites << site

site = Site.where(
				name: 'Keipress',
				description: 'A simple content management system based on Ruby on Rails with PosgreSQL and Twitter Bootstrap.',
				country_id: Country.find_by(iso: "US").id,
				favicon: 'keipress',
				time_zone: 'America/Los_Angeles').first_or_create
domain = Domain.where(name: 'keipress.com', site_id: site.id).first_or_create
admin.sites << site
sites << site

site = Site.where(
				name: 'STParris',
				description: 'A simple content management system based on Ruby on Rails with PosgreSQL and Twitter Bootstrap.',
				country_id: Country.find_by(iso: "US").id,
				favicon: 'keipress',
				time_zone: 'America/Los_Angeles').first_or_create
domain = Domain.where(name: 'stparris.com', site_id: site.id).first_or_create
admin.sites << site

# Shared page elements
sites.each do |site|
	header_group = ContentGroup.where(name: 'Header Group', site_id: site.id).first_or_create
	header_content = ContentGroupItem.where(name: 'My New Website', content_type: "text", content_id: header_group.id).first
	unless header_content
		header_content = ContentGroupItem.create(name: 'My New Website', content_type: "text", content_id: header_group.id, text_html: 1, body: '<h1>{{TODAY}}</h1>')
	end
	header_container = Container.where(name: 'Header',site_id: site.id,container_type: 'grid', rows_flag: 1,css_classes: 'banner').first_or_create
	row = ContainerRow.where(container_id: header_container.id,css_classes: '',position: 1).first_or_create
	RowColumn.where(container_row_id: row.id,css_classes: 'col-12',content_type:'content_group',content_id: header_group.id,position: 1).first_or_create

	navigation = Navigation.where(name: 'Main Navigation', site_id: site.id, nav_type: 'navbar', brand: brand).first_or_create
	navigation_container = Container.where(name: 'Main Navigation',site_id: site.id,container_type: 'navbar',css_classes: '',navigation_id: navigation.id).first_or_create

	footer_group = ContentGroup.where(name: 'Footer Group',site_id: site.id).first_or_create
	footer_content = ContentGroupItem.where(name: 'Copyright', content_type: "text", content_id: footer_group.id).first
	unless footer_content
		footer_content = ContentGroupItem.create(name: 'Copyright', content_type: "text", content_id: footer_group.id, text_html: 1, body: "<p><icon class=\"icon-copyright\"></icon> {{YEAR}} #{site.name}</p>", position: 1)
	end
	footer_container = Container.where(name: 'Footer',site_id: site.id,container_type: 'grid', rows_flag: 1,css_classes: 'footer').first_or_create
	row = ContainerRow.where(container_id: footer_container.id,css_classes: '',position: 1).first_or_create
	RowColumn.where(container_row_id: row.id,css_classes: 'col-12',content_type:'content_group',content_id: footer_group.id,position: 1).first_or_create


	# Themes

	theme_colors = {
		'grayscale' => [
			{'body_bg'=>'eeeeee'},
			{'head_bg'=>'eeeeee'},
			{'navigation_bg'=>'343a40'},
			{'navigation_link'=>'343a40'},
			{'navigation_link_hover'=>'343a40'},
			{'main_bg'=>'ffffff'},
			{'main_link'=>'343a40'},
			{'main_link_hover'=>'343a40'},
			{'footer_bg'=>'f4f4f4'},
			{'main_link'=>'343a40'},
			{'main_link_hover'=>'343a40'},
		],
		'keipress' => [
			{'body_bg'=>'eeeeee'},
			{'head_bg'=>'eeeeee'},
			{'navigation_bg'=>'343a40'},
			{'navigation_link'=>'343a40'},
			{'navigation_link_hover'=>'343a40'},
			{'main_bg'=>'ffffff'},
			{'main_link'=>'343a40'},
			{'main_link_hover'=>'343a40'},
			{'footer_bg'=>'f4f4f4'},
			{'main_link'=>'343a40'},
			{'main_link_hover'=>'343a40'},
		]
	}

	themes = {}
	['grayscale','keipress'].each do |class_name|
		theme = Theme.where(
				      name: class_name.capitalize,
				      css_class: class_name,
				      site_id: site.id
			     	).first_or_create!
		themes[class_name] = theme.id
		theme_colors[class_name].each do |color|
			palette_color = PaletteColor.find_by(value: color[color.keys[0]])
			ThemeColor.where(
			  name: color.keys[0],
	    	value: color[color.keys[0]],
	      theme_id: theme.id,
	      palette_color_id: palette_color.id
	    ).first_or_create!
		end

	end

	toggle_theme = 'keipress'
	i = 1
	['home','pinkman','goodman','blog','article','about'].each do |page_name|
		toggle_theme = toggle_theme == 'keipress' ? 'grayscale' : 'keipress'
		page = Page.where(
			name: page_name.capitalize,
			site_id: site.id,
			theme_id: themes[toggle_theme],
			assignment: page_name
		).first_or_create!
		NavigationItem.where(
			name: page_name.capitalize,
			label: page_name.capitalize,
			item_type: 'page_link',
			navigation_id: navigation.id,
			page_id: page.id,
			position: i).first_or_create!


		ContainersPage.where(container_id: header_container.id,page_id: page.id,position: 1).first_or_create
		ContainersPage.where(container_id: navigation_container.id,page_id: page.id,position: 2).first_or_create
		body = walter_text if i == 1
		body = pinkman_text if i == 2
		body = goodman_text if i == 3
		body = mike_text if i == 4
		body = '' if i == 5
		body = '' if i == 6

		content_group = ContentGroup.where(name: "#{page_name.capitalize} Group",site_id: site.id).first_or_create
		content = ContentGroupItem.where(name: "#{page_name.capitalize} Content").first
		unless content
			content = ContentGroupItem.create(name: "#{page_name.capitalize} Content", content_type: "text", content_id: content_group.id, text_html: 1, body: body, position: 1)
		end
		container = ContentContainer.where(name: "#{page_name.capitalize}",site_id: site.id,container_type: 'grid', rows_flag: 1,css_classes: '').first_or_create
		row = ContainerRow.where(container_id: container.id,css_classes: '',position: 1).first_or_create
		row_column = RowColumn.where(container_row_id: row.id,css_classes: 'col-12',content_type:'content_group',content_id: content_group.id,position: 1).first_or_create

		ContainersPage.where(container_id: container.id,page_id: page.id,position: 3).first_or_create
		ContainersPage.where(container_id: footer_container.id,page_id: page.id,position: 4).first_or_create
		i += 1
	end

	image1 = Image.where(
									name: 'Shiprock',
									caption: 'Shiprock New Mexico',
									site_id: site.id,
									copyright_year: 2018,
									copyright_by: 'V. Van Gough').first_or_create!

	image2 = Image.where(
									name: 'Canyonlands',
									caption: 'Canyonlands NP',
									site_id: site.id,
									copyright_year: 2018,
									copyright_by: 'V. Van Gough').first_or_create!

	image_group = ImageGroup.where(
									name: 'Southwest Group',
									site_id: site.id,
									image_id: image1.id
								).first_or_create!

	ImageGroupItem.where(
			image_group_id: image_group.id,
			image_id: image1.id
		).first_or_create

	ImageGroupItem.where(
			image_group_id: image_group.id,
			image_id: image2.id
		).first_or_create

	blog = Blog.where(
			name: 'My Blog',
			site_id: site.id,
			published: true
		).first_or_create!

	def gen_body
		"<h2>#{Faker::TvShows::GameOfThrones.house} #{Faker::TvShows::GameOfThrones.city}</h2>
		<p>#{Faker::TvShows::GameOfThrones.quote}<br>
		<icon class=\"icon-minus\"></icon> #{Faker::TvShows::GameOfThrones.character}</p>"
	end

	content_group = ContentGroup.where(
											name: 'Image Carosel',
											site_id: site.id
										).first_or_create

	ContentGroupItem.where(
		name: 'Southwest Images',
		content_type: "text",
		content_id: content_group.id,
		image_group_id: image_group.id,
		admin_id: 1,
	).first_or_create

	10.times do |i|
		post = BlogPost.where(
							content_id: blog.id,
							name: "Post #{10 - (i + 1)}"
						).first_or_create!(
							content_id: blog.id,
							name: "Post #{10 - (i + 1)}",
							admin_id: 1,
							content_type: "text",
							text_html: 1
						)

		post.body = gen_body
		post.save
	end

	3.times do |i|
		article = Article.where(
				name: "My Article #{i + 1}",
				site_id: site.id,
				published: true
		).first_or_create!
		4.times do |j|
			post = ArticlePost.where(
						content_id: article.id,
						name: "Post #{j + 1}",
					).first_or_create!(
						content_id: article.id,
						name: "Post #{j + 1}",
						admin_id: 1,
						content_type:  j == 3 ? "image" : j == 4 ? "image_group" : "text",
						image_id: j == 3 ? image2.id : nil,
						image_group_id: j == 4 ? image_group.id : nil,
						text_html: j == 3 || j == 4 ? nil : 1
					)
			post.body = gen_body
			post.save
		end
	end
end







