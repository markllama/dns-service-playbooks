#!/bin/sh
#
# Generate files from templates
#
J2=${J2:-/usr/bin/jinja2-2.7}

ZONE=${ZONE:-example.com}
ADMIN_EMAIL=${ADMIN_EMAIL:-admin.${ZONE}}
NAMESERVERS=${NAMESERVERS:-"[{'name': 'ns1', 'address': '1.2.3.4'}]"}
FORWARDERS=${FORWARDERS:-"['4.2.2.1', '4.2.2.2', '4.2.2.3']"}
UPDATE_KEY=${UPDATE_KEY:-""}

FILES="/etc/named.conf /etc/named/zones.conf /etc/named/update.key /var/named/dynamic/zone.db"

ZONE_FILE="/var/named/dynamic/${ZONE}.db"

function transform() {
		# FILE=$1
		$J2 ${1}.j2 <<EOF > ${1}
{
  'zone_name': '${ZONE}',
  'admin_email': '${ADMIN_EMAIL}',
  'forwarders': '${FORWARDERS}',
  'update_key': '${UPDATE_KEY}',
  'nameservers': ${NAMESERVERS}
}
EOF
}


for FILE in $FILES ; do
		transform $FILE
done

exec /usr/sbin/named -u named -g $*
