function bashmod () {
	pre=$(shasum ~/.bash_aliases); 
   	vim ~/.bash_aliases; 
        post=$(shasum ~/.bash_aliases); 
      
	if [ "$pre" = "$post" ]; then 
		echo "~/.bash_aliases not changed"; 
	
	else 
       		. ~/.bash_aliases; 
       	fi 
}

function copy_aliases() {
	scp ~/.bash_aliases $1:~/.bash_aliases
}

function delete_conda_env() {
  # Prompt the user and read the input
  read -p "Are you sure you want to delete the conda environment '$1'? Type 'y' to confirm: " user_input

  # Check if the user input is 'y'
  if [ "$user_input" = "y" ]; then
    # Delete the conda environment
    echo "Deleting the conda environment '$1'..."
    conda env remove --name "$1"
    echo "Environment '$1' has been deleted."
  else
    # User did not confirm with 'y', so do not delete the environment
    echo "Environment deletion cancelled."
  fi
}

size() {
  local depth=$1

  # Validate input depth
  if ! [[ "$depth" =~ ^[0-9]+$ ]]; then
    # echo "Depth must be a non-negative integer." >&2
    # return 1
    depth=1
  fi

  # Use find and process files and directories to include sizes
  find . -maxdepth "$depth" \( -type d -o -type f \) -print0 |
    while IFS= read -r -d '' item; do
      size=""
      if [ -f "$item" ]; then
        # Get the size of files
        size=$(du -h --apparent-size --max-depth=0 "$item" | awk '{print $1}')
      elif [ -d "$item" ]; then
        # Get the cumulative size of directories
        size=$(du -sh --apparent-size "$item" | awk '{print $1}')
      fi

      # Format the file tree structure
      depth_level=$(echo "$item" | awk -F'/' '{print NF - 1}')
      indent=""
      for ((i = 0; i < depth_level; i++)); do
        indent+="│   "
      done

      if [ -d "$item" ]; then
        echo "${indent}├── ${item##*/}/ ($size)"
      else
        echo "${indent}├── ${item##*/} ($size)"
      fi
    done
}

function mcd () {
	mkdir $1;
	cd $1;
}

function tnew () {
    tmux new -s $1
}

function tls () {
    tmux ls
}

function tattach () {
    tmux attach -t $1
} 

function print() {
    # Check if a valid Kerberos ticket exists
    if ! klist -s; then
        echo "No valid Kerberos ticket found. Authenticating..."
        kinit jacob33@CS.WASHINGTON.EDU
    else
        echo "Valid Kerberos ticket found."
    fi

    # Send the file to the printer
    lpr -P pgcG60 -o sides=two-sided-long-edge "$1"
}

# Aliases:
alias explore="xdg-open ."

