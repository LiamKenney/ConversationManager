import axios from "axios";

const cAxios = axios.create({
  baseURL: `http://localhost:8080/messages/`,
});

const globalHandler = (config) => {
  return cAxios(config).then(handleSuccess).catch(handleError);
};

const handleSuccess = (res) => {
  if (res.data) {
    res.data = res.data.map((datum) => {
        let newDatum = {};
      if (datum["DateCreated"]) {
        datum["DateCreated"] = new Date(datum["DateCreated"]).toLocaleString();
      }
      if (datum["DateModified"]) {
        datum["DateModified"] = new Date(datum["DateModified"]).toLocaleString();
      }
      for (let key in datum) {
          const newKey = key[0].toLowerCase() + key.slice(1);
          newDatum[newKey] = datum[key];
      }
      return newDatum;
    });
  }
  return res.data;
};

const handleError = (err) => {
  return Promise.reject(err);
};

const create = (data) => {
  const config = {
    url: "create",
    method: "POST",
    headers: { "Content-Type": "application/json" },
    data,
  };

  return globalHandler(config);
};

const selectAll = () => {
  const config = {
    url: "",
    method: "GET",
    headers: { "Content-Type": "application/json" },
  };

  return globalHandler(config);
};

const selectById = (id) => {
  const config = {
    url: `${id}`,
    method: "GET",
    headers: { "Content-Type": "application/json" },
  };

  return globalHandler(config);
};

const selectByConversationId = (cid) => {
  const config = {
    url: "",
    method: "GET",
    headers: { "Content-Type": "application/json" },
    params: { cid },
  };

  return globalHandler(config);
};

const update = (id, data) => {
  const config = {
    url: `${id}/update`,
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    data,
  };

  return globalHandler(config);
};

const remove = (id) => {
  const config = {
    url: `${id}/delete`,
    method: "DELETE",
    headers: { "Content-Type": "application/json" },
  };

  return globalHandler(config);
};

export default {
  create,
  selectAll,
  selectById,
  selectByConversationId,
  update,
  remove,
};
