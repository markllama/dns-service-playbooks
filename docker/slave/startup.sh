#!/bin/sh
#
# Generate files from templates
#
J2=${J2:-/usr/bin/jinja2-2.7}

ZONE=${ZONE:-example.com}
FORWARDERS=${FORWARDERS:-"['4.2.2.1', '4.2.2.2', '4.2.2.3']"}
MASTERS=${MASTERS:-"['4.2.2.1', '4.2.2.2', '4.2.2.3']"}
UPDATE_KEY=${UPDATE_KEY:-""}

FILES="/etc/named.conf /etc/named/zones.conf /etc/named/update.key"

function transform() {
		# FILE=$1
		$J2 ${1}.j2 <<EOF > ${1}
{
  'zone_name': '${ZONE}',
  'forwarders': ${FORWARDERS},
  'update_key': '${UPDATE_KEY}',
  'masters': ${MASTERS}
}
EOF
}


for FILE in $FILES ; do
		transform $FILE
done

exec /usr/sbin/named -u named -g $*
