const express = require("express");
const router = express.Router();
const executeQuery = require("../services/dbServices");
const sql = require("mssql/msnodesqlv8");

/* GET all Messages */
router.get("/", function (req, res, next) {
  let inputs = {},
    proc = "dbo.Messages_Get_All";
  if (Object.keys(req.query).length >= 0 && req.query.cid) {
    inputs = {
      ConversationId: {
        type: sql.Int,
        val: req.query.cid,
      },
    };
    proc = "dbo.Messages_Get_ByConversationId";
  }
  executeQuery(proc, inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

/* GET a Message by id */
router.get("/:id(\\d+)", function (req, res, next) {
  const inputs = {
    Id: {
      type: sql.Int,
      val: req.params.id,
    },
  };

  executeQuery("dbo.Messages_Get_ById", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

/* POST a message by id */
router.post("/create", function (req, res, next) {
  const inputs = {
    Text: {
      type: sql.NVarChar(sql.MAX),
      val: req.body.text,
    },
    ConversationId: {
      type: sql.Int,
      val: req.body.cid,
    },
  };

  executeQuery("dbo.Messages_Create", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

/* PUT an existing Message */
router.get("/:id(\\d+)/update", function (req, res, next) {
  const inputs = {
    Id: {
      type: sql.Int,
      val: req.params.id,
    },
    Text: {
      type: sql.NVarChar(sql.MAX),
      val: req.body.text,
    },
  };

  executeQuery("dbo.Messages_Update_ById", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

/* DELETE a Message */
router.get("/:id(\\d+)/delete", function (req, res, next) {
  const inputs = {
    Id: {
      type: sql.Int,
      val: req.params.id,
    },
  };

  executeQuery("dbo.Messages_Delete_ById", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

module.exports = router;
