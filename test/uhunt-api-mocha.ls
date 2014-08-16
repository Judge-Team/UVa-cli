require!<[fs fs-extra js-yaml path tmp]>
expect = require \chai .expect

app = require \..

describe 'uhunt-api', (,) !->

    before !->
        app.logger.init-winston!

    describe 'get-uid-by-name', (,) !->

        it 'valid name', (done) !->
            # FIXME: Shall not connect to uhunt.felix-halim.net during testing
            (err, uid) <- app.uhunt-api.get-uid-by-name \czchen {}
            expect err .to.be.null
            expect uid .to.equal \571324
            done!
