require!<[fs mkdirp path winston js-yaml]>

config = do
    cfg-path : path.join process.env.HOME, \.config, \uva-cli, \config.yaml

module.exports._inject-config-path = (value) !->
    config.cfg-path = value

load = ->
    try
        cfg = js-yaml.safe-load fs.read-file-sync config.cfg-path, \utf8
    catch e
        winston.info 'load config at %s, %s' config.cfg-path, e.toString!

    if not cfg?
        # js-yaml.safeLoad might return undefined when document is empty.
        cfg = {}

    cfg

save = (cfg) !->
    mkdirp.sync path.dirname config.cfg-path
    fs.write-file-sync config.cfg-path, js-yaml.safe-dump cfg

module.exports.set-account = (username, opts) !->
    winston.info "set-account: username = #{username}"

    cfg = load!

    if not cfg.account?
        cfg.account = {}

    cfg.account.username = username
    # FIXME: ecrypt password here
    if opts? and opts.password?
        cfg.account.password = opts.password

    save cfg

module.exports.get-account = (opts) ->
    winston.info "get-account"

    cfg = load!

    if cfg.account?
        return cfg.account

    {}

module.exports.get-account-uid = (username, cb) !->
    winston.info "get-account-uid: username = #{username}"

    cfg = load!

    if not cfg.name2uid?
        cfg.name2uid = {}

    uid = cfg.name2uid[username]

    if uid?
        cb null, uid
    else
        cb new Error("No uid for #{username}"), null

module.exports.set-account-uid = (username, uid, cb) !->
    winston.info "set-account-uid: username = #{username}, uid = #{uid}"

    cfg = load!

    if not cfg.name2uid?
        cfg.name2uid = {}

    cfg.name2uid[username] = uid

    save cfg

    cb null
