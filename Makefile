IMAGENAME = jeboehm/php-base

.PHONY: ci
ci: image test


.PHONY: image
image:
	docker build -t $(IMAGENAME):latest .

.PHONY: test
test:
	docker run -it --rm -v $(CURDIR)/tests:/var/www/html $(IMAGENAME) /var/www/html/run_tests.sh
