const express = require("express");
const router = express.Router();
const executeQuery = require("../services/dbServices");
const sql = require("mssql/msnodesqlv8");

/* GET all conversations */
router.get("/", function (req, res, next) {
  executeQuery("dbo.Conversations_Get_All")
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

/* GET a conversation by id */
router.get("/:id(\\d+)", function (req, res, next) {
  const inputs = {
    Id: {
      type: sql.Int,
      val: req.params.id,
    },
  };

  executeQuery("dbo.Conversations_Get_ById", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

router.get("/title", function (req, res, next) {
  const inputs = {
    Query: {
      type: sql.NVarChar(sql.MAX),
      val: req.query.q,
    },
  };

  executeQuery("dbo.Conversations_Search_ByTitle", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

/* POST a conversation by id */
router.post("/create", function (req, res, next) {
  const inputs = {
    Title: {
      type: sql.NVarChar(sql.MAX),
      val: req.body.title,
    },
  };

  executeQuery("dbo.Conversations_Create", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

/* PUT an existing conversation */
router.put("/:id(\\d+)/update", function (req, res, next) {
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

  executeQuery("dbo.Conversations_Update_ById", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

/* DELETE a conversation */
router.delete("/:id(\\d+)/delete", function (req, res, next) {
  const inputs = {
    Id: {
      type: sql.Int,
      val: req.params.id,
    },
  };

  executeQuery("dbo.Conversations_Delete_ById", inputs)
    .then((records) => res.send(JSON.stringify(records)))
    .catch(console.error);
});

module.exports = router;
