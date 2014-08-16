require!<[fibers http winston]>

set-opts-default = (opts) ->
    if not opts?
        opts = {}

    if not opts._api_prefix?
        opts._host = \uhunt.felix-halim.net
        opts._port = 80
        opts._api_prefix = \/api

    opts

get-req-opts = (query, opts) ->
    do
        hostname: opts._host
        path: opts._api_prefix ++ query
        port: 80


module.exports.get-uid-by-name = (name, opts, callback) ->
    winston.info 'get-uid-by-name: name = %s' name

    opts = set-opts-default opts
    req-opts = get-req-opts \/uname2uid/ ++ name, opts

    req = http.request req-opts, (res) ->
        res.on \data (data) ->
            callback null, data.toString!

    req.on \error (err) ->
        callback err, null

    req.end!
