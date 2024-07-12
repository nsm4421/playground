const { onRequest } = require("firebase-functions/v2/https")
const auth = require("firebase-auth")
const logger = require("firebase-functions/logger")

var admin = require("firebase-admin");
var serviceAccount = require("./hot-place-fd292-firebase-adminsdk-8g3u5-d5e50a0969.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});


exports.createToken = onRequest(async (req, res) => {
    try {
        // parsing request
        const data = req.body
        const provider = data.provider
        const uid = `${provider}:${data.uid}`
        const params = {
            email: data.email,
            profileImageUrl: data.profileImageUrl,
            username: data.username
        }
        // find by id
        await admin.auth().getUser(uid)
            // uid exist -> update
            .then(async (_) => {
                await admin.auth().updateUser(uid, params)
            })
            // uid not exist -> create
            .catch(async (_) => {
                await admin.auth().createUser({ ...params, uid })
            });

        const token = await admin.auth().createCustomToken(uid);

        res.status(200).send(token)
    } catch (err) {
        res.status(500).send(null)
    }
})
