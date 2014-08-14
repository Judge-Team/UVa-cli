require!<[winston]>

module.exports.initWinston = !->
    winston.clear!
    winston.add winston.transports.Console, { level: \warn }

module.exports.verboseWinston = (verbose) !->
    if verbose
        winston.clear!
        winston.add winston.transports.Console, { level: \silly }
        winston.debug 'Verbose mode enabled'
