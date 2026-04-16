<!--{"pinCode":false,"dname":"3cd0cc7b-0038-4901-8a98-991a48735030","codeMode":"markdown"}-->
```md
### Role and Security Group
```

<!--{"pinCode":false,"dname":"5f0fceb7-c4ed-4894-82ee-dc88d1da748a","codeMode":"js"}-->
```js
md  `##### Find roles that have been granted excessive access permissions, along with their associated virtual machine instances.
Cypher:
\`\`\`
MATCH (r:Role)-[:ALLOWS_ACCESS_TO]->(res:Resource)
WITH r, count(res) AS permissionCount
WHERE permissionCount > 4
MATCH path = (vm:VMInstance)-[ar:ASSIGNED_ROLE]->(r)-
    [at:ALLOWS_ACCESS_TO]->(res:Resource)
RETURN vm,ar,r,at,res
\`\`\`
`
```

<!--{"pinCode":false,"dname":"ccc81b72-bb0d-4d21-a078-613b68fd50d5","codeMode":"js"}-->
```js
Inputs.button("Role with Excessive Access", {reduce: ()=>{
  gxr.query(`MATCH (r:Role)-[:ALLOWS_ACCESS_TO]->(res:Resource)
WITH r, count(res) AS permissionCount
WHERE permissionCount > 4
MATCH path = (vm:VMInstance)-[ar:ASSIGNED_ROLE]->(r)-[at:ALLOWS_ACCESS_TO]->(res:Resource)
RETURN vm,ar,r,at,res`)
}})
```

<!--{"pinCode":false,"dname":"18d7659f-9778-4435-89f3-cf6601a84d0e","codeMode":"js"}-->
```js
md `---`
```

<!--{"pinCode":false,"dname":"70dbecc6-dcc0-42db-a151-8d8cf6d5062e","codeMode":"js"}-->
```js
md  `##### Find security groups that have ingress rules permitting traffic from any IP address (0.0.0.0/0) to sensitive ports (22 or 3389), and retrieve the associated ingress rules, network interfaces, and virtual machine instances in the traversal path.
Cypher:
\`\`\`
MATCH (sg:SecurityGroup)-[hr:HAS_RULE]->(rule:IngressRule)
WHERE rule.source = '0.0.0.0/0' AND rule.port_range IN ['22','3389']
MATCH (sg)-[p:PROTECTS]->(ni:NetworkInterface)
MATCH (ni)-[at:ATTACHED_TO]->(vm:VMInstance)
RETURN sg, hr, rule, p, ni, at, vm
\`\`\`
`
```

<!--{"pinCode":false,"dname":"a366219f-73ee-43b0-9906-36ca415b42c6","codeMode":"js"}-->
```js
Inputs.button("Weak Security Groups", {reduce: ()=>{
  gxr.query(`MATCH (sg:SecurityGroup)-[hr:HAS_RULE]->(rule:IngressRule)
WHERE rule.source = '0.0.0.0/0' AND rule.port_range IN ['22','3389']
MATCH (sg)-[p:PROTECTS]->(ni:NetworkInterface)
MATCH (ni)-[at:ATTACHED_TO]->(vm:VMInstance)
RETURN sg, hr, rule, p, ni, at, vm`)
}})
```

<!--{"pinCode":false,"dname":"f9248b6d-4e4b-4ed2-bf1d-7b7902cfd5ff","codeMode":"js"}-->
```js
md `<div style="display: flex; justify-content: space-between; font-size: 1.2em;">
  <a>${Link("2_network.md", "Network")}</a>
  <a></a>
</div>`
```
