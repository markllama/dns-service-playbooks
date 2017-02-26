#
FROM fedora
LABEL Description="A DNS master server"

# ZONE
# ADMIN_EMAIL
# FORWARDERS
# UPDATE_KEY

RUN dnf install -y bind bind-utils python2-jinja2-cli && dnf clean all

EXPOSE 53/TCP
EXPOSE 53/UDP

# startup.sh
#
# /etc/named.conf
# /etc/named/update.key
# /etc/named/zones.conf
# /var/named/dynamic/<zone>.db
#
ADD templates/named.conf.j2 /etc/named.conf.j2
ADD templates/update.key.j2 /etc/named/update.key.j2
ADD templates/zones.conf-master.j2 /etc/named/zones.conf.j2
ADD templates/zone.db.j2 /var/named/dynamic/zone.db.j2

ADD startup.sh /root/startup.sh
RUN chmod 770 /root/startup.sh

CMD /root/startup.sh
