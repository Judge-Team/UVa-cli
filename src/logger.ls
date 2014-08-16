require!<[winston]>

module.exports.init-winston = !->
    winston.clear!
    winston.add winston.transports.Console, { level: \warn }

module.exports.verbose-winston = (verbose) !->
    if verbose
        winston.clear!
        winston.add winston.transports.Console, { level: \silly }
        winston.debug 'Verbose mode enabled'
