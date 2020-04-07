#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )"/../ && pwd )"
CDIR=$( pwd )
log=$DIR/.tmp/log

cd $DIR

cat config/plugins | while read plugin
do
	[[ "$plugin" =~ ^#.*$ ]] && continue

	IFS='@' read -r -a pl <<< "$plugin"
	plugin_name=${pl[0]// }
	plugin_version=${pl[1]// }

	
	if [[ -z "${plugin_version}" ]]; then
		echo "find the latest $plugin_name version"
		filename=$(curl -s  https://wordpress.org/plugins/$plugin_name/ | grep -o "https:\/\/downloads\.wordpress\.org\/plugin\/.*\.zip" | egrep -o "[^\/]*.zip")
	else
		filename="$plugin_name.$plugin_version.zip"
	fi

	
	url="https://downloads.wordpress.org/plugin/$filename"
	output_file=".tmp/plugin-$filename"
	
	if [ ! -f $output_file ]; then
		echo "downloading $filename"
	    wget $url -O $DIR/$output_file 

	    cd $DIR/wp-content/plugins

	    echo "unzipping $plugin_name version $plugin_version"
	    unzip -o $DIR/$output_file >> $log

	    cd $DIR

	    grep -q -F "wp-content/plugins/$plugin_name" .gitignore || echo "
wp-content/plugins/$plugin_name" >> .gitignore
	fi
	
done

cd $DIR

cat config/themes | while read theme
do
	[[ "$theme" =~ ^#.*$ ]] && continue

	IFS='@' read -r -a pl <<< "$theme"
	theme_name=${pl[0]// }
	theme_url=${pl[1]// }

	
	
	output_file=".tmp/theme-$theme_name.zip"
	
	if [ ! -f $output_file ]; then
		echo "downloading $theme_name"
	    wget $theme_url -O $DIR/$output_file 

	    cd $DIR/wp-content/themes

	    echo "unzipping $theme_name"
	    unzip -o $DIR/$output_file >> $log

	    cd $DIR

	    grep -q -F "wp-content/themes/$theme_name" .gitignore || echo "
wp-content/themes/$theme_name*" >> .gitignore
	fi
	
done

# volta pra pasta original
cd $CDIR;