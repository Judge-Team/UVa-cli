require!<[fs mkdirp path winston js-yaml]>

const CONFIG_PATH = path.join process.env.HOME, \.config, \uva-cli, \config.yaml

var config

load = !->
    if not config
        try
            config := jsYaml.safeLoad fs.readFileSync CONFIG_PATH, \utf8
        catch e
            winston.warn 'load config %s, %s' CONFIG_PATH, e.toString!

module.exports.add-account = (opts) !->
    winston.info "add-account, username = #{opts.username}, password = #{opts.password}, default = #{opts.default}"
    load!
    winston.error 'Not implemented'
