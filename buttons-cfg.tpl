{% for peer in peers %}
[SIP/{{ peer }}]
type=extension
extension={{ peer }}
context=from-internal
label={{ peers[peer][0] }}
{% endfor %}