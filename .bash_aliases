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

function tnew () {
    tmux new -s $1
}

function tls () {
    tmux ls
}

function tattach () {
    tmux attach -t $1
} 
