Role Name
=========

A brief description of the role goes here.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

Internal?

HAProxy Config Info
------------------

Ref:<br />
https://cbonte.github.io/haproxy-dconv/1.8/configuration.html
https://www.haproxy.com/blog/layer-4-and-layer-7-proxy-mode/
https://www.haproxy.com/blog/haproxy-log-customization/
https://www.haproxy.com/blog/redirect-http-to-https-with-haproxy/

Check the above docs for more detailed information.

<b>maxconn</b> - Sets the maximum per-process number of concurrent connections to <number>. It is equivalent to the command-line argument "-n". Proxies will stop accepting connections when this limit is reached.

<b>nbproc</b> - How many HAProxy instances to run. This is only usable for multi-threading capable CPUs. Each instance reprents 1 CPU.

<b>cpu-map</b> - Specifies CPU sets for process or thread sets. Any process IDs above nbproc and any thread IDs above nbthread are ignored.

<b>tune.ssl.default-dh-param</b> - Sets the maximum size of the Diffie-Hellman parameters used for generating the ephemeral/temporary Diffie-Hellman key in case of DHE key exchange.

<b>tune.ssl.cachesize</b> - Sets the size of the global SSL session cache, in a number of blocks. A block is large enough to contain an encoded session without peer certificate.

<b>tune.ssl.lifetime</b> - Sets how long a cached SSL session may remain valid. This time is expressed in seconds and defaults to 300 (5 min).

<b>tune.ssl.maxrecord</b> - Sets the maximum amount of bytes passed to SSL_write() at a time. Default value 0 means there is no limit. Over SSL/TLS, the client can decipher the data only once it has received a full record.

<b>ssl-default-bind-ciphers</b> - This setting is only available when support for OpenSSL was built in. It sets the default string describing the list of cipher algorithms ("cipher suite") that are negotiated during the SSL/TLS handshake up to TLSv1.2 for all "bind" lines which do not explicitly define theirs.

<b>ssl-default-bind-options</b> - This setting is only available when support for OpenSSL was built in. It sets default ssl-options to force on all "bind" lines.

<b>ssl-default-server-ciphers</b> - This setting is only available when support for OpenSSL was built in. It sets the default string describing the list of cipher algorithms that are negotiated during the SSL/TLS handshake up to TLSv1.2 with the server, for all "server" lines which do not explicitly define theirs.

<b>log</b> - Adds a global syslog server. Several global servers can be defined. They will receive logs for starts and exits, as well as all logs from proxies configured with "log global".

<b>log-send-hostname</b> - Sets the hostname field in the syslog header. If optional "string" parameter is set the header is set to the string contents, otherwise uses the hostname of the system.

<b>stats socket</b> - Binds a UNIX socket to [path] or a TCPv4/v6 address to [address:port]. Connections to this socket will return various statistics outputs and even allow some commands to be issued to change some runtime settings.

<b>mode</b> - Specifies what network layer to operate in: Layer 4 - Transport (mode tcp) or Layer 7 - Application (mode http)

<b>option httplog</b> - Enable logging of HTTP request, session state and timers. 

<b>option log-health-checks</b> - Enable or disable logging of health checks status updates.

<b>option log-separate-errors</b> - Change log level for non-completely successful connections.

<b>option http-keep-alive</b> - Enable or disable HTTP keep-alive from client to server.

<b>option clitcpka</b> - Enable or disable the sending of TCP keepalive packets on the client side.

<b>timeout connect</b> - Set the maximum time to wait for a connection attempt to a server to succeed.

<b>timeout client</b> - Set the maximum inactivity time on the client side.

<b>timeout server</b> - Set the maximum inactivity time on the server side.

<b>balance [algorithm]</b> - (We tend to use roundrobin) The algorithm used to select a server when doing load balancing. This only applies when no persistence information is available, or when a connection is redispatched to another server.

<b>default-server</b> - Change default options for a server in a backend.

<b>monitor-uri</b> - Intercept a URI used by external components' monitor requests.

<b>monitor-net</b> - Declare a source network which is limited to monitor requests.

<b>bind</b> - Define one or several listening addresses and/or ports in a frontend.

<b>stats uri</b> - Enable statistics and define the URI prefix to access them.

<b>frontend (proxy)</b> - A "frontend" section describes a set of listening sockets accepting client connections.

<b>backend (proxy)</b> - A "backend" section describes a set of servers to which the proxy will connect to forward incoming connections.

<b>log-format</b> - The directive log-format allows you to customize the logs in http mode and tcp mode. It takes a string as argument.

<b>option forwardfor</b> - Enable insertion of the X-Forwarded-For header to requests sent to servers.

<b>http-request set-header [name] [fmt]</b> - Appends an HTTP header field whose name is specified and whose value is defined which follows the log-format rules. The header name is first removed if it existed.

<b>capture request header [name]</b> - Capture and log the last occurrence of the specified request header.

<b>acl [name] [command(s)]</b> - The use of Access Control Lists (ACL) provides a flexible solution to perform content switching and generally to take decisions based on content extracted from the request, the response or any environmental status. The actions generally consist in blocking a request, selecting a backend, or adding a header.

<b>ssl_fc</b> - Returns true when the front connection was made via an SSL/TLS transport layer and is locally deciphered.

<b>use_backend</b> - Switch to a specific backend if/unless an ACL-based condition is matched.

<b>option httpchk</b> - Enable HTTP protocol to check on the servers health.

<b>http-request deny</b> - This stops the evaluation of the rules and immediately rejects the request and emits an HTTP 403 error, or optionally the status code specified as an argument to "deny_status".

<b>ssl_c_s_dn</b> - When the incoming connection was made over an SSL/TLS transport layer, returns the full distinguished name of the subject of the certificate presented by the client when no <entry> is specified, or the value of the first given entry found from the beginning of the DN.

<b>ssl verify</b> - This option enables SSL ciphering on outgoing connections to the server. It is critical to verify server certificates using "verify" when using SSL to connect to servers, otherwise the communication is prone to trivial man in the-middle attacks rendering SSL useless.