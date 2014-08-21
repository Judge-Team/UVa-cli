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

    describe 'set-account-uid', (,) !->

        it 'set account uid, config absense', (done) !->
            (err, dir, tmp-dir-cb) <-! tmp.dir do
                unsafe-cleanup: true

            if err
                throw err

            username = \this-is-username
            uid = 0xdeadbeef

            cfg-path = path.join dir, \set-account-uid.yaml

            (err) <- app.config.set-account-uid username, uid, do
                _cfg-path: cfg-path

            expect err .to.be.null

            (err, res) <- app.config.get-account-uid username, do
                _cfg-path: cfg-path

            expect err .to.be.null

            expect res .to.equal uid

            tmp-dir-cb!
            done!

        it 'set account uid, config present', (done) !->
            (err, dir, tmp-dir-cb) <-! tmp.dir do
                unsafe-cleanup: true

            if err
                throw err

            username = \this-is-username
            uid = 0xdeadbeef

            original-cfg-path = path.join __dirname, \data \set-account-uid.yaml
            cfg-path = path.join dir, \set-account-uid.yaml

            fs-extra.copySync original-cfg-path, cfg-path

            (err) <- app.config.set-account-uid username, uid, do
                _cfg-path: cfg-path

            expect err .to.be.null

            (err, res) <- app.config.get-account-uid username, do
                _cfg-path: cfg-path

            expect err .to.be.null

            expect res .to.equal uid

            tmp-dir-cb!
            done!

    describe 'get-account-uid', (,) !->

        it 'get account uid, config absense', (done) !->
            (err, dir, tmp-dir-cb) <-! tmp.dir do
                unsafe-cleanup: true

            if err
                throw err

            username = \this-is-username
            uid = 0xdeadbeef

            cfg-path = path.join dir, \get-account-uid.yaml

            (err, res) <- app.config.get-account-uid username, do
                _cfg-path: cfg-path

            expect err .not.to.be.null

            expect res .to.be.null

            tmp-dir-cb!
            done!

        it 'get account uid, config present', (done) !->

            username = \this-is-username
            uid = 12345678

            cfg-path = path.join __dirname, \data \get-account-uid.yaml

            (err, res) <- app.config.get-account-uid username, do
                _cfg-path: cfg-path

            expect err .to.be.null

            expect res .to.equal uid

            done!
