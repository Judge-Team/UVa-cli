require!<[winston ./config ./logger]>

logger.initWinston!

prog = require \commander
    .description 'Set UVa username and password'

prog.option '-v, --verbose' 'verbose mode'
prog.option '-d, --default' 'set as default account'

prog.usage '[options] <user> [password]'

prog.parse process.argv

logger.verboseWinston prog.verbose

if prog.args.length != 1 and prog.args.length != 2
    # FIXME: Show help message
    winston.error prog._usage
    return

config.add-account do
    username: prog.args.0
    password: prog.args.1
    default: prog.default || false
