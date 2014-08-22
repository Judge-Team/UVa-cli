require!<[http winston]>

config = do
    hostname: \uhunt.felix-halim.net
    port: 80
    path: \/api

module.exports._inject-config = (new-config) ->
    config <<< new-config

get-req-opts = (query) ->
    do
        hostname: config.hostname
        port: config.port
        path: config.path ++ query

module.exports.get-uid-by-name = (name, callback) ->
    winston.info 'get-uid-by-name: name = %s' name

    req-opts = get-req-opts \/uname2uid/ ++ name

    req = http.request req-opts, (res) ->
        res.on \data (data) ->
            callback null, data.toString!

    req.on \error (err) ->
        callback err, null

    req.end!
