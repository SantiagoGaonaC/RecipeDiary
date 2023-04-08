const app = require('./app');

async function main() {
    const port = 4000;
    await app.listen(port, () => {
        console.log(`Listening on port ${port}`);
    });
}

main();