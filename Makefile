SENTRY_AUTH_TOKEN=e5a5d8b8c50244fdb454872555d7955714c1c04d004f499d8a289b9b20888a7c
SENTRY_URL=https://sentry.365my.biz/
SENTRY_ORG=sentry
SENTRY_PROJECT=python
VERSION=`sentry-cli releases propose-version`

deploy: install create_release associate_commits run_django

install:
	pip install -r ./requirements.txt

create_release:
	sentry-cli --url $(SENTRY_URL) releases -o $(SENTRY_ORG) new -p $(SENTRY_PROJECT) $(VERSION)

associate_commits:
	sentry-cli  --url $(SENTRY_URL) releases -o $(SENTRY_ORG) -p $(SENTRY_PROJECT) \
		set-commits $(VERSION) --auto

run_django:
	VERSION=$(VERSION) python manage.py runserver
