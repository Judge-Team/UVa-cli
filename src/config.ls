require!<[fs mkdirp path winston js-yaml]>

const DEFAULT_CONFIG_PATH = path.join process.env.HOME, \.config, \uva-cli, \config.yaml

load = (opts) ->
    try
        cfg = js-yaml.safeLoad fs.readFileSync opts._cfg-path, \utf8
    catch e
        winston.info 'load config at %s, %s' opts._cfg-path, e.toString!

    if not cfg?
        # js-yaml.safeLoad might return undefined when document is empty.
        cfg = {}

    cfg

save = (cfg, opts) !->
    mkdirp.sync path.dirname opts._cfg-path
    fs.writeFileSync opts._cfg-path, js-yaml.safeDump cfg

set-default-opts = (opts) ->
    if not opts?
        opts = {}

    if not opts._cfg-path?
        opts._cfg-path = DEFAULT_CONFIG_PATH
    opts

module.exports.set-account = (username, opts) !->
    winston.info "set-account: username = #{username}"

    opts = set-default-opts opts

    cfg = load opts

    if not cfg.account?
        cfg.account = {}

    cfg.account.username = username
    # FIXME: ecrypt password here
    if opts.password?
        cfg.account.password = opts.password

    save cfg, opts

module.exports.get-account = (opts) ->
    winston.info "get-account"

    opts = set-default-opts opts

    cfg = load opts

    if cfg.account?
        return cfg.account

    {}

module.exports.get-account-uid = (username, opts, cb) !->
    winston.info "get-account-uid: username = #{username}"

    opts = set-default-opts opts

    cfg = load opts

    if not cfg.name2uid?
        cfg.name2uid = {}

    uid = cfg.name2uid[username]

    if uid?
        cb null, uid
    else
        cb new Error("No uid for #{username}"), null

module.exports.set-account-uid = (username, uid, opts, cb) !->
    winston.info "set-account-uid: username = #{username}, uid = #{uid}"

    opts = set-default-opts opts

    cfg = load opts

    if not cfg.name2uid?
        cfg.name2uid = {}

    cfg.name2uid[username] = uid

    save cfg, opts

    cb null
