# django_docker_deploy

Project Path : *wbdap_workspace/django_docker_deploy*

**ONEMLI NOT:** Bu referans bir uygulamadir. Django, gunicorn, mysql ve nginx kullanilarak ornek bir django deployment ortaminin nasil olusturulacagi gosterilmektedir. Wbdap projesi icin kullanilan gercek kurulum ortami wbdap_servers dizini icindedir.

All necessary services for the sample django production deployment of the project are added as seperate containers.
This folder contains the container definitions for deployment, wbdap_servers provides component servers which are not serving the application itself.

In this example, the django project is served by a gunicorn wsgi server which is behind a nginx reverse proxy server.
