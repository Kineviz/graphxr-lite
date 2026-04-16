<!--{"pinCode":false,"dname":"3930a7fa-88bf-49b7-bcf9-e642604b607d","codeMode":"js"}-->
```js
neo4jQueryToTable =async (query)=> {
  let res = await gxr.neo4j(query, {saveToGraph: false})

  return neo4jTableResultToJson(res)
  let arr= res.data
  arr.shift()
  return arr.map(
    elem=>({
      label: elem[0][0],
      count: elem[1].low
  }))
}
```

<!--{"pinCode":false,"dname":"5ee30880-69ec-4a9b-9834-ba7306faf2b9","codeMode":"js"}-->
```js
function neo4jTableResultToJson(result) {
  if (!result || !Array.isArray(result.data) || result.data.length < 2) {
    return [];
  }

  const headers = result.data[0]; // first row: column names
  const rows = result.data.slice(1); // remaining rows: values

  return rows.map(row => {
    const obj = {};
    for (let i = 0; i < headers.length; i++) {
      obj[headers[i]] = unpackNeoInt(row[i]);
    }
    return obj;
  });
}
```

<!--{"pinCode":false,"dname":"85a02a93-d75b-462d-83e4-06e67e71c88b","codeMode":"js"}-->
```js
function unpackNeoInt(val) {
  // Neo4j integer objects from browser (not neo4j-driver)
  if (val && typeof val === 'object' && 'low' in val && 'high' in val) {
    // Handles large numbers correctly
    return val.high * 2 ** 32 + val.low;
  }
  return val;
}
```

<!--{"pinCode":false,"dname":"18416841-6e1e-4fa2-a672-78949f63ac59","codeMode":"js"}-->
```js
sleep = async (ms)=>{
  return new Promise(resolve => setTimeout(resolve, ms))
}
```
