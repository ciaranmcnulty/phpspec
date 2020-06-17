box.phar:
	curl -LSs https://box-project.github.io/box2/installer.php | php

php-scoper.phar:
	curl -LSs https://github.com/humbug/php-scoper/releases/download/0.13.2/php-scoper.phar -o php-scoper.phar
	chmod +x php-scoper.phar

composer.phar:
	curl -LSs https://getcomposer.org/installer | php

.PHONY: clean
clean:
	rm -rf build phpspec.phar	

build: composer.phar php-scoper.phar
	./composer.phar update --no-dev
	./php-scoper.phar --no-interaction add-prefix

phpspec.phar: build box.phar composer.phar
	cd build; \
	../composer.phar dump-autoload -o && \
	../box.phar build

.PHONY: test-scopes
test-scopes: build
	cd build; \
	chmod +x bin/phpspec; \
	../composer.phar dump-autoload; \
	./bin/phpspec r -v
