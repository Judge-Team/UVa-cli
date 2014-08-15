require!<[fs fs-extra js-yaml path tmp]>
expect = require \chai .expect

app = require \..

describe 'config', (,) !->
    before !->
        app.logger.initWinston!

    describe 'set-account', (,) !->

        it 'set account, no password, config absence', (done) !->
            (err, dir, cb) <-! tmp.dir do
                unsafeCleanup: true

            if err
                throw err

            cfg-path = path.join dir, \set-account-no-password-config-absense.yaml
            username = \this-is-username

            app.config.set-account username, do
                _cfg-path: cfg-path

            cfg = js-yaml.safeLoad fs.readFileSync cfg-path, \utf-8

            expect cfg .to.deep.equal do
                account:
                    username: username

            cb!
            done!

        it 'set account, with password, config absence', (done) !->
            (err, dir, cb) <-! tmp.dir do
                unsafeCleanup: true

            if err
                throw err

            cfg-path = path.join dir, \set-account-with-password-config-absense.yaml
            username = \this-is-username
            password = \this-is-password

            app.config.set-account username, do
                password: password
                _cfg-path: cfg-path

            cfg = js-yaml.safeLoad fs.readFileSync cfg-path, \utf-8

            expect cfg .to.deep.equal do
                account:
                    username: username
                    password: password

            cb!
            done!

        it 'set account, no password, config present', (done) !->
            (err, dir, cb) <-! tmp.dir do
                unsafeCleanup: true

            if err
                throw err

            original-cfg-path = path.join __dirname, \data \set-account-config.yaml
            cfg-path = path.join dir, \update-exist-account.yaml

            fs-extra.copySync original-cfg-path, cfg-path

            username = \this-is-another-username
            password = \this-is-original-password

            app.config.set-account username, do
                _cfg-path: cfg-path

            cfg = js-yaml.safeLoad fs.readFileSync cfg-path, \utf-8

            expect cfg .to.deep.equal do
                account:
                    username: username
                    password: password

            cb!
            done!

        it 'set account, with password, config present', (done) !->
            (err, dir, cb) <-! tmp.dir do
                unsafeCleanup: true

            if err
                throw err

            original-cfg-path = path.join __dirname, \data \set-account-config.yaml
            cfg-path = path.join dir, \update-exist-account.yaml

            fs-extra.copySync original-cfg-path, cfg-path

            username = \this-is-another-username
            password = \this-is-another-password

            app.config.set-account username, do
                password: password
                _cfg-path: cfg-path

            cfg = js-yaml.safeLoad fs.readFileSync cfg-path, \utf-8

            expect cfg .to.deep.equal do
                account:
                    username: username
                    password: password

            cb!
            done!

    describe 'get-account', (,) !->

        it 'get account, config absence', (done) !->
            (err, dir, cb) <-! tmp.dir do
                unsafeCleanup: true

            if err
                throw err

            cfg-path = path.join dir, \get-account.yaml

            account = app.config.get-account do
                _cfg-path: cfg-path

            expect account .to.deep.equal {}

            cb!
            done!
