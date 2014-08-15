require!<[fs mkdirp path winston js-yaml]>

const DEFAULT_CONFIG_PATH = path.join process.env.HOME, \.config, \uva-cli, \config.yaml

load = (opts) ->
    try
        cfg = js-yaml.safeLoad fs.readFileSync opts.cfg_path, \utf8
    catch e
        winston.info 'load config at %s, %s' opts.cfg_path, e.toString!

    if not cfg?
        # js-yaml.safeLoad might return undefined when document is empty.
        cfg = {}

    cfg

save = (cfg, opts) !->
    mkdirp.sync path.dirname opts.cfg_path
    fs.writeFileSync opts.cfg_path, js-yaml.safeDump cfg

set-opts-default = (opts) ->
    if not opts.cfg_path?
        opts.cfg_path = DEFAULT_CONFIG_PATH
    opts

module.exports.add-account = (username, opts) !->
    winston.info "add-account: username = #{username}"

    opts = set-opts-default opts

    cfg = load opts

    if not cfg.account?
        cfg.account = {}

    cfg.account.username = username
    # FIXME: ecrypt password here
    if opts.password?
        cfg.account.password = opts.password

    save cfg, opts
