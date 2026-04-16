<!--{"pinCode":false,"dname":"b8823d14-fb0e-4a2f-b8f1-5be9f2266759","codeMode":"markdown"}-->
```md
### Puppygraph Security Graph Demo. 
This demo showcases how to analyze and visualize network security configurations within a cloud environment using PuppyGraph's powerful graph querying capabilities.

By modeling the network infrastructure as a graph, users can identify potential security risks, such as:

* Public IP addresses exposed to the internet
* Network interfaces not protected by any security group
* Roles granted excessive access permissions
* Security groups with overly permissive ingress rules

<a href="https://github.com/puppygraph/puppygraph-getting-started/tree/main/use-case-demos/cloud-security-graph-demo" target="_blank">Github Repository</a>
```

<!--{"pinCode":false,"dname":"f99998b0-9486-44e0-aa75-76502bd77a36","codeMode":"js"}-->
```js
md `##### Display Schema
Cypher:  
\`\`\`
:schema
\`\`\`
`
```

<!--{"pinCode":false,"dname":"ea576d82-5bc8-4d3d-84d6-b5e73ef55604","codeMode":"js"}-->
```js
Inputs.button("Show Schema", {reduce: async ()=>{
  await gxr.query(":schema")
  await gxr.sleep(2000)
  gxr.nodes().array.forEach(n=>n.properties.label = n.category)
  gxr.edges().array.forEach(n=>n.properties.label = n.relationship)
  
}})
```

<!--{"pinCode":false,"dname":"6ddb5bce-5986-4a85-8d5d-acd0eea20d97","codeMode":"js"}-->
```js
md `---`
```

<!--{"pinCode":false,"dname":"874f69b9-83ee-4e02-9b72-eefa628d1f9a","codeMode":"js"}-->
```js
md  `##### Trace Admin Access Paths from Users to Internet Gateways. 
Cypher:
\`\`\`
MATCH path = (u:User)-[r:ACCESS {access_level: 'admin'}]->(ig:InternetGateway)  
RETURN u,r,ig
\`\`\`
`
```

<!--{"pinCode":false,"dname":"a03c7396-ac2b-4937-b767-cd952bd11f0e","codeMode":"js"}-->
```js
Inputs.button('Tracing Admin Access Paths from Users to Internet Gateways', {reduce: async ()=>{
  await gxr.query(`MATCH path = (u:User)-[r:ACCESS {access_level: 'admin'}]->(ig:InternetGateway)
RETURN u,r,ig`, {saveToGraph: true})
}})
```

<!--{"pinCode":false,"dname":"f6d23e27-6dde-455b-be65-00821f16b079","codeMode":"js"}-->
```js
md `<div style="display: flex; justify-content: space-between; font-size: 1.2em;">
  <a> </a>
  <a>${Link("1_userAnalysis.md", "User Analysis")}</a>
</div>`
```

<!--{"pinCode":false,"dname":"b1b0163b-94a4-4ec2-82b0-46c3810eb63e","codeMode":"js","hide":true}-->
```js
md `###### 2. Retrieve All Access Records for User (user_id=123)`
```

<!--{"pinCode":false,"dname":"6b0a1357-0ab7-4a49-b6df-ae43b91b3dd0","codeMode":"js","hide":true}-->
```js
Inputs.button('Retrieve All Access Records for User (user_id=123)', {reduce: async ()=>{
  await gxr.query(`MATCH (u:User)-[r:ACCESS_RECORD]->(ig:InternetGateway)
WHERE id(u)="User[100]" AND r.access_time > datetime("2024-12-01T00:00:00")
RETURN *`, {saveToGraph: true})
}})
```

<!--{"pinCode":false,"dname":"f69f7510-fc48-4dd7-8dcb-2dba5b6a42da","codeMode":"js", "hide":true}-->
```js
{
 window.groveConfig = {};
 window.groveConfig.authContent=false;
}
```
