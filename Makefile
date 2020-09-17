build: build-mkdocs

docker-build: docker-build-mkdocs

run: run-mkdocs

publish: publish-mkdocs

clean:
	rm -rf output

build-docker:
	docker build -t docs-like-code-demo .



  
docker-run-mkdocs:
	docker run --rm -it -v `pwd`/docs:/data -p 8000:8000 docs-like-code-demo mkdocs serve -a 0.0.0.0:8000

docker-build-mkdocs: clean
	docker run --rm -it -v `pwd`/docs:/data docs-like-code-demo mkdocs build 
	mkdir -p output/
	cp -r  docs/site/* output/

docker-publish-mkdocs:
	docker run --rm -it -v `pwd`:/data -v "$(HOME)/.ssh":/root/.ssh docs-like-code-demo mkdocs gh-deploy -f docs/mkdocs.yml

run-mkdocs:
	mkdocs serve -f docs/mkdocs.yml -a 0.0.0.0:8000

build-mkdocs: clean
	mkdocs build -f docs/mkdocs.yml
	mkdir -p output/
	cp -r  docs/site/* output/

publish-mkdocs:
	mkdocs gh-deploy -f docs/mkdocs.yml


