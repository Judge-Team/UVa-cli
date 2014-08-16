require!<[winston ./config ./logger]>

logger.init-winston!

prog = require \commander
    .description 'Set UVa username and password'

prog.option '-v, --verbose' 'verbose mode'

prog.usage '[options] <user> [password]'

prog.parse process.argv

logger.verbose-winston prog.verbose

if prog.args.length != 1 and prog.args.length != 2
    # FIXME: Show help message
    winston.error prog._usage
    return

config.set-account prog.args.0, do
    password: prog.args.1
