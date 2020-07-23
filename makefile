# make git m="your message"
git:
	git pull
	git add --ignore-errors .
	git commit -m "$m"
	git push -u origin master 