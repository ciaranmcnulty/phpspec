box.phar:
	curl -Lls https://github.com/humbug/box/releases/download/3.8.4/box.phar -o box.phar && chmod +x box.phar

composer.phar:
	ln -s `which composer` composer.phar || (curl -Lls https://getcomposer.org/installer | php)

phpspec.phar: box.phar vendor
	./box.phar compile
	vendor/bin/behat --profile=phar --format=progress || rm phpspec.phar

vendor: composer.phar
	./composer.phar install

.PHONY: clean
clean:
	rm -f phpspec.phar box.phar composer.phar
