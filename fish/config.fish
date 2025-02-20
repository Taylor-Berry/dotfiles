if status is-interactive
    # Commands to run in interactive sessions can go here
end

### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin $HOME/.emacs.d/bin:$PATH  $HOME/.local/bin $HOME/.config/emacs/bin $HOME/Applications /var/lib/flatpak/exports/bin/ $fish_user_paths
set -gx PATH /usr/local/share/dotnet $PATH

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Sets the terminal type
set EDITOR "emacsclient -t -a ''"                 # $EDITOR use Emacs in terminal
set VISUAL "emacsclient -c -a 'emacs'"              # $VISUAL use Emacs in GUI mode


eval "$(/opt/homebrew/bin/brew shellenv)"


########### ALIASES ##########

## GENERAL ##
# Alias to open the config.fish file in nvim
alias config='nvim ~/.config/fish/config.fish'

## OBSIDIAN ##
# Alias to navigate to Obsidian Vault in iCloud Drive
alias oo='cd "/Users/taylorberry/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal Vault/Zettelkasten/Fleeting Notes/"'
# Alias to create a new Zettelkasten Fleeting Note
alias on='nvim "/Users/taylorberry/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal Vault/Zettelkasten/Fleeting Notes/$(date +%Y%m%d%H%M%S).md"'

alias oq='nvim "/Users/taylorberry/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal Vault/Quick Notes/$(date +%Y%m%d%H%M%S).md"'


# Alias/Function to Open a new Fleeting Note with a Template in Obsidians
# Function to create and open a new Obsidian Fleeting Note from a template
function of
    # Define the directory where new notes will be created
    set note_dir "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal Vault/Zettelkasten/Fleeting Notes"

    # Ensure the directory exists
    if not test -d "$note_dir"
        echo "Directory $note_dir does not exist. Please check the path."
        return 1
    end

    # Generate a timestamp in the format YYYYMMDDHHMMSS
    set timestamp (date +%Y%m%d%H%M%S)

    # Define the new filename
    set filename "$note_dir/$timestamp.md"

    # Define the path to your template file
    set template_file "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal Vault/Templates/FleetingNote.md"

    # Check if the template file exists
    if not test -f "$template_file"
        echo "Template file $template_file does not exist."
        return 1
    end

    # Create the new note from the template
    cp "$template_file" "$filename"

    # Optionally, replace placeholders in the template with actual values
    # For example, replace {{title}} and {{date}} with the timestamp
    sed -i '' "s/{{title}}/$timestamp/g" "$filename"
    sed -i '' "s/{{date}}/$(date +"%Y-%m-%d %H:%M:%S")/g" "$filename"

    # Open the new note in Neovim
    nvim "$filename"
end

# Function to create and open a new Obsidian Fleeting Note from a template
function ol
    # Define the directory where new notes will be created
    set note_dir "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal Vault/Zettelkasten/Literature Notes/"

    # Ensure the directory exists
    if not test -d "$note_dir"
        echo "Directory $note_dir does not exist. Please check the path."
        return 1
    end

    # Generate a timestamp in the format YYYYMMDDHHMMSS
    set timestamp (date +%Y%m%d%H%M%S)

    # Define the new filename
    set filename "$note_dir/$timestamp.md"

    # Define the path to your template file
    set template_file "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal Vault/Templates/LiteratureNote.md"

    # Check if the template file exists
    if not test -f "$template_file"
        echo "Template file $template_file does not exist."
        return 1
    end

    # Create the new note from the template
    cp "$template_file" "$filename"

    # Optionally, replace placeholders in the template with actual values
    # For example, replace {{title}} and {{date}} with the timestamp
    sed -i '' "s/{{title}}/$timestamp/g" "$filename"
    sed -i '' "s/{{date}}/$(date +"%Y-%m-%d %H:%M:%S")/g" "$filename"

    # Open the new note in Neovim
    nvim "$filename"
end 


## NVIM ##
# Alias to open nvim config file
alias nvc='nvim ~/.config/nvim/init.vim'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'


## LEETCODE ##
function leetcode
    # Check if a URL was provided
    if test -z "$argv[1]"
        echo "Please provide a LeetCode URL"
        return 1
    end

    # Define the directory for LeetCode notes
    set note_dir "$HOME/Taylor's Vault/leetcode"

    # Define scripts directory in dotfiles
    set scripts_dir "$HOME/dotfiles/scripts/leetcode"

    # Ensure directories exist
    if not test -d "$note_dir"
        mkdir -p "$note_dir"
    end

    if not test -d "$scripts_dir"
        echo "Scripts directory $scripts_dir does not exist. Please check your dotfiles setup."
        return 1
    end

    # Extract problem name from URL and format it
    # e.g., https://leetcode.com/problems/two-sum/ -> two-sum
    set problem_name (echo $argv[1] | sed -n 's/.*problems\/\([^/]*\)\/.*/\1/p')
    
    # Convert kebab-case to Title Case and add timestamp
    # e.g., "two-sum" -> "Two Sum - 20240101120000"
    set formatted_name (echo $problem_name | sed -e 's/-/ /g' -e 's/\b\(.\)/\u\1/g')
    set timestamp (date +%Y%m%d%H%M%S)
    set filename "$note_dir/$formatted_name.md"

    # Call the JavaScript script from dotfiles
    node "$scripts_dir/leetcode_scraper.js" "$argv[1]" "$filename"

    # Open the new note in Neovim
    nvim "$filename"
end

