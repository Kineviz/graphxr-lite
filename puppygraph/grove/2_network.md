<!--{"pinCode":false,"dname":"83314e30-ffd9-497f-888a-b4a40866fd4f","codeMode":"markdown"}-->
```md
### Vulnerable network interface and IP
```

<!--{"pinCode":false,"dname":"ebdbcff7-335c-4f71-92d5-7f2983c7e3e4","codeMode":"js"}-->
```js
md  `##### Find network interfaces that are not protected by any security group, along with their associated virtual machine instances (if any), as these interfaces may pose security risks.
Cypher:
\`\`\`
MATCH (ni:NetworkInterface)
OPTIONAL MATCH (sg:SecurityGroup)-[:PROTECTS]->(ni)
WITH ni, sg
WHERE sg IS NULL
OPTIONAL MATCH (ni)-[a:ATTACHED_TO]->(vm:VMInstance)
RETURN *

\`\`\`
`
```

<!--{"pinCode":false,"dname":"4fd0ed48-af11-4029-85b9-3c0742eef616","codeMode":"js"}-->
```js
Inputs.button(`Vulnerable Network Interface`, {reduce: async ()=>{
  await gxr.query(`MATCH (ni:NetworkInterface)
OPTIONAL MATCH (sg:SecurityGroup)-[:PROTECTS]->(ni)
WITH ni, sg
WHERE sg IS NULL
OPTIONAL MATCH (ni)-[a:ATTACHED_TO]->(vm:VMInstance)
RETURN *
`)
}} )
```

<!--{"pinCode":false,"dname":"e91a442e-d9bc-4942-86e8-313b207ba7ad","codeMode":"js"}-->
```js
md `---`
```

<!--{"pinCode":false,"dname":"5865dc09-7c01-4977-893c-88eec564f52a","codeMode":"js"}-->
```js
md `##### Next: Calculate degree, and arrange Network Interfaces odered by number of VM instances attached`
```

<!--{"pinCode":false,"dname":"66ffb4ab-b1b8-42cc-89fa-4ecf9a7ac8cf","codeMode":"js"}-->
```js
md  `##### Find all public IP addresses exposed to the internet, along with their associated virtual machine instances, security groups, subnets, VPCs, internet gateways, and users, displaying all these entities in the traversal path.
Cypher:
\`\`\`
MATCH (ip:PublicIP)<-[hp:HAS_PUBLIC_IP]-(ni:NetworkInterface)
MATCH (ni)<-[pr:PROTECTS]-(sg:SecurityGroup)
MATCH (sg)-[hr:HAS_RULE]->(rule:IngressRule)-[atf:ALLOWS_TRAFFIC_FROM]->(igRule:InternetGateway)
MATCH (ni)-[at:ATTACHED_TO]->(vm:VMInstance)
MATCH (ni)<-[hi:HOSTS_INTERFACE]-(subnet:Subnet)
MATCH (subnet)<-[con:CONTAINS]-(vpc:VPC)
MATCH (vpc)<-[gt:GATEWAY_TO]-(ig:InternetGateway)
MATCH (ig)<-[ac:ACCESS]-(user:User)
RETURN ip, hp, ni, hr, rule, atf, igRule,
       at, vm,
       hi, subnet, con, vpc, gt, ig, ac, user
LIMIT 1000
\`\`\`
`
```

<!--{"pinCode":false,"dname":"d5256e0a-f2ef-47b9-8ab3-c2849ab27c67","codeMode":"js"}-->
```js
Inputs.button("Vulnerable Public IP", {reduce: async ()=>{
  await gxr.query(`MATCH (ip:PublicIP)<-[hp:HAS_PUBLIC_IP]-(ni:NetworkInterface)
MATCH (ni)<-[pr:PROTECTS]-(sg:SecurityGroup)
MATCH (sg)-[hr:HAS_RULE]->(rule:IngressRule)-[atf:ALLOWS_TRAFFIC_FROM]->(igRule:InternetGateway)
MATCH (ni)-[at:ATTACHED_TO]->(vm:VMInstance)
MATCH (ni)<-[hi:HOSTS_INTERFACE]-(subnet:Subnet)
MATCH (subnet)<-[con:CONTAINS]-(vpc:VPC)
MATCH (vpc)<-[gt:GATEWAY_TO]-(ig:InternetGateway)
MATCH (ig)<-[ac:ACCESS]-(user:User)
RETURN ip, hp, ni, hr, rule, atf, igRule,
       at, vm,
       hi, subnet, con, vpc, gt, ig, ac, user
LIMIT 1000
`)
}} )
```

<!--{"pinCode":false,"dname":"ba15d775-8922-4457-92fb-541d80859f24","codeMode":"js"}-->
```js
md `<div style="display: flex; justify-content: space-between; font-size: 1.2em;">
  <a>${Link("1_userAnalysis.md", "User Analysis")}</a>
  <a>${Link("3_roleAndSecurity.md", "Role And Security")}</a>
</div>`
```
