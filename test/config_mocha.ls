require!<[fs fs-extra js-yaml path tmp]>
expect = require \chai .expect

app = require \..

describe 'add-account', (,) !->
    before !->
        app.logger.initWinston!

    it 'add new account, no password, config absence', (done) !->
        (err, dir, cb) <-! tmp.dir do
            unsafeCleanup: true

        if err
            throw err

        cfg-path = path.join dir, \add-new-account-no-password-config-absense.yaml
        username = \this-is-username

        app.config.add-account username, do
            cfg_path: cfg-path

        cfg = js-yaml.safeLoad fs.readFileSync cfg-path, \utf-8

        expect cfg .to.deep.equal do
            account:
                username: username

        cb!
        done!

    it 'add new account, with password, config absence', (done) !->
        (err, dir, cb) <-! tmp.dir do
            unsafeCleanup: true

        if err
            throw err

        cfg-path = path.join dir, \add-new-account-with-password-config-absense.yaml
        username = \this-is-username
        password = \this-is-password

        app.config.add-account username, do
            password: password
            cfg_path: cfg-path

        cfg = js-yaml.safeLoad fs.readFileSync cfg-path, \utf-8

        expect cfg .to.deep.equal do
            account:
                username: username
                password: password

        cb!
        done!

    it 'update exist account, no password, config present', (done) !->
        (err, dir, cb) <-! tmp.dir do
            unsafeCleanup: true

        if err
            throw err

        original-cfg-path = path.join __dirname, \data \add-account-config.yaml
        cfg-path = path.join dir, \update-exist-account.yaml

        fs-extra.copySync original-cfg-path, cfg-path

        username = \this-is-another-username
        password = \this-is-original-password

        app.config.add-account username, do
            cfg_path: cfg-path

        cfg = js-yaml.safeLoad fs.readFileSync cfg-path, \utf-8

        expect cfg .to.deep.equal do
            account:
                username: username
                password: password

        cb!
        done!

    it 'update exist account, with password, config present', (done) !->
        (err, dir, cb) <-! tmp.dir do
            unsafeCleanup: true

        if err
            throw err

        original-cfg-path = path.join __dirname, \data \add-account-config.yaml
        cfg-path = path.join dir, \update-exist-account.yaml

        fs-extra.copySync original-cfg-path, cfg-path

        username = \this-is-another-username
        password = \this-is-another-password

        app.config.add-account username, do
            password: password
            cfg_path: cfg-path

        cfg = js-yaml.safeLoad fs.readFileSync cfg-path, \utf-8

        expect cfg .to.deep.equal do
            account:
                username: username
                password: password

        cb!
        done!
