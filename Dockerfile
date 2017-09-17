FROM python:2.7
RUN pip install uwsgi django==1.5.12 south ipaddr && \
    mkdir /var/log/uwsgi/

COPY . /opt/hamwan-portal

ENV DJANGO_SETTINGS_MODULE=hamwanadmin.settings
RUN cd /opt/hamwan-portal/ && \
    python manage.py syncdb --noinput && \
    python manage.py migrate --noinput

EXPOSE 9090

CMD uwsgi --master --protocol http --socket :9090 --module hamwanadmin.wsgi:application --chdir /opt/hamwan-portal
