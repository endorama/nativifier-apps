#!/usr/bin/env bash

# globals
destination="$(dirname "$PWD")/ready"
electron_version="9.0.5"
options=""

## add a CLI option to the options global
add_option() {
    local opt
    opt=$1
    options="$options $opt"
}

# add single instance option
force_single_instance() {
    add_option "--single-instance"
}

# add inject option with predefined path
# optionally a different path can be specified
# inject <path (default inject.js)>
inject() {
    local file
    file=${1:-inject.js}
    add_option "--inject $file"
}

# add global shortcuts option with predefined path
# optionally a different path can be specified
# set_global_shortcuts <path (default inject.js)>
set_global_shortcuts() {
    local file
    file=${1:-shortcuts.json}
    add_option "--global-shortcuts $file"
}

# this is the heart of the scripts
# once call with <name> <url> will perform nativefication of the require url
nativefy() {
    local name
    name=$1
    local url
    url=$2
    local options
    options=$3

    cmd="nativefier --name $name"
    cmd="$cmd --electron-version $electron_version"

    echo "$cmd $options $url $destination"
    echo "nativefier build logs:"
    eval "$cmd $options $url $destination"
}

# no desktop app is complete without a .desktop file to run it, so create it here
create_desktop_file() {
    local name
    name=$1
    local keywords
    keywords=$2
    local categories
    categories=$3

    echo "creating desktop file"
    cat <<-EOL > "$destination/$name.desktop"
[Desktop Entry]
Version=1.0
Name=$name
Comment=Nativefied from $url
#GenericName=Music Player
Keywords=$name;$keywords
Exec=$destination/$name-linux-x64/$name
Terminal=false
X-MultipleArgs=false
Type=Application
Icon=$destination/$name-linux-x64/resources/app/icon.png
Categories=$categories
StartupNotify=true
EOL
}

# desktop files should be "installed" in the proper folder so that the OS can recognize them
# this step is separated from creation to allow easier debugging
install_desktop_file() {
    local name
    name=$1

    echo "installing desktop file"
    desktop-file-install --dir="$HOME/.local/share/applications" "$destination/$name.desktop"
}
