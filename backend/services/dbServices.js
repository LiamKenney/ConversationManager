const sql = require("mssql/msnodesqlv8");
const os = require("os");

const config = {
  server: `${os.hostname()}\\sqlexpress`,
  database: "ConversationManager",
  driver: "msnodesqlv8",
  options: {
    trustedConnection: true,
  },
};

const pool = new sql.ConnectionPool(config);

const executeQuery = (query, inputs) => {
  return pool
    .connect()
    .then((conn) => {
        let dbRequest = conn.request();
        for (let name in inputs) {
            const {type, val} = inputs[name];
            dbRequest = dbRequest.input(name, type, val);
        }
      return dbRequest.execute(query);
    })
    .then((dbResponse) => {
      return dbResponse.recordset;
    })
    .catch(console.error);
};

module.exports = executeQuery;
