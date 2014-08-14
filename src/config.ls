require!<[fs mkdirp path winston js-yaml]>

const DEFAULT_CONFIG_PATH = path.join process.env.HOME, \.config, \uva-cli, \config.yaml

load = (opts) ->
    try
        cfg = jsYaml.safeLoad fs.readFileSync opts.cfg_path, \utf8
    catch e
        winston.info 'load config at %s, %s' opts.cfg_path, e.toString!

    if not cfg?
        # jsYaml.safeLoad might return undefined when document is empty.
        cfg = {}

    cfg

save = (opts) !->
    mkdirp.sync path.dirname opts.cfg_path
    fs.writeFileSync opts.cfg_path, jsYaml.safeDump opts.cfg

set-opts-default = (opts) ->
    if not opts.cfg_path?
        opts.cfg_path = DEFAULT_CONFIG_PATH
    opts

module.exports.add-account = (opts) !->
    winston.info "add-account: username = #{opts.username}, password = #{opts.password}, default = #{opts.default}"

    opts = set-opts-default opts

    cfg = load opts

    if not cfg.account?
        cfg.account = {}

    if not cfg.account[opts.username]?
        cfg.account[opts.username] = {}

    if opts.password?
        cfg.account[opts.username].password = opts.password

    if opts.default
        if not cfg.config?
            cfg.config = {}
        winston.info "set default account to #{opts.username}"
        cfg.config.default_account = opts.username

    opts.cfg = cfg

    save opts
