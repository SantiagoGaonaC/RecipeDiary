const app = require('./app');
const { connect } = require('./database');

async function main() {
    //Database connection
    await connect();
    const port = 4000;
    await app.listen(port, () => {
        console.log(`Listening on port ${port}`);
    });
}

main();