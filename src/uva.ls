require!<[pkginfo winston ./logger]>

logger.initWinston!

pkginfo module, \version

prog = require \commander

prog.version module.exports.version
prog.option '-v, --verbose' 'verbose mode'

prog.command 'add'
    .description 'add user'

prog.command 'status'
    .description 'show status of user'

prog.command 'submit'
    .description 'submit to UVa'

prog.parse process.argv

logger.verboseWinston prog.verbose
