all: data encrypt
data:
	mkdir -p data
	echo "data" >> .gitignore
	echo "data.tar" >> .gitignore
data.tar: data/*
	tar czf data.tar data
encrypt: data.tar
	keybase encrypt --anonymous -i data.tar yanzay | split -b 40m - data.enc.
	rm data.tar
push: encrypt
	git add .
	git commit -m "Secret commit."
	git push origin master
clean:
	-rm data.enc.* data.tar

