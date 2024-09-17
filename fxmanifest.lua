fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'sobing'
decription 'text-ui like nopixel 4.0'

shared_scripts {
    'shared/*.lua'
}
client_scripts {
	'client/*.lua'
}
ui_page 'html/index.html'
files {
	'html/index.html',
	'html/style.css',
	'html/index.js'
}

exports {
    'displayTextUI',
    'hideTextUI',
	'changeText',
	'create3DTextUI',
	'update3DTextUI',
	'create3DTextUIOnPlayers',
	'delete3DTextUIOnPlayers',
	'delete3DTextUI'
}