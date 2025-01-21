fx_version 'adamant'
games {'rdr3'}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

author "Project Sloth & OK1ez"
version '1.1.6'
description 'Admin Menu'
repository 'https://github.com/Project-Sloth/ps-adminmenu'

lua54 'yes'

ui_page 'html/index.html'

client_script {
  'client/**',
}

server_script {
  "server/**",
  "@oxmysql/lib/MySQL.lua",
}

shared_script {
  '@ox_lib/init.lua',
  "shared/**",
}

files {
  'html/**',
  'data/ped.lua',
  'data/object.lua',
  'locales/*.json',
}

ox_lib 'locale' -- v3.8.0 or above
