# Deploy Laravel

A simple ZSH shell script help you quickly start a new [Laravel](https://github.com/laravel/laravel) project. Through a series of prompts, you can easily download jQuery and normalize.css, fix a known issue with MAMP and more.

## Known Issues

This thing is seriously **alpha**. It doesn't yet catch errors if it goes off track. Major changes are commited to the repository, so you can roll back. `ctrl+c` will exit the application at any time.

## To Do

 - Create a **BASH** version to work with default OSX setup.
 
 - Ask for the project folder if it's created, or if it isn't created, ask for the name and then make it.
 
 - Currently uses the `$EDITOR` variable, but most people don't have it set to their preferred editor. Maybe detect Textmate or Sublime Text?
 
 - Catch errors and guide the flow better.
 
 - Bootstrap and SCSS Bootstrap import.
