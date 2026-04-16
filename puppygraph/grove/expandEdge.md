<!--{"pinCode":false,"dname":"03f4e1bd-d3a1-490a-be03-9874b8b43f72","codeMode":"markdown"}-->
```md
### Convert edges to nodes
```

<!--{"pinCode":false,"dname":"c9e15216-5a52-42cd-b91f-a1c8864aec13","codeMode":"js"}-->
```js
viewof relationship = Inputs.select(_.uniq(gxr.edges().map(n=>n.relationship)))
```

<!--{"pinCode":false,"dname":"6144f404-2c36-417f-b54c-dadef27502d0","codeMode":"js"}-->
```js
relationship
```

<!--{"pinCode":false,"dname":"c4263d78-18c1-4b09-a247-016326c77cbc","codeMode":"js"}-->
```js
Inputs.button('Convert ACCESS_RECORD to Nodes', {
  reduce: ()=>{expandEdge("ACCESS_RECORD")}
})
```

<!--{"pinCode":true,"dname":"dc6ca7cc-65ee-4bfe-bb2b-91898d32a18a","codeMode":"js"}-->
```js
expandEdge = async (relationship) =>
{
  let edges = gxr.edges({relationship}).values()
  let nodesData = edges.map(n=>{
  return {id: n.properties._id, category: "AccessRecord", 
         properties: n.properties}
  })
  await gxr.add(nodesData)
  
  let edgesData = edges.map(n=>{
    return {sourceId:n.properties._inV,
           targetId: n.properties._id,
           relationship: "FROM_USER"}
  })
  await gxr.add(edgesData)
  await gxr.sleep(300)
  edgesData = edges.map(n=>{
    return {sourceId:n.properties._id,
           targetId: n.properties._outV,
           relationship: "TO_GATEWAY"}
  })
  await gxr.add(edgesData)
 await gxr.sleep(500)
  await gxr.edges({relationship:"ACCESS_RECORD"}).remove()
}
```
