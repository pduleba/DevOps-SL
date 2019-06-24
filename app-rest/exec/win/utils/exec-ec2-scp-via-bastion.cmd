:: Win Script
@scp ^
	-o ProxyCommand="ssh ec2-user@%2 nc %3 22" ^
	%1 ec2-user@%3:~/