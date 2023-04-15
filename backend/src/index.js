const app = require('./app');
const { connect } = require('./database');

async function main() {
    //Database connection
    await connect();
    const ip = process.env.IP || '127.0.0.1';
    const port = process.env.PORT || 4000;
    // QUE ESCUCHE EN TODOS LOS PUERTOS NO SOLO EN EL 4000
    await app.listen(port,ip, () => {
        console.log(`Listening on port ${port}`);
    });
}

main();