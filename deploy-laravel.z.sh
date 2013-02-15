#!/bin/zsh
# Quickly Start A New Laravel Project
#


# Todo: Handle errors.
clear

print -P "%BHello.%b First things first -- let's get familiar with the project. Projects are assumed to have this file structure: %S Project Folder/Repo Folder/web root %s.\n"

# Todo: Just ask for the directory from the user.
while true; do read yn\?"Your current working directory should be inside an empty project folder. Is that where you are? (y/n) "
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) echo "\nGo create your project folder, then cd into it and run this script again.";
                exit;;
        * ) echo "Please answer 'y' for yes or 'n' for no, and then press [Enter].";;
    esac
done

mkdir Repo
cd Repo
echo "Getting Laravel..."
git clone git://github.com/laravel/laravel.git ./
print "\v"
# Get an IDE helper if needed.
while true; do read yn\?"Will you be using an IDE like Eclipse or PHPStorm on this project? (y/n) "
    case $yn in
        [Yy]* )	# Git will create the submodule directory! Do not create it yourself.
    			git submodule add -b master git://github.com/danielboendergaard/laravel-helpers.git ./application/.idehelper/
    			# The previous command stages the changes in the parent repo. Just commit.
    			git commit -m "Added an IDE helper file that enables IDEs to see the aliased laravel classes."

    			break;;

        [Nn]* ) break;;
        * ) echo "Please answer 'y' for yes or 'n' for no, and then press [Enter].";;
    esac
done

print "\v"

let "i = 0"
# Remove some default debris
while true; do read yn\?"Would you like to remove unnecessary project files, like readme and license? (y/n) "
    case $yn in
        [Yy]* ) ((i++))
                rm readme.md
                rm CONTRIBUTING.md
                rm license.txt
                break;;

        [Nn]* ) break;;
        * ) echo "Please answer 'y' for yes or 'n' for no, and then press [Enter].";;
    esac
done

print "\v"
while true; do read yn\?"Would you like to remove the 'home' view and controller? If you are new to Laravel, you probably want to leave them alone. (y/n) "
    case $yn in
        [Yy]* ) ((i++))
                rm -r ./application/views/home
                rm ./application/controllers/home.php
                rm -r ./public/laravel
                break;;

        [Nn]* ) break;;
        * ) echo "Please answer 'y' for yes or 'n' for no, and then press [Enter].";;
    esac
done

print "\v"
## Todo: Add system language detection. Do regex on $LANG
while true; do read yn\?"Would you like to remove the extra language files? If your application will only be in English, you can remove all other languages. Otherwise, choose 'no'. (y/n) "
    case $yn in
        [Yy]* ) ((i++))
    			mv ./application/language/en/ ./application/en/
    			rm -rf ./application/language/*
    			mv ./application/en/ ./application/language/en/
        		break;;

        [Nn]* ) break;;
        * ) echo "Please answer 'y' for yes or 'n' for no, and then press [Enter].";;
    esac
done

if [[ $i > 0 ]]; then
    git add --all
    git commit -m "Removed default Laravel files not necessary for this application."
fi


# Edit your application.php file
$EDITOR ./application/config/application.php:56:37
print "\v"

#zsh method...
read \?"Update your application.php file accordingly. When done, save the document. Then return to this prompt and press [Enter]. An application key will be generated for you."

#bash method...
# read -p "Update your application.php file accordingly. When done, save the document. Then return to this prompt and press [Enter]. An application key will be generated for you."

php artisan key:generate

print "\v"

$EDITOR ./application/config/database.php:70

read \?"Set up your database connection, save the document, then return to this prompt and press [Enter] to continue."

## Check for MAMP and address issue.
if [[ (( -d /Applications/MAMP )) ]]; then
    print -P "\vIt looks like you might be using MAMP. If so, you may also need to add the following line to your database config array:\n%S 'unix_socket'   => '/Applications/MAMP/tmp/mysql/mysql.sock', %s"

    while true; do read yn\?"Would you like that line copied to the clipboard? (y/n) "
        case $yn in
            [Yy]* ) echo "'unix_socket'   => '/Applications/MAMP/tmp/mysql/mysql.sock'," | pbcopy
                    print "It's on your clipboard.\v"
                    $EDITOR ./application/config/database.php:70:13
                    break;;

            [Nn]* ) break;;
            * ) echo "Please answer 'y' for yes or 'n' for no, and then press [Enter].";;
        esac
    done
fi

print "\v"

#zsh method
while true; do read yn\?"Do you wish to import jquery? (y/n) "
    case $yn in
        [Yy]* ) curl http://code.jquery.com/jquery-latest.min.js > ./public/js/jquery.js
                break;;

        [Nn]* ) break;;
        * ) echo "Please answer 'y' for yes or 'n' for no, and then press [Enter].";;
    esac
done

# Todo: Make Bash equivalent of the script.
#Bash Method...
# while true; do
#     read -p "Do you wish to install jquery? (y/n) " yn
#     case $yn in
#         [Yy]* ) curl http://code.jquery.com/jquery.js > ./public/js/jquery.js; return;;
#         [Nn]* ) return;;
#         * ) echo "Please answer yes or no.";;
#     esac
# done

print "\v"
while true; do read yn\?"Do you wish to import normalize.css? (y/n) "
    case $yn in
        [Yy]* ) curl https://raw.github.com/necolas/normalize.css/master/normalize.css > ./public/css/normalize.css;;
        [Nn]* ) break;;
        * ) echo "Please answer 'y' for yes or 'n' for no, and then press [Enter].";;
    esac
done

# Todo: Prompt for and import common laravel bundles
#
# bundles=(git://github.com/JeffreyWay/Laravel-Generator.git)

# bundle_folder_name = (^(.*/)*)([A-Za-z0-9_\-]*)(\.git$) ... and get $3


print -P "%S All done! %s"

