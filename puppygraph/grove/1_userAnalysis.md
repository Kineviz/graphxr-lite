<!--{"pinCode":false,"dname":"411f33dd-b4b9-496b-a3ea-266dba04b34b","codeMode":"markdown"}-->
```md
### User Analysis
```

<!--{"pinCode":false,"dname":"49d73a83-5539-484f-a61b-0aa631e31243","codeMode":"js","hide":true}-->
```js
user_data = {
  let data = await neo4jQueryToTable(`MATCH (n:User) 
OPTIONAL MATCH (n)-[r:ACCESS_RECORD]->(ig:InternetGateway)
WITH n, count(r) AS accessCount
return n.email as email, n.username as username, n.last_login as last_login, n.failed_login_attempts as failed_login_attempts, n.account_status as account_status, accessCount`)
  return data.map(d=>({...d, last_login: dateobj2isodate(d.last_login)}))
}
```

<!--{"pinCode":false,"dname":"c4ddc664-b650-412d-a898-79ef24487b50","codeMode":"js"}-->
```js
viewof sel_users = Inputs.table(user_data, {
  required:false,
  multiple: false,
  columns:["username", "account_status", "accessCount", "failed_login_attempts", "last_login", "email" ]
})
```

<!--{"pinCode":false,"dname":"d7028a9d-f795-4a50-81f5-9c9e7bd0b6e9","codeMode":"js","hide":true}-->
```js
username = sel_users ? sel_users.username : "null"
```

<!--{"pinCode":false,"dname":"3af775c9-8c61-44ed-b816-b0e31ed92601","codeMode":"js"}-->
```js
Inputs.button(`Retrieve All Access Records for User ${username}`, {reduce: async ()=>{
  let query = `MATCH (u:User)-[r:ACCESS_RECORD]->(ig:InternetGateway)
WHERE u.username="${username}" 
RETURN *`
  console.log(query)
  await gxr.query(query, {saveToGraph: true})
  await gxr.sleep(300)
  await expandEdge("ACCESS_RECORD")
  await gxr.sleep(300)
  gxr.forceLayout()
}})
```

<!--{"pinCode":false,"dname":"eda9828b-71b5-434c-99d4-efe637e801eb","codeMode":"js"}-->
```js
md `<div style="display: flex; font-size: 1.4em;">
  <a>${Link("timeline.md", "Next: Plot timeline")} </a>
</div>`
```


<!--{"pinCode":false,"dname":"eda9828b-71b5-434c-99d4-efe637e701eb","codeMode":"js"}-->
```js
md `<div style="display: flex; justify-content: space-between; font-size: 1.2em;">
  <a>${Link("0_overview.md", "Overview")} </a>
  <a>${Link("2_network.md", "Network")}</a>
</div>`
```

<!--{"pinCode":false,"dname":"52fce777-f2df-4a1b-ad47-9780fac6464c","codeMode":"js","hide":true}-->
```js
md `#### Appendix`
```

<!--{"pinCode":false,"dname":"ed32d9d9-6d6e-4b90-a8d3-7a979f746095","codeMode":"js","hide":true}-->
```js
// Add SightXR group
// Add "Inspect" to SightXR group
gxr.addContextMenuItem(
  {
    name: 'Timeline',
    text: 'Timeline',
    icon: 'fa fa-clock',
    hide: () => false,
    enable: () => true,
    action: (name, nodeId) => {
      plotTimeline('access_time')
    },
  },
  {
    after: 'NodeEdgeInformation',
  }
);
```

<!--{"pinCode":false,"dname":"b820870b-c679-487d-a759-34f60f5808d1","codeMode":"js","hide":true}-->
```js
dateobj2isodate = (obj)=>{
	let date = new Date(obj.year.low, obj.month.low, obj.day.low, obj.hour.low, obj.minute.low, obj.second.low)
    return date.toISOString()
}
```

<!--{"pinCode":false,"dname":"89478fa0-c716-41a3-98e6-af2534022394","codeMode":"js","hide":true}-->
```js
import {expandEdge} from 'expandEdge.md'
```

<!--{"pinCode":false,"dname":"6bbe9eb2-c146-47f8-8e59-0d2d095a05bf","codeMode":"js","hide":true}-->
```js
import {plotTimeline} from 'timeline.md'
```

<!--{"pinCode":false,"dname":"ee12cec3-7cc8-427c-bdb8-4bfb86f03329","codeMode":"js","hide":true}-->
```js
import {neo4jQueryToTable} from 'neo4jUtilities.md'
```
