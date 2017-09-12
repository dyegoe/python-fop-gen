[general]
; AMI definitions
manager_host=localhost
manager_port=5038
manager_user=fop
manager_secret=fopfopfop123
;event_mask=agent,call,command,system,user,dialplan

; Location where client files are installed
web_dir = /var/www/html/fop2

; Daemon definitios
;
; Please do not uncomment daemon definitions unless
; you really know what you are doing. Changing
; this will RESTRICT access to FOP2. You will have
; issues connecting to FOP2
;
; Listen IP restrict the interface where the server will
; bound to listen for incoming connections. Only useful
; if you have several NIC interfaces/networks and want to
; allow connections only to one of them
;
;listen_ip        = 192.168.1.1

; If you want to change the default port, uncomment this
; line and change the number. The web_dir setting above
; must be correct for this to work.
;
;listen_port      = 4445

; Restrict connections only for this domain when using
; flash xmlsockets. It does not work for websocket.
;
;restrict_host    = www.asternic.org


; Global Configuration
;
poll_interval      = 86400
poll_voicemail     = 1
monitor_ipaddress  = 0

; Force blind transfer on asterisk 1.6
blind_transfer     = 0

; Force supervised transfer on asterisk 1.4
; requires the atxfer manager backport patch
supervised_transfer = 1

; Force delimiter for asterisk applications
; force_parameter_delimiter = ","

; When adding or removing members to a queue, fop2 will default to
; AddQueueMember/RemoveQueueMember commands. If you set use_agentlogin
; to 1, together with the QueueChannel in a button definition set to
; an Agent number it will use AgentCallbackLogin and Agentlogoff instead.
;
; use_agentlogin = 0

; Master Password that overrides any individual one
;master_key = 5678

; Options to send to chan_spy when doing a Listen action
; This global setting is overriden by the individual button
; spyoptions directive if set (in the button config).
; Asterisk 1.6.1 or higher has the option "d" that lets you
; switch spying modes using the keypad:
;4 = spy mode
;5 = whisper mode
;6 = barge mode
spy_options="bq"

; Options to send to chan_spy when doing a Whisper action
; In Asterisk 1.6.1 or higher you can use B to enable barge (speak
; to both channels on a call).
whisper_options="w"

; When you spy onto an ongoing call, your spy session will
; be kept open after the original call ends (persistent_spy=1)
; If you want the spy session to be terminated instead,
; then be sure to uncomment the following line and that the
; value for persistent_spy is set to 0
;persistent_spy=0

; When a spy session is initiated, the callerid will show
; the spied on extension number. This will help supervisors
; identified who are they listenting to. If you want to hide
; that fact/info then uncomment the following setting to show
; the supervisor extension number in the callerid
;conceal_spied_extension=1

; Some buggy Asterisk versions will set the callerid for
; outbound call legs to the dial pattern/regexp instead of the
; dialed number. In those case, you might want FOP2 to
; ignore the callerid on Bridge/Link events, so uncomment
; and set the followgin value to 1
;ignore_clid_on_bridge=0

; Variable to set on Originate commands, can be used to set
; sip headers for auto answer or distinctive ringing.
; originate_variable=_SIPADDHEADER51=Call-Info: answer-after=0.001

; Filename to use when start monitoring, you can use ${UNIQUEID},
; ${ORIG_EXTENSION}, ${DEST_EXTENSION}
; and date formats %Y %m %d to construct the filename.
;
; Settings for modifying the recording filename
; Available variables are:
; ${UNIQUEID} = Unique Id of the call
; ${TIMESTAMP} = Unix Timestamp when the recording was initiated
; ${CLIDNUM} = Callerid or Dialed number for the active call
; ${CLIDNAME} = Callerid name for the active call
; ${DEST_EXTENSION} = Target extension being monitored
; ${ORIG_EXTENSION} = Extension/User that started the recording (not
;                     the other leg)
; ${MBOX}           = Mailbox of the extension/user that started the
;                     recording
; ${FOP2CONTEXT}    = FOP2 Panel Context
;
; Date variables:
; %Y 4 digits year
; %y 2 digits year
; %m 2 digits month
; %d 2 digits day
; %h 2 digits hour
; %i 2 digits minute
; %s 2 digits seconds

; For elastix Monitoring Tab:
; monitor_filename=g${DEST_EXTENSION}-${UNIQUEID}

; For fop2 recording interface
monitor_filename=/var/spool/asterisk/monitor/${ORIG_EXTENSION}_${DEST_EXTENSION}_%h%i%s_${UNIQUEID}_${FOP2CONTEXT}
monitor_format=wav
monitor_mix=true

; To enable the recording interface you must uncomment the following
; line, but also you might need to modify the script a little bit
; depending on the sox version you have installed.
;
monitor_exec=/usr/local/fop2/recording_fop2.pl

; You could specify your own script to be executed when the recording
; is finished. It will receive 3 parameters, the complete
; path and filename of the IN leg, the OUT leg and the final
; recording NAME. You should run soxmix in your script to join
; the recordings into one file.
;
; monitor_exec=/var/lib/asterisk/bin/postrecording-script.sh

; FOP2 can fire notifications/popups when an extension or queue
; member receives a call. The default behaviour is to show a
; notification on state RINGING (notify_on_ringing=1).
;
; To customize notifications, you must uncomment the custom_popup
; function in checkdir.php you can replace that notification with
; a custom popup function to integrate with other web applications.
;
; For call centers you might need to perform a popup not on the
; RINGING state but when the call is CONNECTED to an agent. If you
; set in the queue configuration in queues.conf the option
; eventwhencalled=yes and then set here notify_on_connect=1,
; fop2 will send notifications on queue connected calls
; during AGENTCONNECT events. This will only work for inbound calls
; from a queue.
;
; notify_on_ringing = 1
; notify_on_connect = 1

; Call pickup uses the pickupmark variable by default. In multi tenant
; systems this might lead to problems as you might end un picking up
; some other tenant call. In that case you might want to try to
; pickup the call by its context uncomenting the following line:
;
; no_pickupmark=1

; If your asterisk version supports the pickupchan application it is
; much better to use this than the regular pickup application as it will
; be directed towards the channel and not the extension, makeing it
; more precise.
;
; use_pickupchan=1

; Path to your voicemail directory
; For voicemail to work the fop2 server must run on the same server
; as asterisk, or your voicemail directory must be network mounted
voicemail_path=/var/spool/asterisk/voicemail

; For odbc based voicemail storage, you can set voicemail path to
; dbi:ODBC:name , where name is the dsn name as setup in odbc.ini
; By default the voicemessages table will be used, if you use a
; different one, you can specify it by appending !tablename
;
;voicemail_path=dbi:ODBC:asterisk!voicemessages

; By default IM chats are not logged/saved. If you uncomment
; the following parameter, all chats will be stored on the chatlog
; table inside the fop2settings.db sqlite database.
;
; save_chat_log=1


; Khomp GSM interface to send SMS messages
; If there is a card plugged, fop2 will auto discover it
; and use the first one available. If you want to change it
; to a fixed one, uncomemnt the folowing line and change the name
; to your liking
;
; khomp_gsm=b0c0

; Chan Dongle interface to send SMS messages
;
; dongle_gsm=dongle01

; SMS Web based API
;
; It is possible to define a web based sms provider to send SMS via FOP2
; The parameters to set are sms_api_url, smps_api_method, sms_api_user,
; sms_api_password and sms_api_reponse_error
;
; The sms_api_url parameter must include the parameters to send to the API
; provider to send the message, you can use the following variables on them
; ${MESSAGE}  The sms message to send
; ${NUMBER}   The destination number to send the SMS
;
; The sms_api_response_error is the string returned by the web call if
; there was an error with the sending. The default value is 'error', but
; some providers might respond with some other strings. Anything returned
; that does not contain the error string will be considered as a successful
; delivery
;
; Sample to send SMS via yx wireless gateways, replace GATEWAY_ADDRESS,
; USER and PASSWORD with the correct values for your system:
;
; sms_api_url=http://GATEWAY_ADDRESS/cgi-bin/exec?cmd=api_queue_sms&username=USER&password=PASSWORD&content=${MESSAGE}&destination=${NUMBER}&api_version=0.05&channel=1
; sms_api_method=GET
; sms_api_user=USER
; sms_api_password=PASSWORD

; Sample to send SMS via smsified.com service, replace SERVICENUMBER,
; USER and PASSWORD with the correct values for your system:
;
; sms_api_url=http://api.smsified.com/v1/smsmessaging/outbound/SERVICENUMBER/requests?address=${NUMBER}&message=${MESSAGE}
; sms_api_method=POST
; sms_api_user=USER
; sms_api_password=PASSWORD
; sms_api_response_error=error
; sms_api_ok_message=SMS Sent!


; --- SAMPLE CUSTOM PERMISSIONS ---
; format: perm= CUSTOM_NAME : PERMISSIONS : DEVICES
; perm=salessupervisor:hangup,spy,queuemanager:SIP/604,SIP/607,SIP/605,SIP/606
;
; A custom permission can later be assigned to a user, you cannot use
; a reserved permission name for it or you will have issues.
; --- END SAMPLE ---


; --- SAMPLE GROUPS ---
; group=queues:QUEUE/100,QUEUE/101
; group=deptA:SIP/100,SIP/101,SIP/102
; --- END SAMPLE ---

; --- SAMPLE PLUGINS ---
; You can load plugins to alter or add functionality to FOP2
;
; Format of the line is plugin=name:path
;
; Plugins consists of a .js file and optional .css file that
; must be stored in any subdirectory. The name of the plugin
; will be used as the .js and .css filenames to match. The
; following line will attempt to load the files sample.css
; and sample.js from /var/www/html/fop2/plugins/sample:
;
; plugin=sample:/var/www/html/fop2/plugins/sample
;
; --- END SAMPLE ---

; --- SAMPLE USER LIST ---
; format: user= EXTENSION : SECRET : PERMISSIONS : GROUPS : PLUGINS
; You can enumerate several permissions and groups separated by comma
; available permissions:  'all', 'dial', 'hangup', 'meetme', 'pickup',
;                         'record', 'spy', 'transfer', 'transferexternal',
;                         'queuemanager', 'queueagent', 'phonebook',
;                         'chat', 'preferences', 'hangupself', 'chat'
;                         'recordself', 'voicemailadmin', 'broadcast',
;                         'sms', 'smsmanager'
;
; user=620:1234:all:queues:sample
; user=621:1234:dial,transfer,pickup:deptA
; user=622:1234:all
; user=623:1234:meetme,pickup
; buttonfile=buttons.cfg
; ------ END SAMPLE ------

; If you access fop2 via https, browsers will try to use wss (Secure
; web sockets) and for that it requires a certificate file and key file,
; the same ones you have in your web server configuration. Be sure to
; specify the correct certificates, the defaults are the ones for a
; regular Centos installation:
;
ssl_certificate_file=/etc/pki/tls/certs/localhost.crt
ssl_certificate_key_file=/etc/pki/tls/private/localhost.key

; In complex setups you can use haproxy in front and several fop2 servers
; behind. In such cases, you might have haproxy negotiating secure web
; sockets but talking regular websockets on the backends so you can have just
; one ssl certificate on the proxy machine. In those cases, you still need
; to signal the web clients than ssl is being used, while on the server
; you should not use any certificates. For doing this uncomment the following
; line and comment the ssl_certificate_xx entries above
;
;sslproxy=1

; If you want Redirect actions (pickup from queue) to perform an auto answer,
; you will need to use an intermediate context in order to set the proper header
; before the  redirection goes to your extension.
; A sample context should look like this (and must be placed somewhere in your dialplan):
;
; [custom-fop2-autoanswer-redirect]
; exten = _.,1,Set(ARRAY(RETURN_EXTENSION,RETURN_CONTEXT)=${CUT(EXTEN,:,1)},${CUT(EXTEN,:,2)})
; exten = _.,n,Set(_ALERTINFO=Alert-Info: Ring Answer)
; exten = _.,n,Set(_CALLINFO=Call-Info: <uri>\;answer-after=0)
; exten = _.,n,Goto(${RETURN_CONTEXT},${RETURN_EXTENSION},1)
;
; You should uncomment this line and set the context name to the one you created.
;
;override_redirect_context=custom-fop2-autoanswer-redirect

; If you want to kick browsers when there is no activity, then uncomment the
; following line and set a timeout value in seconds. Zero means no timeout
; control (default)
;
;client_timeout=0

; The following line is NOT commented, it executes
; the autoconfig configuration for FreePBX, if you do
; manual configuraiton, be sure to REMOVE it or you will
; have issues.
#exec autoconfig-users.sh
;---INICIO
buttonfile=buttons.cfg
{% for group in groups %}
{{ group }}
{%- endfor %}

;---- Admin
user=9844:98449844:all
{%- for group in groups_desc -%}
{%- if groups_desc[group][1] %}
;---- {{ groups_desc[group][0] }}
user={{ groups_desc[group][1] }}:{{ groups_desc[group][1] }}{{ groups_desc[group][1] }}:meetme,hangup,pickup,spy,whisper:{{ group }}
{%- endif -%}
{% endfor %}
;---FIM
