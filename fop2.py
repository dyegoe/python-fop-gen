#!/usr/bin/python

import MySQLdb
import re
import os
import jinja2

# this is the final destination of fop2.cfg. Usually where you have been installed fop2
fop2_file = 'fop2.cfg'
# this is the template which is used to generate the final file (above)
fop2_tpl = 'fop2-v2-cfg.tpl'
# this is the final destination of buttons.cfg. Usually where you have been installed fop2
buttons_file = 'buttons.cfg'
# this is the template which is used to generate the final file (above)
buttons_tpl = 'buttons-v2-cfg.tpl'


def db_connect(db='snep'):
    return MySQLdb.connect('127.0.0.1', 'root', 'sneppass', db)


def db_disconnect(conn):
    conn.close()


def db_query(conn, query):
    cursor = conn.cursor()
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    return result


def snep_peers():
    conn = db_connect()
    results = db_query(conn, 'SELECT p.name, p.callerid, c.group_id FROM peers as p \
                              RIGHT JOIN core_peer_groups as c ON p.id = c.peer_id WHERE c.group_id != 1')
    db_disconnect(conn)
    return dict((str(peer_number), [re.sub(r' \(.*', "", callerid).decode('utf-8'), str(callgroup)])
                for peer_number, callerid, callgroup in results)


def snep_groups(peers):
    groups = {}
    result = []
    for peer in peers:
        if peers[peer][1] in groups:
            groups[peers[peer][1]].append("SIP/{}".format(peer))
        else:
            groups[peers[peer][1]] = ["SIP/{}".format(peer)]
    for group in groups:
        result.append("group={}:{}".format(group, ",".join(groups[group])))
    return result


def snep_groups_desc():
    conn = db_connect()
    results = db_query(conn, 'SELECT * FROM core_groups')
    db_disconnect(conn)
    return dict((str(group_id), [group_desc, "".join(re.findall(r'[0-9]{4}', group_desc))]) for group_id, group_desc in results)


def render_file(template_path, context):
    path, filename = os.path.split(template_path)
    return jinja2.Environment(loader=jinja2.FileSystemLoader(path or './')).get_template(filename).render(context)


context = dict()
context['peers'] = snep_peers()
context['groups'] = snep_groups(context['peers'])
context['groups_desc'] = snep_groups_desc()

with open(fop2_file, "w") as fop2_file_open:
    fop2_file_open.write(render_file(fop2_tpl, context).encode('utf8'))

with open(buttons_file, "w") as buttons_file_open:
    buttons_file_open.write(render_file(buttons_tpl, context).encode('utf8'))
