const express = require("express");
const router = express.Router();
const executeQuery = require("../services/dbServices");
const sql = require("mssql/msnodesqlv8");

/* GET all Thoughts */
router.get("/", function (req, res, next) {
  let inputs = {},
    proc = "dbo.Thoughts_Get_All";
  if (Object.keys(req.query).length >= 0 && req.query.mid) {
    inputs = {
      MessageId: {
        type: sql.Int,
        val: req.query.mid,
      },
    };
    proc = "dbo.Thoughts_Get_ByMessageId";
  }
  executeQuery(proc, inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

/* GET a Thought by id */
router.get("/:id(\\d+)", function (req, res, next) {
  const inputs = {
    Id: {
      type: sql.Int,
      val: req.params.id,
    },
  };

  executeQuery("dbo.Thoughts_Get_ById", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

/* POST a Thought by id */
router.post("/create", function (req, res, next) {
  const inputs = {
    Text: {
      type: sql.NVarChar(sql.MAX),
      val: req.body.text,
    },
    MessageId: {
      type: sql.Int,
      val: req.body.mid,
    },
  };

  executeQuery("dbo.Thoughts_Create", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

/* PUT an existing Thought */
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

  executeQuery("dbo.Thoughts_Update_ById", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

/* DELETE a Thought */
router.get("/:id(\\d+)/delete", function (req, res, next) {
  const inputs = {
    Id: {
      type: sql.Int,
      val: req.params.id,
    },
  };

  executeQuery("dbo.Thoughts_Delete_ById", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

module.exports = router;
